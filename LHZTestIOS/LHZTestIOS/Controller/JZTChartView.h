//
//  JZTChartView.h
//  JZTArchives
//
//  Created by rainsoft on 16/11/7.
//  Copyright © 2016年 梁泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZTChartModel.h"
#import "UIView+ExtendTouchRect.h"
#define MAX_X_NUMS  (IS_IPHONE5?4:5) /* X轴数据个数 计算间距用的 */
#define MAX_Y_NUMS 5 /* Y轴数据个数 */
#define COLOR_ZHUSE UIColorFromRGB(0x898989)
@interface JZTChartView : UIView

@property (nonatomic,strong) NSArray *leftArr;//左边显示的参考值视图
@property (nonatomic,strong) NSArray *bottomArr;//底部纪录日期视图
@property (nonatomic,strong) NSArray *data1Arr;//左边数据1条线

/* 获取最大值和最小值 */
-(void)configMax:(CGFloat)maxValue andMin:(CGFloat)minValue;

+(CGFloat)chartHeight;
@end
