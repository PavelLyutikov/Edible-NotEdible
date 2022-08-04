//
//  RangersAPMForSDKConfig.h
//  HeimdallrFinder
//
//  Created by xuminghao.eric on 2021/3/9.
//

#import <Foundation/Foundation.h>
#import "RangersAPMAddressConfig.h"
#import "RangersAPMCommon.h"

NS_ASSUME_NONNULL_BEGIN

@interface RangersAPMForSDKConfig : NSObject

/*! @abstract The ID of your sdk that you registered from APMInsight.
 @discussion Nonnull & required.
 */
@property (atomic, copy) NSString *sdkID;

/*! @abstract The ID of your sdk's host app in your own account system if you have.
 @discussion We will show it on APMInsight for you, nullable & optional.
 */
@property (atomic, copy, nullable) NSString *hostAppID;

/*! @abstract Current version of your sdk
 @discussion Nonnull & required.
 */
@property (atomic, copy) NSString *sdkVersion;

/*! @abstract The channel where your SDK will be published.
 @discussion Nonnull & require. Default : "Other"
 */
@property (atomic, strong) NSString *channel;

/*!@abstract The source where we will get the device ID.
 @discussion Nonnull & require. Default : RAPMDeviceIDSourceFromUser
 */
@property (atomic, assign) RAPMDeviceIDSource deviceIDSource;

/*!
 @abstract The address ranges of your sdk in the main mach-o.
 @discussion Only when the fault address is in the address ranges, we will upload the crash log. Nullable & optional.
 */
@property (atomic, strong, nullable) RangersAPMAddressConfig *addressConfig;

/*!
 @abstract The name of your SDK.
 @discussion Set this property with your SDK name. Nullable & optional.
 */
@property (atomic, copy) NSArray<NSString *> *libNames;

/**
 Initialize a config with appID.
 
 @param sdkID The ID of your sdk that you registered from APMInsight.
 @result A RangersAPMForSDKConfig instance.
 */
+ (instancetype)configWithSDKID:(NSString *)sdkID;
- (id)init __attribute__((unavailable("please use configWithSDKID:")));
+ (instancetype)new __attribute__((unavailable("please use configWithSDKID:")));

@end

NS_ASSUME_NONNULL_END
