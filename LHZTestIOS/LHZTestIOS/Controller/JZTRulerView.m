//
//  JZTRulerView.m
//  JZTModulTwo
//
//  Created by 梁泽 on 2016/10/28.
//  Copyright © 2016年 梁泽. All rights reserved.
//

#import "JZTRulerView.h"
#import "JZTRulerScrollView.h"
// 中间指示器顶部闭合三角形高度
#define SHeight (24*kHProportion)
#define SWidth (18*kProportion)
@interface JZTRulerView()
@property (nonatomic, strong) CAShapeLayer *shapeLayerLine;//指示器
@property (nonatomic, strong) JZTRulerScrollView *rulerScrollView;

@end

@implementation JZTRulerView
- (JZTRulerScrollView *)rulerScrollView{
    if (!_rulerScrollView) {
        _rulerScrollView = [[JZTRulerScrollView alloc]init];
        _rulerScrollView.delegate = self;
        _rulerScrollView.showsHorizontalScrollIndicator = NO;
        _rulerScrollView.rulerPlaceholderCount = 100;
    }
    return _rulerScrollView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.indicatorColor = [UIColor colorWithRed:0.157 green:0.769 blue:0.686 alpha:1.000];
        self.rulerScrollView.rulerHeight = frame.size.height;
        self.rulerScrollView.rulerWidth = frame.size.width;
        self.rulerScrollView.lz_bounce = YES;
        [self addSubview:self.rulerScrollView];
    }
    return self;
}
/// 渐变效果
- (void)drawGradient{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    
    gradient.colors = @[(id)[[UIColor whiteColor] colorWithAlphaComponent:1.f].CGColor,
                        (id)[[UIColor whiteColor] colorWithAlphaComponent:0.0f].CGColor,
                        (id)[[UIColor whiteColor] colorWithAlphaComponent:1.f].CGColor];
    
    gradient.locations = @[[NSNumber numberWithFloat:0.0f],
                           [NSNumber numberWithFloat:0.6f]];
    
    gradient.startPoint = CGPointMake(0, .5);
    gradient.endPoint = CGPointMake(1, .5);
    
    CGMutablePathRef pathArc = CGPathCreateMutable();
    
    CGPathMoveToPoint(pathArc, NULL, 0, DistanceBottom);
    CGPathAddQuadCurveToPoint(pathArc, NULL, self.frame.size.width / 2, - 20, self.frame.size.width, DistanceBottom);
    [self.layer addSublayer:gradient];
}
- (void)configRulerScorllViewWithMin:(CGFloat)min
                               count:(NSUInteger)count
                             average:(CGFloat)average
                        currentValue:(CGFloat)currentValue
                           markCount:(NSUInteger)markCount{
//    debug open
//    NSAssert(self.rulerScrollView != nil, @"***** 调用此方法前，请先调用 initWithFrame:(CGRect)frame\n");
//    NSAssert(currentValue <= min + average * count + 1, @"***** currentValue 不能大于直尺最大值（count * average）\n");
    
    self.rulerScrollView.rulerMin = min;
    self.rulerScrollView.rulerCount = count;
    self.rulerScrollView.rulerAverage = average;
    self.rulerScrollView.rulerValue = currentValue;
    self.rulerScrollView.markCount = markCount;
    [self.rulerScrollView drawRuler];
    [self drawIndicatorLine];
}
- (void)configRulerScorllViewWithMin:(CGFloat)min count:(NSUInteger)count average:(CGFloat)average currentValue:(CGFloat)currentValue{
    [self configRulerScorllViewWithMin:min count:count average:average currentValue:currentValue markCount:0];
}

- (void)setIndicatorColor:(UIColor *)indicatorColor{
    if ([_indicatorColor isEqual:indicatorColor]) {
        return;
    }
    _indicatorColor = indicatorColor;
    [self drawIndicatorLine];
}
- (void)drawIndicatorLine{
    [self.shapeLayerLine removeFromSuperlayer];
    // 指示器
    CAShapeLayer *shapeLayerLine = [CAShapeLayer layer];
    shapeLayerLine.strokeColor = self.indicatorColor.CGColor;
    shapeLayerLine.fillColor = self.indicatorColor.CGColor;
    shapeLayerLine.lineWidth = 1.5f;
    shapeLayerLine.lineCap = kCALineCapRound;
    
    //NSUInteger ruleHeight = 20; // 文字高度
    CGMutablePathRef pathLine = CGPathCreateMutable();
    CGPathMoveToPoint(pathLine, NULL, self.frame.size.width / 2, self.frame.size.height);
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2, SHeight);
    
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2 - SWidth, 0);
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2 + SWidth, 0);
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2, SHeight);
    
    shapeLayerLine.path = pathLine;
    [self.layer addSublayer:_shapeLayerLine = shapeLayerLine];
}

- (void)scrollWithRulerValue:(CGFloat)rulerValue{
    CGFloat offX = ((rulerValue - self.rulerScrollView.rulerMin)/(self.rulerScrollView.rulerAverage))*DistanceTick + DistanceLeftAndRight - self.frame.size.width/2;
    [self.rulerScrollView setContentOffset:CGPointMake(offX, 0) animated:YES];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(JZTRulerScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(JZTRulerView:willBeginScroll:)]) {
        [self.delegate JZTRulerView:self willBeginScroll:scrollView];
    }
}

- (void)scrollViewDidScroll:(JZTRulerScrollView *)scrollView{
    [scrollView setNeedsDisplay];
    CGFloat offsetX = scrollView.contentOffset.x + self.frame.size.width/2 - DistanceLeftAndRight;
    CGFloat offsetValue = (offsetX / DistanceTick)*scrollView.rulerAverage;
    if (offsetValue < 0 || offsetValue > scrollView.rulerCount * scrollView.rulerAverage) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(JZTRulerView:didRefreshTick:)]) {
        if (!scrollView.lz_bounce) {
            scrollView.rulerValue = offsetValue + scrollView.rulerMin;
        }
        scrollView.lz_bounce = NO;
        
        [self.delegate JZTRulerView:self didRefreshTick:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(JZTRulerScrollView *)scrollView{
    if (self.onlyStopMark) {
        [self animationBounce:scrollView];
    }
    
}

#pragma mark - privateMethods
- (void)animationBounce:(JZTRulerScrollView*)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x + self.frame.size.width/2 - DistanceLeftAndRight;
    CGFloat rulerValue = (offsetX / DistanceTick)*scrollView.rulerAverage ;
    
    if ([self valueIsMark:scrollView.rulerAverage]) {
        rulerValue = [self notBounce:rulerValue afterPoint:0];
    }else{
        rulerValue = [self notBounce:rulerValue afterPoint:self.rulerScrollView.markCount + 1];
    }
    
    CGFloat offX = (rulerValue/(scrollView.rulerAverage))*DistanceTick + DistanceLeftAndRight - self.frame.size.width/2;
    [UIView animateWithDuration:.2f animations:^{
        scrollView.contentOffset = CGPointMake(offX, 0);
    }];
}

- (BOOL)valueIsMark:(CGFloat)number{
    NSString *value = [NSString stringWithFormat:@"%f",number];
    if (value != nil) {
        NSString *valueEnd = [[value componentsSeparatedByString:@"."] objectAtIndex:1];
        NSString *temp = nil;
        for(int i =0; i < [valueEnd length]; i++)
        {
            temp = [valueEnd substringWithRange:NSMakeRange(i, 1)];
            if (![temp isEqualToString:@"0"]) {
                return NO;
            }
        }
    }
    return YES;
}

- (CGFloat)notBounce:(CGFloat)value afterPoint:(NSInteger)position{
    NSDecimalNumberHandler *hendler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc]initWithFloat:value];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:hendler];
    return [roundedOunces floatValue];
}


@end
