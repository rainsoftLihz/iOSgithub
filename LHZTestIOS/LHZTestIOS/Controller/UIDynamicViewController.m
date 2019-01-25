//
//  UIDynamicViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/3/23.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "UIDynamicViewController.h"

#define Ball_W 80

@interface UIDynamicViewController ()<UIDynamicAnimatorDelegate,UICollisionBehaviorDelegate>

@property (nonatomic,strong)UIImageView* ballItem;

@property (nonatomic,strong)UIImageView* ballItem1;

@property (nonatomic,strong)UIDynamicAnimator *animator;

@property (nonatomic,strong)UICollisionBehavior* collisionBehavior;

@property (nonatomic,strong)UIGravityBehavior *gravityBehavior;

@property (nonatomic,strong)UIAttachmentBehavior *attachmentBehavior;

@property (nonatomic,strong)UISnapBehavior* snapBehavior;

@end

@implementation UIDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.ballItem];
    [self.view addSubview:self.ballItem1];
    [self gravity];
}
#pragma mark ---- 动力效果操纵者的代理方法

-(void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator{
    NSLog(@"开始");
}
-(void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    NSLog(@"暂停");
    
}

#pragma mark ---- 碰撞效果操纵者的代理方法
-(void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:
(id<UIDynamicItem>)item withBoundaryIdentifier:(id)identifier atPoint:(CGPoint)p
{
    NSLog(@"开始碰撞时触发的方法");
}

-(void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:
(id<UIDynamicItem>)item withBoundaryIdentifier:(id)identifier
{
    NSLog(@"结束碰撞时触发的方法");
}
//懒加载
-(UIImageView *)ballItem{
    if (_ballItem) {
        return _ballItem;
    }
    _ballItem = [[UIImageView alloc]initWithFrame:CGRectMake(100, 50, Ball_W, Ball_W)];
    _ballItem.image = [UIImage imageNamed:@"basketBall"];
    _ballItem.backgroundColor = [UIColor redColor];
    _ballItem.layer.masksToBounds = YES;
    _ballItem.layer.cornerRadius = Ball_W/2.0;
    return _ballItem;
}

-(UIImageView *)ballItem1{
    if (_ballItem1) {
        return _ballItem1;
    }
    _ballItem1 = [[UIImageView alloc]initWithFrame:CGRectMake(160, 150, Ball_W, Ball_W)];
    _ballItem1.image = [UIImage imageNamed:@"basketBall"];
    _ballItem1.layer.masksToBounds = YES;
    _ballItem1.layer.cornerRadius = Ball_W/2.0;
    _ballItem1.backgroundColor = [UIColor redColor];
    return _ballItem1;
}


#pragma mark --- 动力引擎
-(UIDynamicAnimator *)animator{
    if (_animator) {
        return _animator;
    }
    _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    _animator.delegate = self;
    return _animator;
}


#pragma mark --- 重力感应
-(UIGravityBehavior *)gravityBehavior
{
    if (_gravityBehavior) {
        return _gravityBehavior;
    }
    
    _gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.ballItem,self.ballItem1]];
    
    //gravityDirection 默认（0.0，1.0）向下 每秒下降 1000个像素点
    _gravityBehavior.gravityDirection = CGVectorMake(0.0, 1.0);
    //弧度 影响到重力的方向
    _gravityBehavior.angle = 90*M_PI/180;
    //    magnitude 影响下降速度
    _gravityBehavior.magnitude = 1.3;
    
    return _gravityBehavior;
}


#pragma mark --- 碰撞感应
-(UICollisionBehavior *)collisionBehavior
{
    if (_collisionBehavior) {
        return _collisionBehavior;
    }
    
    _collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.ballItem,self.ballItem1]];
    _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    _collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    
    return _collisionBehavior;
}

#pragma mark --- 吸附行为
-(UIAttachmentBehavior *)attachmentBehavior
{
    if (!_attachmentBehavior) {
        _attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.ballItem attachedToItem:self.ballItem1];
    }
    return _attachmentBehavior;
}

#pragma mark --- 吸附行为
-(UISnapBehavior *)snapBehavior
{
    if (!_snapBehavior) {
        _snapBehavior = [[UISnapBehavior alloc] initWithItem:self.ballItem snapToPoint:CGPointMake(self.ballItem.left, self.ballItem1.left)];
    }
    return _snapBehavior;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint center = [[touches anyObject]locationInView:self.view];
    self.ballItem.center = center;
    self.ballItem1.center = CGPointMake(center.x+55, center.y+30);
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"Y:%f",self.ballItem.frame.origin.y);
    
    [self gravity];
}

#pragma mark ----重力+碰撞效果
-(void)gravity{
    //移除之前效果
    [self.animator removeAllBehaviors];
    
    //把重力效果 添加到 动力效果的操纵者上
    [self.animator addBehavior:self.gravityBehavior];
    [self.animator addBehavior:self.collisionBehavior];
//    [self.animator addBehavior:self.attachmentBehavior];
 
    
    //[self.animator addBehavior:self.snapBehavior];
    //设置视图的辅助行为(本身参数 弹性系数 阻力等)
    
    //elasticity; // Usually between 0 (inelastic) and 1 (collide elastically)  弹性系数
    
    //friction; // 0 being no friction between objects slide along each other  摩擦力
    
    //density; // 1 by default                                                  密度
    
    //resistance; // 0: no velocity damping                                    阻力
    
    //angularResistance; // 0: no angular velocity damping
    
    //allowsRotation; // force an item to never rotate                          是否允许旋转
    
    UIDynamicItemBehavior *item = [[UIDynamicItemBehavior alloc] initWithItems:@[self.ballItem,self.ballItem1]];
    
    item.elasticity = 0.9;
    
    item.friction = 0;
    
    item.density = 1;
    
    item.resistance = 0.3;
    
    item.angularResistance = 0.3;
    
    item.allowsRotation = YES;
    
    [self.animator addBehavior:item];
  
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
