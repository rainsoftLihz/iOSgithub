//
//  JZTLHZTabBar.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/5/30.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "JZTLHZTabBar.h"
@interface JZTLHZTabBar()
//上次点击的按钮
@property (strong, nonatomic) UIImageView * tempBtn;

@property (strong, nonatomic) UIView * tabBarView;

@end

static const NSInteger btnStartTag = 10080;

@implementation JZTLHZTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    
    if([super initWithFrame:frame]){

        self.tabBarView = [[UIView alloc] initWithFrame:self.bounds];

        [self addSubview:self.tabBarView];
    }
    return self;
}

#pragma mark --- 重写Item
- (void)setItems:(nullable NSArray<UITabBarItem *> *)items animated:(BOOL)animated{
    
    [self configUI];
}

-(void)configUI{
    if (self.btnImageNormal.count < 1 && self.btnImageNormal.count != self.btnImageSelected.count) {
         NSAssert(self.btnImageNormal && self.btnImageSelected, ([NSString stringWithFormat:@"%s  %s %d行 按钮选中与未选中图片必须设置,标题数组必须有且等于按钮个数",__FILE__,__FUNCTION__,__LINE__]));
        return;
    }
    NSInteger count  =  self.btnImageNormal.count;

    for (int i = 0 ; i < self.btnImageNormal.count; i++) {
        CGFloat viewW = Screen_Width/count;
        UIButton* backView = [[UIButton alloc] initWithFrame:CGRectMake(i*viewW, 0, viewW, self.frame.size.height)];
        backView.tag = i;
        [self addSubview:backView];
        
        UIImageView* bkBtn = [[UIImageView alloc] initWithFrame:CGRectMake(viewW/2.0-44/2.0, self.frame.size.height/2.0-44.0/2.0, 44, 44)];
        [backView addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        bkBtn.tag = btnStartTag+i;
        [backView addSubview:bkBtn];

        if (i == 0) {
            self.tempBtn = bkBtn;
            [bkBtn setImage:self.btnImageSelected[i] ];
        }else{
            [bkBtn setImage:self.btnImageNormal[i]];
        }
    }
}


-(void)setDefaultSelect:(NSInteger)defaultSelect{
    if (self.callItemBack) {
        self.callItemBack(defaultSelect);
    }
}

-(void)itemClick:(UIButton*)sender{
    NSInteger index = sender.tag;
    UIImageView* imv = (UIImageView* )[self viewWithTag:btnStartTag+index];
    [self.tempBtn stopAnimating];
    self.tempBtn.animationImages = nil;
    if (![imv isEqual:self.tempBtn]) {
        [imv setImage:self.btnImageSelected[index]];
        [self.tempBtn setImage:self.btnImageNormal[self.tempBtn.tag-btnStartTag] ];
        self.tempBtn = imv;
        [self anmationWih:index];
    }
    
    if (self.callItemBack) {
        self.callItemBack(index);
    }
}

-(void)anmationWih:(NSInteger)index{
    
    //图片控件,坐标和大小
    UIImageView *imageView = self.tempBtn;
    // 设置图片的序列帧 图片数组
    imageView.animationImages = [self imagesWithType:index];
    //动画重复次数
    imageView.animationRepeatCount = 1;
    //动画执行时间,多长时间执行完动画
    imageView.animationDuration = 1.0;
    //开始动画
    [imageView startAnimating];
}

-(NSArray*)imagesWithType:(NSInteger)loadingType{
    
    NSArray* nameArr = @[@"sy_",@"gwc_",@"ywq_",@"wd_"];
    
    NSMutableArray *imgArray=[NSMutableArray new];
    for(int i = 1;i <= 14;i++){
        NSString *imageName;
        //通过for 循环,把我所有的 图片存到数组里面
        if (i < 10) {
            imageName=[NSString stringWithFormat:@"%@0%d",nameArr[loadingType],i];
        }else{
            imageName=[NSString stringWithFormat:@"%@%d",nameArr[loadingType],i];
        }
        UIImage *image=[UIImage imageNamed:imageName];
        [imgArray addObject:image];
    }
    return [imgArray copy];
}




@end
