//
//  JZTTabBar.h
//  JZTAudio
//
//  Created by yanmingjun on 2017/2/21.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JZTTabBar;
@protocol JZTTabBarDelegate <NSObject>

@optional;
- (void)jztTabBarDidClickPlayButton:(JZTTabBar *)tabBar;

@end

@interface JZTTabBar : UITabBar
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, weak) id<JZTTabBarDelegate> delegates;

@end
