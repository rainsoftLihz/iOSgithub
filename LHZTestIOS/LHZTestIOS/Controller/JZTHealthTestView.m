//
//  JZTHealthTestView.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/1/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "JZTHealthTestView.h"

/* 图片比例系数 */
#define IMG_SCALE 371.0/588.0

#define kDD_TAG 143

#define kIMG_TAG 1342

@interface JZTHealthTestView()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView* scrollView;

@end

@implementation JZTHealthTestView

//-(instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//        [self configUI];
//        [self addImgToScrollView];
//    }
//    return self;
//}

-(instancetype)init
{
    if (self = [super init]) {
        [self configUI];
        [self addImgToScrollView];
    }
    return self;
}

-(void)configUI
{
    [self setBackgroundColor:[UIColor whiteColor]];
    /* 健康测试 */
    UILabel* healthTestLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, Screen_Width-80*2, 44.0)];
    healthTestLab.text = @"健康测试";
    healthTestLab.textAlignment = NSTextAlignmentCenter;
    healthTestLab.font = [UIFont systemFontOfSize:14];
    healthTestLab.textColor = UIColorFromRGB(0x565656);
    [self addSubview:healthTestLab];
    
    /* 更多 */
    UIButton* moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [moreBtn setTitleColor:UIColorFromRGB(0xbebebe) forState:UIControlStateNormal];
    moreBtn.frame = CGRectMake(Screen_Width-60, 0, 60, 44.0);
    [moreBtn addTarget:self action:@selector(testMore) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreBtn];
    
    [self configScrollView];

}

-(void)configScrollView
{
    [self addSubview:self.scrollView];
    
    /* 三个点点 */
    UIView* ddView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), Screen_Width, 20.0)];
    ddView.backgroundColor = [UIColor whiteColor];
    [self addSubview:ddView];
    
    CGFloat ddSpace = 5.0;
    CGFloat dd_W = 6.0;
    
    UIView* centerDD2 = [self createDDViewWithFrame:CGRectMake(Screen_Width/2.0-dd_W/2.0, CGRectGetHeight(ddView.frame)/2.0-dd_W/2.0, dd_W, dd_W)];
    centerDD2.tag = kDD_TAG+1;
    
    
    UIView* centerDD1 = [self createDDViewWithFrame:CGRectMake(Screen_Width/2.0-dd_W/2.0-ddSpace-dd_W, CGRectGetHeight(ddView.frame)/2.0-dd_W/2.0, dd_W, dd_W)];
    centerDD1.tag = kDD_TAG;
    
    UIView* centerDD3 = [self createDDViewWithFrame:CGRectMake(Screen_Width/2.0-dd_W/2.0+dd_W+ddSpace, CGRectGetHeight(ddView.frame)/2.0-dd_W/2.0, dd_W, dd_W)];
    centerDD3.tag = kDD_TAG+2;
    
    [ddView addSubview:centerDD1];
    [ddView addSubview:centerDD2];
    [ddView addSubview:centerDD3];
    
    /* 底下的背景色 */
    UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(ddView.frame), Screen_Width, 10.0)];
    bottomView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self addSubview:bottomView];
    
    self.viewHeight = CGRectGetMaxY(bottomView.frame);

}

-(UIScrollView *)scrollView
{
    CGFloat space = 5.0;
    CGFloat scroll_H = (Screen_Width-3*space)/2.0*IMG_SCALE;
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44.0, Screen_Width, scroll_H)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

-(void)addImgToScrollView
{
    NSArray* imgArr = @[@"sy_jkcs_1",@"sy_jkcs_2",@"sy_jkcs_3",@"sy_jkcs_4",@"sy_jkcs_5",@"sy_jkcs_6"];
    CGFloat space = 5.0;
    
    CGFloat img_W = (Screen_Width-3*space)/2.0;
    CGFloat img_H = img_W*IMG_SCALE;
    for (int i = 0; i < imgArr.count; i++) {
        CGFloat addSpace = 0;
        if (i == 2 || i == 3) {
            addSpace = space;
        }
        
        if (i == 4 || i == 5) {
            addSpace = 2*space;
        }
        
        UIImageView* imgV = [[UIImageView alloc] initWithFrame:CGRectMake(space+i*(img_W+space)+addSpace, 0, img_W, img_H)];
        imgV.userInteractionEnabled = YES;
        imgV.image = [UIImage imageNamed:imgArr[i]];
        imgV.tag = kIMG_TAG+i;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImg:)];
        [imgV addGestureRecognizer:tap];
        [self.scrollView addSubview:imgV];
    }
    
    self.scrollView.contentSize= CGSizeMake(Screen_Width*3.0, img_H);
}

#pragma mark --- 点击图片
-(void)clickImg:(UITapGestureRecognizer*)tap
{
    NSInteger index = tap.view.tag-kIMG_TAG;
    
    NSLog(@"index=====%ld",index);
    
}


#pragma mark --- 更多
-(void)testMore
{
    NSLog(@"=== more ===");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/Screen_Width;
  
    for (int i = 0; i < 3; i++) {
        UIView* ddView = [self viewWithTag:i+kDD_TAG];
        ddView.backgroundColor = UIColorFromRGB(0xe3e3e3);
    }
    
    /* 改变颜色 */
    UIView* ddView = [self viewWithTag:page+kDD_TAG];
    
    ddView.backgroundColor = UIColorFromRGB(0x28c4f9);
    
}

-(UIView*)createDDViewWithFrame:(CGRect)frame
{
    UIView* ddView = [[UIView alloc] initWithFrame:frame];
    
    ddView.layer.cornerRadius = CGRectGetHeight(ddView.frame)/2.0;
    
    ddView.layer.masksToBounds = YES;
    
    ddView.backgroundColor = UIColorFromRGB(0xe3e3e3);
    
    return ddView;
}

@end
