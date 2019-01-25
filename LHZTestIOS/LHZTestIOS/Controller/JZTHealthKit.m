//
//  JZTHealthKit.m
//  JZTHealthKit
//
//  Created by freedom on 2016/10/26.
//  Copyright © 2016年 com.jk998.jpeg. All rights reserved.
//

#import "JZTHealthKit.h"
@interface JZTHealthKit()
@property(nonatomic, strong) CMPedometer *pedometer;
@end

@implementation JZTHealthKit
+ (instancetype)manager{
    static JZTHealthKit *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        if ([CMPedometer isStepCountingAvailable]) {
            self.pedometer = [[CMPedometer alloc] init];
        }
    }
    return self;
}

/**
 *  查询某时间段的运动数据
 *
 *  @param start   开始时间
 *  @param end     结束时间
 *  @param handler 查询结果
 */
- (void)queryPedometerDataFromDate:(NSDate *)start
                            toDate:(NSDate *)end
                       withHandler:(void (^)(CMPedometerData *pedometerData,NSError *error))handler
{
    [_pedometer
     queryPedometerDataFromDate:start
     toDate:end
     withHandler:^(CMPedometerData *_Nullable pedometerData,
                   NSError *_Nullable error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             handler(pedometerData, error);
         });
     }];
}
/**
 *  监听今天（从零点开始）的行走数据
 *
 *  @param handler 查询结果、变化就更新
 */
- (void)startPedometerUpdatesTodayWithHandler:(void (^)(CMPedometerData *pedometerData,NSError *error))handler
{
    if (![[self class] isStepCountingAvailable]) {
        return;
    }
    NSDate *toDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromDate =
    [dateFormatter dateFromString:[dateFormatter stringFromDate:toDate]];
    [_pedometer
     startPedometerUpdatesFromDate:fromDate
     withHandler:^(CMPedometerData *_Nullable pedometerData,
                   NSError *_Nullable error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             handler(pedometerData, error);
         });
     }];
}
/**
 *  停止监听运动数据
 */
- (void)stopPedometerUpdates {
    [_pedometer stopPedometerUpdates];
}
/**
 *  计步器是否可以使用
 *
 *  @return YES or NO
 */
+ (BOOL)isStepCountingAvailable {
    return [CMPedometer isStepCountingAvailable];
}


@end
