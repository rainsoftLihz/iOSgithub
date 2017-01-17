//
//  UIScrollView+RefreshView.h
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/29.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kRefreshStateStopped = 0,
    kRefreshStateTriggered,
    kRefreshStateLoading
} kRefreshState;

@class TableRefreshView;

@interface UIScrollView (RefreshView)

@property (nonatomic,strong) TableRefreshView *refreshView;

- (void)addRefreshHeaderWithActionHandler:(void (^)(void))actionHandler;


@end

@interface TableRefreshView : UIView <UIScrollViewDelegate>

/* 拿住上层的scrollView 监听contentOffset */
@property (nonatomic,weak)UIScrollView* scrollView;

@property (nonatomic, assign) kRefreshState currentState;

@property (nonatomic, assign) CGFloat originalTopInset;

-(void)endRefresh;

@end
