//
//  UIColor+Common.m
//  JZTAudio
//
//  Created by 梁泽 on 2017/2/21.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#import "UIColor+Common.h"
#import <YYKit/UIColor+YYAdd.h>
@implementation UIColor (Common)
+ (UIColor *)navTitleColor{
    return [self randomColor];
}

+ (UIColor *)randomColor{
    CGFloat r = (arc4random() % 255 / 255.0 );
    CGFloat g = (arc4random() % 128 / 255.0 );
    CGFloat b = (arc4random() % 128 / 255.0 );
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end
