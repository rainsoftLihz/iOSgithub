//
//  UITapGestureRecognizer+Tracker.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/4/10.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "UIGestureRecognizer+Tracker.h"

@implementation UIGestureRecognizer (Tracker)

+ (void)load
{
    Method initOriginalMethod = class_getInstanceMethod([self class], @selector(initWithTarget:action:));
    Method initSwizzledMethod = class_getInstanceMethod([self class], @selector(vi_initWithTarget:action:));
    
    method_exchangeImplementations(initOriginalMethod, initSwizzledMethod);
}

- (instancetype)vi_initWithTarget:(nullable id)target action:(nullable SEL)action
{
    UIGestureRecognizer *selfGestureRecognizer = [self vi_initWithTarget:target action:action];
    
    if (!target && !action) {
        return selfGestureRecognizer;
    }
    
    if ([target isKindOfClass:[UIScrollView class]]) {
        return selfGestureRecognizer;
    }
    
    if ([target isKindOfClass:[UIAlertView class]]) {
        return selfGestureRecognizer;
    }
    
    Class class = [target class];
    
    SEL originalSEL = action;
    SEL swizzledSEL = NSSelectorFromString([NSString stringWithFormat:@"vi_%@", NSStringFromSelector(action)]);
    
    BOOL isAddMethod = class_addMethod(class, swizzledSEL, (IMP)vi_gestureAction, "v@:@");
    
    if (isAddMethod) {
        Method originalMethod = class_getInstanceMethod(class, originalSEL);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
    return selfGestureRecognizer;
}


void vi_gestureAction(UIGestureRecognizer* self, SEL _cmd, id sender) {
    SEL swizzledSEL = NSSelectorFromString([NSString stringWithFormat:@"vi_%@", NSStringFromSelector(_cmd)]);
    ((void(*)(id, SEL, id))objc_msgSend)(self, swizzledSEL, sender);
    ;
    NSLog(@"======gestureAction======");
    //[[VIAnalyticsAOP sharedInstance] vi_analyticsSource:sender action:_cmd target:self];
}

@end
