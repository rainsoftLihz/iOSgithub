//
//  JZTTabBar.m
//  JZTAudio
//
//  Created by yanmingjun on 2017/2/21.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#import "JZTTabBar.h"

@implementation JZTTabBar
@synthesize delegates;

- (void)playButtonPressed:(id)sender {
    if ([self.delegates respondsToSelector:@selector(jztTabBarDidClickPlayButton:)]) {
        [self.delegates jztTabBarDidClickPlayButton:self];
    }
}

-(instancetype)init
{
    if (self = [super init]) {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
        [self setShadowImage:[UIImage new]];
        
        //[self setupPlayBtn];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
        [self setShadowImage:[UIImage new]];
        
        //[self setupPlayBtn];
    }
    return self;
}

- (void)setupPlayBtn{
//    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_np_normal"]];
//    [self addSubview:bgImageView];
//    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self);
//        make.bottom.equalTo(self).offset(-SafeBottomArea);
//    }];
//    UIImageView *shadowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_np_shadow"]];
//    [self addSubview:shadowImageView];
//    [shadowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.bottom.equalTo(self);
//        //make.bottom.equalTo(self).offset(-SafeBottomArea);
//    }];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_np_playshadow"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"tabbar_np_play"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"tabbar_np_playnon"] forState:UIControlStateSelected];
//    btn.adjustsImageWhenHighlighted = NO;
//    [btn addTarget:self action:@selector(playButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_playBtn = btn];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self);
//        make.top.equalTo(bgImageView).offset(8);
//    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //CGFloat tabBarItemWidth = self.frame.size.width / 5 - 4;
    CGFloat tabBarItemWidth = self.frame.size.width / 4 - 4;
    CGFloat tabBarItemIndex = 0;
    for (UIView *childItem in self.subviews) {
        if ([childItem isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            CGRect frame = childItem.frame;
            frame.size.width = tabBarItemWidth;
            frame.origin.x = tabBarItemIndex * (tabBarItemWidth + 4) + 2;
            childItem.frame = frame;
            tabBarItemIndex ++;
//            if (tabBarItemIndex == 2) {
//                tabBarItemIndex ++;
//            }
        } else if ([childItem isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            childItem.layer.shadowOffset = CGSizeZero;
            childItem.layer.shadowColor = [UIColor blackColor].CGColor;
            childItem.layer.shadowRadius = 5;
            childItem.layer.shadowOpacity = 0.3;
        }
    }
}

@end
