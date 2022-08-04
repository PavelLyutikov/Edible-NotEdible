//
//  RangersAPMConfig.h
//  HeimdallrFinder
//
//  Created by xuminghao.eric on 2021/3/9.
//

#import <Foundation/Foundation.h>
#import "RangersAPMCommon.h"

NS_ASSUME_NONNULL_BEGIN

@interface RangersAPMConfig : NSObject

/*! @abstract The channel where your app will be published.
 @discussion Nonnull & require. Default : "App Store"
 */
@property (atomic, copy) NSString *channel;

/*! @abstract The ID of your app that you registered from APMInsight.
 @discussion Nonnull & require.
 */
@property (atomic, copy) NSString *appID;

/*!@abstract The source where we will get the device ID.
 @discussion Nonnull & require. Default : RAPMDeviceIDSourceFromUser.
 */
@property (atomic, assign) RAPMDeviceIDSource deviceIDSource;

/**
 Initialize a config with appID.
 
 @param appID The ID of your app that you registered from APMInsight.
 @result A RangersAPMConfig instance.
 */
+ (instancetype)configWithAppID:(NSString *)appID;


@end

NS_ASSUME_NONNULL_END
