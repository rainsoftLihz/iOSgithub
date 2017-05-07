//
//  PageAnnimaionVC.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/4/26.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "PageAnnimaionVC.h"
#import "PageSubVC.h"
#import "PageMainVC.h"
@interface PageAnnimaionVC ()<kRefrashUpFinshDelegate,kRefrashDownFinshDelegate>

@property (nonatomic,strong) PageMainVC* mainViewController;

@property (nonatomic,strong) PageSubVC* subViewController;

@property (nonatomic,strong) UIScrollView  *scrollerView;

@end

@implementation PageAnnimaionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.scrollerView];
    
    [self.scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.mas_equalTo(self.view);
    }];
    
    [self addSubVC];
}

-(UIScrollView *)scrollerView
{
    if (_scrollerView) {
        return _scrollerView;
    }
    
    _scrollerView = [[UIScrollView alloc] init];
    
    _scrollerView.delegate = self;
    
    _scrollerView.backgroundColor = [UIColor clearColor];
   
    _scrollerView.bounces = NO;
    
    return _scrollerView;
}


-(PageMainVC *)mainViewController
{
    if (_mainViewController) {
        return _mainViewController;
    }
    
    _mainViewController = [[PageMainVC alloc] init];
    
    _mainViewController.delegate = self;
    
    return _mainViewController;
}

-(PageSubVC *)subViewController
{
    if (_subViewController) {
        return _subViewController;
    }

    _subViewController = [[PageSubVC alloc] init];
    
    _subViewController.delegate = self;
    
    return _subViewController;
}

-(void)addSubVC
{
    self.mainViewController.view.frame = CGRectMake(0, 0, Screen_Width, Screen_Height-64.0);
    [self.scrollerView addSubview:self.mainViewController.view];

    
    self.subViewController.view.frame = CGRectMake(0, Screen_Height-64.0, Screen_Width, Screen_Height-64.0);
    [self.scrollerView addSubview:self.subViewController.view];
    

    [self.scrollerView setContentSize:CGSizeMake(Screen_Width, Screen_Height-64.0)];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

#pragma mark --- 上拉刷新
-(void)refrashUpFinsh
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.scrollerView setContentOffset:CGPointMake(0, Screen_Height-64.0)]; 
    }];
   
}

#pragma mark --- 下拉刷新
-(void)refrashDownFinsh
{
    /* 如果需要mainVC 滑动到顶部 */
    [self.mainViewController scrollTo:0];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.scrollerView setContentOffset:CGPointMake(0, 0)];
    }];
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
