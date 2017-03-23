//
//  JZTRulerScrollView.m
//  JZTModulTwo
//
//  Created by 梁泽 on 2016/10/28.
//  Copyright © 2016年 梁泽. All rights reserved.
//

#import "JZTRulerScrollView.h"
#define kStartSpace 50
@interface MarkView : UIView
@property (nonatomic, assign) CGFloat rulerMin;
@property (nonatomic, assign) NSInteger rulerCount;
@property (nonatomic, assign) CGFloat rulerAverage;
@property (nonatomic, assign) NSUInteger markCount;//刻度小数点后几位 默认是0

- (instancetype)initWithFrame:(CGRect)frame rulerCount:(NSInteger)rulerCount rulerMin:(CGFloat)rulerMin rulerAverage:(CGFloat)rulerAverage markCount:(NSUInteger)markCount;
@end
@implementation MarkView
- (instancetype)initWithFrame:(CGRect)frame rulerCount:(NSInteger)rulerCount rulerMin:(CGFloat)rulerMin rulerAverage:(CGFloat)rulerAverage markCount:(NSUInteger)markCount{
    if (self = [super initWithFrame:frame]) {
        self.rulerCount = rulerCount;
        self.rulerMin = rulerMin;
        self.rulerAverage   = rulerAverage;
        self.markCount = markCount;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect{

    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSTextAlignmentCenter];
    NSDictionary *attr = @{NSForegroundColorAttributeName : UIColorFromRGB(0x848484),
                           NSFontAttributeName   : [UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:style};

    for (int i = 0; i <= self.rulerCount ; i++) {
        CGFloat x = DistanceLeftAndRight + DistanceTick * i + kStartSpace;
        if (i % 10 == 0){
            NSString *markText = [NSString stringWithFormat:@"%.0f",self.rulerMin + i*self.rulerAverage];
            if (self.markCount == 1) {
                markText = [NSString stringWithFormat:@"%.1f",self.rulerMin + i*self.rulerAverage];
            }
            if (self.markCount == 2) {
                markText = [NSString stringWithFormat:@"%.2f",self.rulerMin + i*self.rulerAverage];
            }
            CGSize textSize = [markText sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
            
            
//            UILabel* lab = [UILabel new];
//            lab.text = markText;
//            lab.textColor = [UIColor redColor];
//            lab.font = [UIFont systemFontOfSize:13.0];
//            lab.textAlignment = NSTextAlignmentCenter;
//            //[self addSubview:lab];
//            
//            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(x - textSize.width/2);
//                make.top.bottom.mas_equalTo(self);
//                make.width.mas_equalTo(textSize.width+2.0);
//            }];
            
            [markText drawInRect:CGRectMake(x - textSize.width/2,0, textSize.width,self.frame.size.height) withAttributes:attr];
        }
    }
}
@end

@implementation JZTRulerScrollView

- (void)drawRuler{
    CGSize textSize = [@"1234" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    MarkView *markView = [[MarkView alloc]initWithFrame:CGRectMake(-kStartSpace,self.rulerHeight - DistanceBottom - textSize.height + 3 ,self.rulerCount * DistanceTick + 2 * DistanceLeftAndRight + 2*kStartSpace, textSize.height) rulerCount:self.rulerCount rulerMin:self.rulerMin rulerAverage:self.rulerAverage markCount:self.markCount];
    [self addSubview:markView];
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = UIColorFromRGB(0x848484).CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = .5f;
    layer.lineCap = kCALineCapButt;
    NSDictionary *attr = @{
                           NSForegroundColorAttributeName : UIColorFromRGB(0x848484),
                           NSFontAttributeName   : [UIFont systemFontOfSize:13],
                           };
    for (int a = 0; a <= self.rulerCount + 2*self.rulerPlaceholderCount; a++) {
        NSInteger i = a - self.rulerPlaceholderCount;
        CGFloat x = DistanceLeftAndRight + DistanceTick * i;//所有刻度线 线上的x坐标一样
        if (i % 10 == 0) {
            CGPathMoveToPoint(pathRef, NULL, x, DistanceTop);
            CGPathAddLineToPoint(pathRef, NULL, x, self.rulerHeight - DistanceBottom - textSize.height);
        }else if (i % 5 == 0){
            CGPathMoveToPoint(pathRef, NULL, x, DistanceTop);
            CGPathAddLineToPoint(pathRef, NULL, x, self.rulerHeight - DistanceBottom - textSize.height - 7);
        }else{
            CGPathMoveToPoint(pathRef, NULL, x, DistanceTop);
            CGPathAddLineToPoint(pathRef, NULL, x, self.rulerHeight - DistanceBottom - textSize.height - 14);
        }
    }
    
    layer.path = pathRef;
    self.layer.masksToBounds = NO;
    [self.layer addSublayer:layer];
    self.frame = CGRectMake(0, 0, self.rulerWidth, self.rulerHeight);
    
    if (_lz_bounce) {
        UIEdgeInsets edge = UIEdgeInsetsMake(0, self.rulerWidth/2. - DistanceLeftAndRight, 0, self.rulerWidth/2. - DistanceLeftAndRight);
        self.contentInset = edge;
        
        CGFloat offsetX = DistanceTick*((self.rulerValue -self.rulerMin) / self.rulerAverage) - self.rulerWidth + (self.rulerWidth/2. + DistanceLeftAndRight);
        self.contentOffset = CGPointMake(offsetX, 0);
    }else{
        CGFloat offsetX = DistanceTick*((self.rulerValue -self.rulerMin) / self.rulerAverage) - self.rulerWidth/2. + DistanceLeftAndRight;
        self.contentOffset = CGPointMake(offsetX, 0);
    }
    self.contentSize = CGSizeMake(self.rulerCount * DistanceTick + 2 * DistanceLeftAndRight, self.rulerHeight);
}

@end
