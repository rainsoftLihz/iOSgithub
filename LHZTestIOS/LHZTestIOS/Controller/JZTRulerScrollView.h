//
//  JZTRulerScrollView.h
//  JZTModulTwo
//
//  Created by 梁泽 on 2016/10/28.
//  Copyright © 2016年 梁泽. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DistanceLeftAndRight 8. //标尺左右距离
#define DistanceTick         8. //刻度实际长度8.
#define DistanceTop          13.
#define DistanceBottom       5.

@interface JZTRulerScrollView : UIScrollView
/// 起始值
@property (nonatomic, assign) CGFloat  rulerMin;
@property (nonatomic, assign) NSUInteger markCount;//刻度小数点后几位 默认是0
/// 多少格刻度有值
@property (nonatomic, assign) NSUInteger rulerCount;
/// 占位刻度无值 分布在真实刻度左右
@property (nonatomic, assign) NSUInteger rulerPlaceholderCount;
/// 每个刻度的值  ~> 所以不需要最大值这个属性
@property (nonatomic, assign) CGFloat rulerAverage;

@property (nonatomic, assign) CGFloat rulerHeight;

@property (nonatomic, assign) CGFloat rulerWidth;

@property (nonatomic, assign) CGFloat rulerValue;

@property (nonatomic, assign) BOOL lz_bounce;

- (void)drawRuler;

@end
