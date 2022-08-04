//
//  RangersAddressRange.h
//  Pods
//
//  Created by who on 2020/5/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RangersAddressRange : NSObject

/*! @abstract The start address of this range.
 */
@property(nonatomic, assign, readonly)int64_t startAddress;

/*! @abstract The end address of this range.
 */
@property(nonatomic, assign, readonly)int64_t endAddress;

/*!
 Use this method to initialize an addressRange.
 
 @param startAddress The start address of this range.
 @param endAddress The end address of this range.
 */
+ (instancetype)addressRangeWithStartAddress:(int64_t)startAddress endAddress:(int64_t)endAddress;

@end

NS_ASSUME_NONNULL_END
