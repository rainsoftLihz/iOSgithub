//
//  JZTLHZTabBar.h
//  LHZTestIOS
//
//  Created by rainsoft on 2018/5/30.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZTLHZTabBar : UITabBar

/* 点击tabbar item回调 */
@property(nonatomic,copy) void(^callItemBack)(NSInteger index);

/* 未选中状态下的btn图片数组 */
@property (strong, nonatomic) NSArray * btnImageNormal;

/* 选中状态下的btn图片数组 */
@property (strong, nonatomic) NSArray * btnImageSelected;

@property (nonatomic,assign) NSInteger defaultSelect;
@end
