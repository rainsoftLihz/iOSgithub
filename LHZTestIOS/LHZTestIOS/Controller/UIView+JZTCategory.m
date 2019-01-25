//
//  UIView+JZTCategory.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/4/25.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "UIView+JZTCategory.h"

@implementation UIView (JZTCategory)

#pragma mark - add subViews
-(void)addSubViews:(NSArray *)subViews
{
    [subViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [self addSubview:view];
    }];
}

@end
