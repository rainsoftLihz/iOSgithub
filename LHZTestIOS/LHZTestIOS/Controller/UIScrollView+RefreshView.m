//
//  UIScrollView+RefreshView.m
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/29.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import "UIScrollView+RefreshView.h"

#import <objc/runtime.h>

/* 视图的高度 */
#define kRefreshViewHeight 120

/* 触发的高度 */
#define kRefreshTriggerHeight 50

static char kRefreshView;

@interface TableRefreshView()

@property (nonatomic,strong)UIImageView* animationView;

@property (nonatomic, copy) void (^pullToRefreshActionHandler)(void);

@end

@implementation UIScrollView (RefreshView)

@dynamic refreshView;

-(void)addRefreshHeaderWithActionHandler:(void (^)(void))actionHandler
{
    if (!self.refreshView) {
        TableRefreshView* refreshView = [[TableRefreshView alloc] initWithFrame:CGRectMake(0, -kRefreshViewHeight, self.bounds.size.width, kRefreshViewHeight)];
        
        [self addSubview:refreshView];
        
        self.refreshView = refreshView;
        
        /* 持有scrollView 实时改变它的contentInset*/
        self.refreshView.scrollView = self;
        
        /* 设置scrollView代理 为refreshView */
        self.delegate = self.refreshView;
        
        /* 状态改变的回调 */
        self.refreshView.pullToRefreshActionHandler = actionHandler;
        
        /* 初始contentInset */
        self.refreshView.originalTopInset = self.contentInset.top;
    }
}


#pragma mark ---  运行时加载
-(TableRefreshView *)refreshView
{
    return objc_getAssociatedObject(self, &kRefreshView);
}

- (void)setRefreshView:(TableRefreshView *)refreshView
{
    [self willChangeValueForKey:@"TableRefreshView"];
    objc_setAssociatedObject(self, &kRefreshView,
                             refreshView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"TableRefreshView"];
}

@end


#pragma mark ---- 刷新的UI视图

@implementation TableRefreshView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        [self addRefreshView];
       
    }
    return self;
}


#pragma mark --- 刷新的动画视图
-(void)addRefreshView
{
    self.animationView = [[UIImageView alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"wu1" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage sd_animatedGIFWithData:data];
    self.animationView.image = image;
    [self addSubview:self.animationView];
    
    [self.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 120));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
}


#pragma mark --- 改变状态
- (void)setCurrentState:(kRefreshState)newState {
    
    if (_currentState == newState){
        return; 
    }
    
    /* 上次的刷新状态 */
    kRefreshState previousState = _currentState;
    /* new刷新状态 */
    _currentState = newState;
    
    [self setNeedsLayout];
    
    switch (newState) {
        case kRefreshStateStopped:
            [self resetScrollViewContentInset];
            break;
            
        case kRefreshStateTriggered:
            [self startAnimating];
            break;
            
        case kRefreshStateLoading:
            [self setScrollViewContentInsetForLoading];
            
            if (previousState == kRefreshStateTriggered && self.pullToRefreshActionHandler)
                self.pullToRefreshActionHandler();
            break;
            
        default: break;
    }
}

#pragma mark - ScrollView contentInset
- (void)resetScrollViewContentInset {
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.top = self.originalTopInset;
    [self setScrollViewContentInset:currentInsets];
}

- (void)setScrollViewContentInsetForLoading {
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.top = kRefreshViewHeight;
    
    [self setScrollViewContentInset:currentInsets];
}

- (void)setScrollViewContentInset:(UIEdgeInsets)contentInset {
    
    [UIView animateWithDuration:0.3 animations:^{
    
        self.scrollView.contentInset = contentInset;
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }];
}

#pragma mark --- 开始刷新 可以执行一些动画效果
- (void)startAnimating {

}


#pragma mark --- 滑动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
}

#pragma mark --- 开始拖拽
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.currentState == kRefreshStateLoading) {
        return;
    }
    
    self.currentState = kRefreshStateTriggered;
}

#pragma mark --- 开始减速
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (self.currentState == kRefreshStateLoading) {
        return;
    }
    
    if (scrollView.contentOffset.y < -kRefreshTriggerHeight) {
        /*刷新*/
        self.currentState = kRefreshStateLoading;
    }

}

#pragma mark --- 结束刷新
-(void)endRefresh
{
    self.currentState = kRefreshStateStopped;
}

@end
