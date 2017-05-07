//
//  PageSubVC.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/4/26.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "PageSubVC.h"

#define kRefrashH 50.0

@interface PageSubVC ()

@property (nonatomic,strong) UIScrollView  *scrollerView;

/* 模拟内容视图 */
@property (nonatomic,strong) UIView*  contView;

/* 模拟刷新视图 */
@property (nonatomic,strong) UILabel* refrashView;

@end

@implementation PageSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.scrollerView];
    
    [self.scrollerView addSubview:self.contView];
    
    [self.scrollerView addSubview:self.refrashView];
    
    self.scrollerView.contentSize = CGSizeMake(Screen_Width, self.contView.bottom);
}


-(UIScrollView *)scrollerView
{
    if (_scrollerView) {
        return _scrollerView;
    }
    
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64.0)];
    
    _scrollerView.delegate = self;
    
    _scrollerView.backgroundColor = [UIColor clearColor];
    
    return _scrollerView;
}

-(UIView *)contView
{
    if (_contView) {
        return _contView;
    }
    
    _contView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height+100)];
    
    _contView.backgroundColor = [UIColor redColor];
    
    return _contView;
}

-(UILabel *)refrashView
{
    if (_refrashView) {
        return _refrashView;
    }
    
    _refrashView = [[UILabel alloc] initWithFrame:CGRectMake(0, -kRefrashH, Screen_Width, kRefrashH)];
    _refrashView.text = @"下拉刷新";
    _refrashView.textColor = [UIColor redColor];
    _refrashView.backgroundColor = [UIColor yellowColor];
    _refrashView.textAlignment = NSTextAlignmentCenter;
    return _refrashView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    CGFloat contentY = scrollView.contentOffset.y;
    if (contentY < -kRefrashH) {
        if ([self.delegate respondsToSelector:@selector(refrashDownFinsh)]) {
            [self.delegate refrashDownFinsh];
        }
    }
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
