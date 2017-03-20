//
//  JZTRulerView.h
//  JZTModulTwo
//
//  Created by 梁泽 on 2016/10/28.//  Copyright © 2016年 梁泽. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZTRulerScrollView;

@class JZTRulerView;
@protocol JZTRulerViewDelegate <NSObject>
- (void)JZTRulerView:(JZTRulerView*)rulerView willBeginScroll:(JZTRulerScrollView*)scrollView;
- (void)JZTRulerView:(JZTRulerView*)rulerView didRefreshTick:(JZTRulerScrollView*)scrollView;

@end


@interface JZTRulerView : UIView<UIScrollViewDelegate>
@property (nonatomic, weak  ) id<JZTRulerViewDelegate> delegate;
@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, assign) BOOL onlyStopMark;
/// 渐变效果
- (void)drawGradient;

- (void)configRulerScorllViewWithMin:(CGFloat)min
                               count:(NSUInteger)count
                             average:(CGFloat)average
                        currentValue:(CGFloat)currentValue;
- (void)configRulerScorllViewWithMin:(CGFloat)min
                               count:(NSUInteger)count
                             average:(CGFloat)average
                        currentValue:(CGFloat)currentValue
                           markCount:(NSUInteger)markCount;//设置刻度小数点后位数
- (void)scrollWithRulerValue:(CGFloat)rulerValue;
@end
