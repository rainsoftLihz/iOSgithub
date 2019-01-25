//
//  JZTDropDownConfigManager.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/5/15.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "JZTDropDownConfigManager.h"

@implementation JZTDropDownConfigManager

- (UIColor *)bgNormalColor{
    if (!_bgNormalColor) {
        _bgNormalColor = [UIColor whiteColor];
    }
    return _bgNormalColor;
}

- (UIColor *)bgSelectedColor{
    if (!_bgSelectedColor) {
        _bgSelectedColor = [UIColor whiteColor];
    }
    return _bgSelectedColor;
}

- (UIColor *)indicatorNormalColor {
    if (!_indicatorNormalColor) {
        _indicatorNormalColor = [UIColor colorWithWhite:0.518 alpha:1.000];
    }
    return _indicatorNormalColor;
}

- (UIColor *)indicatorSelectedColor{
    if (!_indicatorSelectedColor) {
        _indicatorSelectedColor = [UIColor colorWithRed:0.157 green:0.769 blue:0.686 alpha:1.000];
    }
    return _indicatorSelectedColor;
}

- (UIColor *)textNormalColor{
    if (!_textNormalColor) {
        _textNormalColor = [UIColor colorWithWhite:0.518 alpha:1.000];
    }
    return _textNormalColor;
}

- (UIColor *)textSelectedColor{
    if (!_textSelectedColor) {
        _textSelectedColor = self.indicatorSelectedColor;
    }
    return _textSelectedColor;
}

- (UIColor *)separatorColor {
    if (!_separatorColor) {
        _separatorColor = [UIColor clearColor];
    }
    return _separatorColor;
}

- (UIColor *)bottomLineColor{
    if (!_bottomLineColor) {
        _bottomLineColor = [UIColor colorWithWhite:0.816 alpha:1.000];
    }
    return _bottomLineColor;
}


-(NSDictionary*)defaultSelectDic{
    if (!_defaultSelectDic) {
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        for (int i = 0; i < _columNums; i++) {
            [dic setObject:@(-1) forKey:[NSNumber numberWithInteger:i]];
        }
        _defaultSelectDic = dic;
    }
    return _defaultSelectDic;
}

@end
