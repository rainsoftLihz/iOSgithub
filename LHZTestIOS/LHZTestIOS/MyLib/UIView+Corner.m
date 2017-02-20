//
//  UIView+Corner.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/16.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "UIView+Corner.h"

@implementation UIView (Corner)

#pragma mark --- 局部切圆角
-(void)cornerPartWith:(CGFloat)width
{
    CGSize radio = CGSizeMake(width, width);//圆角尺寸
    UIRectCorner corner = UIRectCornerTopLeft|UIRectCornerTopRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:radio];//这地方只能有bounds 使用frame 不可以
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];//创建shapelayer
    masklayer.frame = self.bounds;
    masklayer.path = path.CGPath;//设置路径
    self.layer.mask = masklayer;
}

@end
