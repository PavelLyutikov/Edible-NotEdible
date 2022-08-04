//
//  RangersAPMForSDK+PrivatizationDeployment.h
//  HeimdallrFinder
//
//  Created by xuminghao.eric on 2021/5/10.
//

#import "RangersAPMForSDK.h"

NS_ASSUME_NONNULL_BEGIN

@interface RangersAPMForSDK (PrivatizationDeployment)

/*! @abstract 设置私有化部署域名
 @param domain 私有化部署的域名 -- 只传入域名时，如@"tbm.snssdk.com"，默认为https协议; 除非指定为http协议，如@"http://tbm.snssdk.com"
 @param config 用于初始化RangersAPMForSDK的config
 */
+ (void)setupRequestURLWithUserDomain:(NSString *)domain withConfig:(RangersAPMForSDKConfig *)config;

@end

NS_ASSUME_NONNULL_END
