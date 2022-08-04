//
//  RangersAPMForSDK.h
//  Pods
//
//  Created by who on 2020/5/18.
//

#import <Foundation/Foundation.h>
#import "RangersAPMForSDKConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface RangersAPMForSDK : NSObject

@property(nonatomic, strong, readonly) RangersAPMForSDKConfig *config;

/**
 初始化SDK监控，返回一个实例，初始化会直接开启监控功能
 
 @param config 初始化SDK监控的参数，所需参数可以参考头文件BDAutoTrackConfig+RangersAPMForSDK.h ⚠️请在主线程调用
 */
- (instancetype)initWithConfig:(RangersAPMForSDKConfig *)config;
- (id)init __attribute__((unavailable("please use initWithConfig:")));
+ (instancetype)new __attribute__((unavailable("please use initWithConfig:")));

/**
 禁用监控功能
 */
- (void)disableMonitor;

/**
 启用监控功能。初始化后不用手动调用此方法，此方法用于禁用后重新启用。
 */
- (void)enableMonitor;

/**
 返回一个已经初始化的实例，如果没有初始化过对应的实例，请先初始化，否则返回nil
 
 @param sdkID 已经初始化过的实例的sdkID
 */
+ (nullable instancetype)monitorWithSDKID:(NSString *)sdkID;

/**
 Set the device ID.
 
 @param deviceID The device ID in your own account system if you have.
 @discussion We will show the deviceID on APMInsight for you, and you can use it to search for logs on APMInsight - Single point tracing. Nonnull & Optional.
 */
- (void)setDeviceID:(NSString *)deviceID;

/**
 Set the user ID.
 
 @param userID The user ID in your own account system if you have.
 @discussion We will show the userID on APMInsight for you, and you can use it to search for logs on APMInsight - Single point tracing. Nonnull & Optional.
 */
- (void)setUserID:(NSString *)userID;

/**
 添加自定义的环境变量
 
 @param value 自定义的环境变量的值
 @param key 自定义的环境变量的键
 */
- (void)setCustomContextValue:(id)value forKey:(NSString *)key;

/**
 移除自定义的环境变量
 
 @param key 自定义的环境变量的键
 */
- (void)removeCustomContextKey:(NSString *)key;

/**
 添加自定义的筛选项
 
 @param value 自定义的筛选项的值
 @param key 自定义的筛选项的的键
 */
- (void)setCustomFilterValue:(id)value forKey:(NSString *)key;

/**
 移除自定义的筛选项
 
 @param key 自定义的筛选项的键
 */
- (void)removeCustomFilterKey:(NSString *)key;


+ (void)startWithConfig:(RangersAPMForSDKConfig *)config __attribute__((deprecated("please use initWithConfig:")));

/**
 添加自定义的环境变量
 
 @param value 自定义的环境变量的值
 @param key 自定义的环境变量的键
 */
+ (void)setCustomContextValue:(id)value forKey:(NSString *)key appID:(NSString *)appID __attribute__((deprecated("please use setCustomContextValue:forKey:")));

/**
 移除自定义的环境变量
 
 @param key 自定义的环境变量的键
 */
+ (void)removeCustomContextKey:(NSString *)key appID:(NSString *)appID __attribute__((deprecated("please use removeCustomContextKey:")));

/**
 添加自定义的筛选项
 
 @param value 自定义的筛选项的值
 @param key 自定义的筛选项的的键
 */
+ (void)setCustomFilterValue:(id)value forKey:(NSString *)key appID:(NSString *)appID __attribute__((deprecated("please use setCustomFilterValue:forKey:")));

/**
 移除自定义的筛选项
 
 @param key 自定义的筛选项的键
 */
+ (void)removeCustomFilterKey:(NSString *)key appID:(NSString *)appID __attribute__((deprecated("please use removeCustomFilterKey:")));


@end

NS_ASSUME_NONNULL_END
