#!/bin/sh
################################################################################
# 自定义配置
###############################################################################
# Debug模式编译是否上传，1＝上传 0＝不上传，默认不上传
UPLOAD_DEBUG_SYMBOLS=0

# 模拟器编译是否上传，1＝上传，0＝不上传，默认不上传
UPLOAD_SIMULATOR_SYMBOLS=0

# APMInsightID：应用在APMInsight平台的ID
APMInsight_APP_ID="XXX"

################################################################################
# 注意: 如果你不知道此脚本的执行流程和用法，请不要随便修改！
################################################################################

DSYM_UPLOAD_URL="https://datarangers.com.cn/perfguard/api/guest/app/mapping/upload"

if [[ $APMInsight_APP_ID == "XXX" ]]; then
    if [[ $1 ]]; then
        echo "APPID: $1"
        APMInsight_APP_ID=$1
    else
        echo "No arguments, pass your APMInsightID as the first argument or modify 'APMInsight_APP_ID' in the script."
        exit 0
    fi
fi

function main() {
    # 退出执行并打印提示信息
    warningWithMessage() {
        echo "--------------------------------"
        echo -e "${1}"
        echo "--------------------------------"
        echo "No upload and over."
        echo "----------------------------------------------------------------"
        UPLOADFLAG=0
        exit ${2}
    }
    
    UPLOADFLAG=1
    
    echo "Uploading dSYM to APMInsight."
    
    echo "--------------------------------"
    echo "Step 1: Prepare application information."
    echo "--------------------------------"
    
    echo "Product Name: ${PRODUCT_NAME}"
    echo "APMInsight App ID: ${APMInsight_APP_ID}"
    
    echo "--------------------------------"
    echo "Step 2: Check the arguments ..."
    echo "--------------------------------"
    
    ##检查模拟器是否允许上传符号
    if [ "$EFFECTIVE_PLATFORM_NAME" == "-iphonesimulator" ]; then
        if [[ $UPLOAD_SIMULATOR_SYMBOLS -eq 0 ]]; then
            warningWithMessage "Warning: Build for simulator and skipping to upload. \nYou can modify 'UPLOAD_SIMULATOR_SYMBOLS' to 1 in the script." 0
        fi
    fi
    
    # 检查DEBUG模式是否允许上传符号
    if [[ ${CONFIGURATION=} == Debug* ]]; then
        if [[ $UPLOAD_DEBUG_SYMBOLS -eq 0 ]]; then
            warningWithMessage "Warning: Build for debug mode and skipping to upload. \nYou can modify 'UPLOAD_DEBUG_SYMBOLS' to 1 in the script." 0
        fi
    fi
    
    # 检查必须参数是否设置
    if [ ! "${APMInsight_APP_ID}" ]; then
        warningWithMessage "Error: APMInsight App ID not defined." 1
    fi
    
    function uploadDSYM() {
        DSYM_SRC="$1"
        if [ ! -d "$DSYM_SRC" ]; then
            warningWithMessage "dSYM source not found: ${DSYM_SRC}" 1
        fi
        
        APPID="${APMInsight_APP_ID}"
        
        ZIP_DIR_PATH=$(dirname ${DSYM_SRC})
        FILENAME=$(basename ${DSYM_SRC})
        DSYM_SYMBOL_OUT_ZIP_NAME="APMInsight_dSYM_${APPID}.zip"
        DSYM_ZIP_FPATH="${ZIP_DIR_PATH}/${DSYM_SYMBOL_OUT_ZIP_NAME}"
        cd "${ZIP_DIR_PATH}"
        PAD=$(zip -r ${DSYM_SYMBOL_OUT_ZIP_NAME} ${FILENAME})
        
        if [ ! -e "${DSYM_ZIP_FPATH}" ]; then
            warningWithMessage "no dSYM zip archive generated: ${DSYM_ZIP_FPATH}" 1
        fi
        
        FILESIZE=$(/usr/bin/stat -f%z ${DSYM_ZIP_FPATH})
        echo "dsym size: ${FILESIZE} bytes"
        
        echo "--------------------------------"
        echo "Step 3: Upload the zipped dSYM file."
        echo "--------------------------------"
        MD5ZIP=$(md5 -q ${DSYM_ZIP_FPATH})
        if [ ! ${#MD5ZIP} -eq 32 ]; then
            warningWithMessage "Error: Failed to caculate md5 of zipped file." 1
        fi
        echo "zip md5 : ${MD5ZIP}"
        echo "signature : ${MD5ZIP}"
                
        echo "dSYM upload url: ${DSYM_UPLOAD_URL}"
            
        # Upload dSYM to APMInsight
        echo "curl ${DSYM_UPLOAD_URL} -F \"file=@${DSYM_ZIP_FPATH}\"  -F \"aid=${APMInsight_APP_ID}\" -H \"Content-Type: multipart/form-data\" -w %{http_code} -v "
            
        echo "--------------------------------"
            
        # 上传请求
        STATUS=$(curl ${DSYM_UPLOAD_URL} -F "file=@${DSYM_ZIP_FPATH}" -F "type=Dwarf" -F "os=iOS" -F "aid=${APMInsight_APP_ID}" -H "Content-Type: multipart/form-data" -w %{http_code} -v)
            
        echo "APMInsight server response: ${STATUS}"

        if [ ${STATUS} = "{\"err_detail\":\"\",\"data\":null,\"error_msg\":\"\",\"error_no\":0}200" ]; then
            echo "Upload dSYM successfully! Delete ${DSYM_SYMBOL_OUT_ZIP_NAME}."
            if [ -f ${DSYM_SYMBOL_OUT_ZIP_NAME} ]; then
                rm ${DSYM_SYMBOL_OUT_ZIP_NAME}
            fi
        else
            echo "Failed to upload dSYM. Try to upload the file at path ${DSYM_SYMBOL_OUT_ZIP_NAME} manually."
        fi
    }
        
    # .dSYM文件信息
    echo "DSYM FOLDER ${DWARF_DSYM_FOLDER_PATH}"
    
    DSYM_FOLDER="${DWARF_DSYM_FOLDER_PATH}"
    
    for i in {1..10};
    do
        sleep 1s
        # 遍历目录查找当前工程名的文件
        for dsymFile in $(find "$DSYM_FOLDER" -name "${PRODUCT_NAME}.*.dSYM"); 
        do
            # 判断压缩文件的源文件是否存在
            DSYM_SINGLE_FILE_NAME="${dsymFile}/Contents/Resources/DWARF/${PRODUCT_NAME}"
            if [ ${UPLOADFLAG} -eq 1 -a -s "${DSYM_SINGLE_FILE_NAME}" ]; then
                echo "Found dSYM file: $dsymFile"
                uploadDSYM $dsymFile
                break 2
            fi
        done
    done
}
    
main
