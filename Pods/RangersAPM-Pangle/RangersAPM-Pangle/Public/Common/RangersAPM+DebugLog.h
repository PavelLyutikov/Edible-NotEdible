//
//  RangersAPM+DebugLog.h
//  HeimdallrFinder
//
//  Created by xuminghao.eric on 2020/11/26.
//

#import "RangersAPM.h"

NS_ASSUME_NONNULL_BEGIN

/**
 We will pass the log to you by this block.
 */
typedef void(^RangersAPMLogger)(NSString *log);

@interface RangersAPM (DebugLog)

/**
 Enable console log.
 
 @param logger Print log with format. If nil is passed in, the log will be printed with default format.
 @discussion Default format: "APMInsight : {log}"
 */
+ (void)allowDebugLogUsingLogger:(nullable RangersAPMLogger)logger;

@end

NS_ASSUME_NONNULL_END
