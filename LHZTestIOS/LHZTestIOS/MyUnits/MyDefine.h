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


#endif /* MyDefine_h */
