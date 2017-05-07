//
//  UIButton+Tracker.m
//  JK_BLB
//
//  Created by rainsoft on 2016/9/26.
//  Copyright © 2016年 com.JoinTown.jk998. All rights reserved.
//

#import "UIButton+Tracker.h"

@implementation UIButton (Tracker)

+ (void)load{
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=5.0) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[self class] swizzleOriginalSelector:@selector(addTarget: action: forControlEvents:) swizzledSelector:@selector(jztAddtarget: action: forControlEvents:)];
        });
    }
}

-(void)jztAddtarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [self jztAddtarget:target action:action forControlEvents:controlEvents];
    NSLog(@"======btnAddtarget=======");
}

+ (void)swizzleOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzelSelector{
    Class cls = [self class];
    Method originalMethod;
    Method swizzledMethod;
    
    originalMethod = class_getInstanceMethod(cls, originalSelector);
    swizzledMethod = class_getInstanceMethod(cls, swizzelSelector);
    
    BOOL isAdd = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (isAdd) {
        class_replaceMethod(self, swizzelSelector, method_getImplementation(originalMethod), method_getTypeEncoding(swizzledMethod));
    }
    else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

@end
