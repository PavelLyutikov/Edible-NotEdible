//
//  RangersAPMNotifications.h
//  RangersAPM
//
//  Created by xuminghao.eric on 2021/1/13.
//

#import <Foundation/Foundation.h>

/*! @abstract APP内存超出MemoryGraph阈值通知
 @discussion 该通知表示MemoryGraph模块发现APP内存占用超出危险内存阈值，即内存采集启动阈值；通知在非主线程发出
 */
FOUNDATION_EXTERN NSString * const APMMemoryDangerNotification;

/*! @abstract APP卡顿时长超出卡顿阈值通知
 @discussion 该通知表示LAG模块内发现Runloop阻塞超出卡顿设定阈值，此时判定为“疑似”卡顿场景；该通知在非主线程异步发出；若Runloop一直阻塞，则本次被判定为卡死，而不是卡顿；根据本地策略，该卡顿数据可能会被过滤，并不一定会上报异常数据，该通知数据与APMInsight平台卡顿数据并不能保持一致
 */
FOUNDATION_EXTERN NSString * const APMLagTimeOutNotification;

/*! @abstract APP疑似卡死通知
 @discussion 该通知表示WatchDog模块内发现Runloop阻塞超过2s，存在卡死风险；该通知在非主线程异步发出；若后续Runloop阻塞恢复，则此次不被判定为卡死；根据本地策略，该卡死数据后续可能会被过滤，并不一定会上报异常数据，该通知数据与APMInsight平台卡死数据并不能保持一致
 */
FOUNDATION_EXTERN NSString * const APMWatchDogMaybeHappenNotification;

/*! @abstract APP卡死超时通知
 @discussion 该通知表示WatchDog模块内发现Runloop阻塞超出阈值（默认8s，可在平台配置），高概率发生卡死；该通知在非主线程异步发出；若后续Runloop阻塞恢复，则此次不被判定为卡死；根据本地策略，该卡死数据后续可能会被过滤，并不一定会上报异常数据，该通知数据与APMInsight平台卡顿数据并不能保持一致
 */
FOUNDATION_EXTERN NSString * const APMWatchDogTimeoutNotification;

/*! @abstract APP Runloop恢复通知
 @discussion 若发出APMWatchDogMaybeHappenNotification或APMWatchDogTimeoutNotification通知后Runloop恢复运行，则会发出该通知；该通知在非主线程异步发出
 */
FOUNDATION_EXTERN NSString *const APMWatchDogRecoverNotification;
