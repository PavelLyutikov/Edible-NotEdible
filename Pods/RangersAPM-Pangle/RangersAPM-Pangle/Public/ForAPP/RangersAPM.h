//
//  RangersAPM.h
//  Pods
//
//  Created by xuminghao.eric on 2020/4/27.
//

#import <Foundation/Foundation.h>
#import "RangersAPMConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface RangersAPM : NSObject

/**
 Start APMInsight SDK with config.
 
 @param config The config you initialized to start APMInsight SDK.
 @discussion Multiple calls will not behave, only the config in first call is valid. ⚠️Please call this on the mainThread.
 */
+ (void)startWithConfig:(RangersAPMConfig *)config;

/**
 Set the device ID.
 
 @param deviceID The device ID in your own account system if you have.
 @discussion We will show the deviceID on APMInsight for you, and you can use it to search for logs on APMInsight - Single point tracing. Nonnull & Optional.
 */
+ (void)setDeviceID:(NSString *)deviceID;

/**
 Set the user ID.
 
 @param userID The user ID in your own account system if you have.
 @discussion We will show the userID on APMInsight for you, and you can use it to search for logs on APMInsight - Single point tracing. Nonnull & Optional.
 */
+ (void)setUserID:(NSString *)userID;

/**
 Add a custom context.
 
 @param value The value of this custom context.
 @param key The key of this custom context.
 @discussion We will show the context on APMInsight.
 */
+ (void)setCustomContextValue:(id)value forKey:(NSString *)key;

/**
 Remove the custom context.
 
 @param key The key of the custom context you want to remove.
 */
+ (void)removeCustomContextKey:(NSString *)key;

/**
 Add a custom filter.
 
 @param value The value of this custom filter.
 @param key The key of this custom filter.
 @discussion You can use the filter to search specific logs.
 */
+ (void)setCustomFilterValue:(id)value forKey:(NSString *)key;

/**
 Remove the custom filter.
 
 @param key The key of the custom filter you want to remove.
 */
+ (void)removeCustomFilterKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
