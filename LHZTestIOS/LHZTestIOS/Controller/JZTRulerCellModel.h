//
//  JZTRulerCellModel.h
//  JZTCGI
//
//  Created by 梁泽 on 2016/11/5.
//  Copyright © 2016年 com.JoinTown.jk998. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@interface JZTRulerCellModel : NSObject
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) CGFloat defaultValue;

/// 起始值
@property (nonatomic, assign) NSInteger  rulerMin;
@property (nonatomic, assign) NSUInteger markCount;//刻度下面 小数点后几位 默认是0
/// 多少格刻度有值
@property (nonatomic, assign) NSUInteger rulerCount;
/// 每个刻度的值  ~> 所以不需要最大值这个属性
@property (nonatomic, assign) CGFloat rulerAverage;
@property (nonatomic, assign) CGFloat rulerValue;
@property (nonatomic, assign) BOOL onlyStopMark;
@property (nonatomic, assign) NSInteger showValidNumCount;//滑动后 显示小数点后几位有效数字,
- (instancetype)initWithType:(NSString*)type rulerMin:(NSInteger)rulerMin rulerCount:(NSInteger)rulerCount rulerAverage:(CGFloat)rulerAverage defaultValue:(CGFloat)defaultValue validNumCount:(NSInteger)validNumCount stopMark:(BOOL)stopMark markCount:(NSInteger)markCount;
- (instancetype)initWithType:(NSString*)type rulerMin:(NSInteger)rulerMin rulerCount:(NSInteger)rulerCount rulerAverage:(CGFloat)rulerAverage defaultValue:(CGFloat)defaultValue validNumCount:(NSInteger)validNumCount stopMark:(BOOL)stopMark;
- (NSString *)identifier;
- (NSString *)name;
- (NSString *)unit;
- (NSString *)defaultValueStr;
- (NSString *)currentValueStr;

- (NSString *)logCurrentData;
@end
