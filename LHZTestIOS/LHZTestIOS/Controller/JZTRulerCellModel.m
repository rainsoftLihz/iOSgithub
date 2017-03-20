//
//  JZTRulerCellModel.m
//  JZTCGI
//
//  Created by 梁泽 on 2016/11/5.
//  Copyright © 2016年 com.JoinTown.jk998. All rights reserved.
//

#import "JZTRulerCellModel.h"

@implementation JZTRulerCellModel
- (instancetype)initWithType:(NSString*)type rulerMin:(NSInteger)rulerMin rulerCount:(NSInteger)rulerCount rulerAverage:(CGFloat)rulerAverage defaultValue:(CGFloat)defaultValue validNumCount:(NSInteger)validNumCount stopMark:(BOOL)stopMark markCount:(NSInteger)markCount{
    if (self = [super init]) {
        _type = type;
        _rulerMin = rulerMin;
        _rulerCount = rulerCount;
        _rulerAverage = rulerAverage;
        _defaultValue = defaultValue;
        _rulerValue = defaultValue;
        _showValidNumCount = validNumCount;
        _onlyStopMark = stopMark;
        _markCount = markCount;
    }
    return self;
}

- (instancetype)initWithType:(NSString*)type rulerMin:(NSInteger)rulerMin rulerCount:(NSInteger)rulerCount rulerAverage:(CGFloat)rulerAverage defaultValue:(CGFloat)defaultValue validNumCount:(NSInteger)validNumCount stopMark:(BOOL)stopMark{
    return [self initWithType:type rulerMin:rulerMin rulerCount:rulerCount rulerAverage:rulerAverage defaultValue:defaultValue validNumCount:validNumCount stopMark:stopMark markCount:0];
}

- (NSString *)identifier{
    return [NSString stringWithFormat:@"%ld%ld%f",self.rulerMin,self.rulerAverage,self.rulerAverage];
}
- (NSString *)name{
    NSInteger type = self.type.integerValue;
    switch (type) {
        case 19:
            return @"身高";
            break;
        case 20:
            return @"体重";
            break;
        case 23:
            return @"腰围";
            break;
        case 24:
            return @"臀围";
            break;
        case 2:
            return @"收缩压";
            break;
        case 3:
            return @"舒张压";
            break;
        case 5:
            return @"血糖";
            break;
        case 15:
        case 16:
            return @"心率";
            break;
        case 11:
            return @"甘油三脂";
            break;
        case 12:
            return @"总胆固醇";
            break;
        case 13:
            return @"高密度蛋白脂";
            break;
        case 14:
            return @"低密度蛋白脂";
            break;
        case 25:
        case 26:
            return @"尿酸";
            break;
        default:
            return @"";
            break;
    }
}
- (NSString *)unit{
    NSInteger type = self.type.integerValue;
    switch (type) {
        case 20:
            return @"kg";
            break;
        case 19:
        case 23:
        case 24:
            return @"cm";
            break;
        case 2:
        case 3:
            return @"mmol/L";
            break;
        case 5:
            return @"mmol/L";
            break;
        case 11:
        case 12:
        case 13:
        case 14:
            return @"mmol/L";
            break;
            
        case 15:
        case 16:
            return @"次/分钟";
            break;
        case 25:
        case 26:
            return @"umol/L";
            break;
        default:
            return @"";
            break;
    }

}
- (NSString *)defaultValueStr{
    switch (self.showValidNumCount) {
        case 0:
            return [NSString stringWithFormat:@"%.0f",self.defaultValue];
            break;
        case 1:
            return [NSString stringWithFormat:@"%.1f",self.defaultValue];
            break;
        default:
            return [NSString stringWithFormat:@"%.2f",self.defaultValue];
            break;
    }
}
- (NSString *)currentValueStr{
    switch (self.showValidNumCount) {
        case 0:
            return [NSString stringWithFormat:@"%.0f",self.rulerValue];
            break;
        case 1:
            return [NSString stringWithFormat:@"%.1f",self.rulerValue];
            break;
        default:
            return [NSString stringWithFormat:@"%.2f",self.rulerValue];
            break;
    }
}

- (NSString *)logCurrentData{
    return [NSString stringWithFormat:@"%@%@%@",[self name],[self currentValueStr],[self unit]];
}
@end
