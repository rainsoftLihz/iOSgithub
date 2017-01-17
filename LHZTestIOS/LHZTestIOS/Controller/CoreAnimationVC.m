//
//  CoreAnimationVC.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/1/9.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "CoreAnimationVC.h"

#import "CircleView.h"

#define kTag 193

@interface CoreAnimationVC ()
{
    UIView* _demoView;
}
@end

@implementation CoreAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self animationBtn];
    
    UIView* centerView = [[UIView alloc] init];
    centerView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:centerView];
    
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.center.mas_equalTo(self.view);
    }];
    
    _demoView = [[UIView alloc] init];
    _demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_demoView];
    
    [_demoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(-100);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    /* 画圆 */
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(Screen_Width/2.0, Screen_Height/2.0-64/2.0) radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 1;
    [self.view.layer addSublayer:shapeLayer];

}

-(void)animationBtn
{
    NSArray* btnTitle = @[@"位移动画",@"缩放动画",@"旋转动画",@"组合动画"];
    CGFloat space =8.0;
    CGFloat btnW = (Screen_Width-5*space)/btnTitle.count;
    UIButton* presureBtn = nil;
    for (int i = 0; i < btnTitle.count; i++) {
        UIButton* abtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [abtn setTitle:btnTitle[i] forState:UIControlStateNormal];
        [abtn setBackgroundColor:[UIColor greenColor]];
        [abtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        abtn.titleLabel.font = [UIFont systemFontOfSize:13.0];;
        abtn.tag = i+kTag;
        [abtn addTarget:self action:@selector(animation:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:abtn];
        
        if (presureBtn == nil) {
            [abtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.view).offset(10.0);
                make.left.mas_equalTo(self.view).offset(space);
                make.width.mas_equalTo(btnW);
            }];
        }
        else {
            [abtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.view).offset(10.0);
                make.left.mas_equalTo(presureBtn.mas_right).offset(space);
                make.width.mas_equalTo(btnW);
            }];
        }
        
        presureBtn = abtn;
        
    }
}

-(void)animation:(UIButton*)btn
{
    [_demoView.layer removeAllAnimations];
    NSInteger index = btn.tag - kTag;
    if (index == 0) {
        //位移动画
        [self positionAnimation];
    }
    
    if (index == 1) {
        //缩放动画
        [self scaleAnimation];
    }
    
    if (index == 2) {
        //旋转动画
        [self rotationAnimation];
    }
    
    if (index == 3) {
        //组合动画
        [self groupAnimation];
    }
    
}

#pragma mark --- 位移动画
-(void)positionAnimation
{
    /* 画圆 */
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(Screen_Width/2.0, Screen_Height/2.0-64/2.0) radius:100 startAngle:M_PI endAngle:-M_PI clockwise:NO];
    
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    anima.path = path.CGPath;
    
    anima.duration = 2.0;
    
    anima.repeatCount = MAXFLOAT;
    [_demoView.layer addAnimation:anima forKey:@"pathAnimation"];
}

#pragma mark --- 缩放动画
-(void)scaleAnimation
{
    CABasicAnimation* anima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima.toValue = [NSNumber numberWithFloat:2.0f];
    anima.duration = 2.0f;
    anima.repeatCount = 111110;
    /*设置动画的速度变化*/
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    /* 动画结束时是否执行逆动画 */
    anima.autoreverses = YES;
    [_demoView.layer addAnimation:anima forKey:@"scaleAnimation"];
}

#pragma mark --- 旋转动画
-(void)rotationAnimation
{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima.toValue = [NSNumber numberWithFloat:M_PI*4];
    anima.duration = 1.0;
    [_demoView.layer addAnimation:anima forKey:@"rotationAnimation"];
}

#pragma mark --- 组合动画
-(void)groupAnimation
{
    CABasicAnimation* anima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima.toValue = [NSNumber numberWithFloat:3.0f];
    anima.duration = 2.0f;
    anima.repeatCount = 111110;
    anima.autoreverses = YES;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(Screen_Width/2.0, Screen_Height/2.0-64/2.0) radius:100 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    anima1.path = path.CGPath;
    
    anima1.duration = 2.0;
    
    anima1.repeatCount = MAXFLOAT;
    
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima2.toValue = [NSNumber numberWithFloat:M_PI*4];
    anima2.duration = 1.0;
    anima2.repeatCount = MAXFLOAT;
    
    //组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = [NSArray arrayWithObjects:anima,anima1,anima2, nil];
    groupAnimation.duration = 4.0f;
    groupAnimation.repeatCount = MAXFLOAT;
    
    [_demoView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
}

-(void)dealloc
{
    [_demoView.layer removeAllAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
