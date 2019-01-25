//
//  JZTDropDownConfigManager.h
//  LHZTestIOS
//
//  Created by rainsoft on 2018/5/15.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZTDropDownConfigManager : NSObject
//标签栏背景色
@property (nonatomic, strong) UIColor *bgNormalColor;
//标签栏选中后背景色
@property (nonatomic, strong) UIColor *bgSelectedColor;
//文字未选的颜色
@property (nonatomic, strong) UIColor *textNormalColor;
//文字选中的颜色 //default = indicatorSelectedColor
@property (nonatomic, strong) UIColor *textSelectedColor;
//上下动画尖尖的默认色
@property (nonatomic, strong) UIColor *indicatorNormalColor;
//上下动画尖尖的及勾勾的勾选色
@property (nonatomic, strong) UIColor *indicatorSelectedColor;
//头部中间竖线的颜色
@property (nonatomic, strong) UIColor *separatorColor;
//头部下面横线的颜色
@property (nonatomic, strong) UIColor *bottomLineColor;
//默认选中项
@property (nonatomic, strong) NSDictionary* defaultSelectDic;

//默认选中项
@property (nonatomic, assign) NSInteger columNums;

@end
