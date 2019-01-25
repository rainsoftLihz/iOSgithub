//
//  JZTHealthKit.h
//  JZTHealthKit
//
//  Created by freedom on 2016/10/26.
//  Copyright © 2016年 com.jk998.jpeg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <HealthKit/HealthKit.h>
@interface JZTHealthKit : NSObject

+ (instancetype)manager;

/**
 *  计步器是否可以使用
 *
 *  @return YES or NO
 */
+ (BOOL)isStepCountingAvailable;
/**
 *  查询某时间段的行走数据
 *
 *  @param start   开始时间
 *  @param end     结束时间
 *  @param handler 查询结果
 */
- (void)queryPedometerDataFromDate:(NSDate *)start
                            toDate:(NSDate *)end
                       withHandler:(void (^)(CMPedometerData *pedometerData,NSError *error))handler;
/**
 *  监听今天（从零点开始）的行走数据
 *
 *  @param handler 查询结果、变化就更新
 */
- (void)startPedometerUpdatesTodayWithHandler:(void (^)(CMPedometerData *pedometerData,NSError *error))handler;
/**
 *  停止监听运动数据
 */
- (void)stopPedometerUpdates;

@end
