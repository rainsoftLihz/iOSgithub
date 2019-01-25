//
//  MyDefine.h
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/22.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#ifndef MyDefine_h
#define MyDefine_h

//当前设备屏幕高度
#define Screen_Height ([[UIScreen mainScreen] bounds].size.height)
#define Screen_Width  ([[UIScreen mainScreen] bounds].size.width)

//rgb色值
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//宽高比
#define kProportion (Screen_Width/1242)
#define kHProportion (Screen_Height/2208)

//机型
#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define ISIphoneX ([[UIApplication sharedApplication]statusBarFrame].size.height == 44)

#define SafeBottomArea (ISIphoneX?34:0)

// 判断是否是iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// 状态栏高度
#define STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (STATUS_BAR_HEIGHT + 44)
// tabBar高度
#define TAB_BAR_HEIGHT (49.f + HOME_INDICATOR_HEIGHT)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

#endif /* MyDefine_h */
