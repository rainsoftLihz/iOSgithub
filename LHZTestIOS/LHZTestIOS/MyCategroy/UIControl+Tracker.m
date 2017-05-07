//
//  UIControl+Tracker.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/4/10.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "UIControl+Tracker.h"

@implementation UIControl (Tracker)

+(void)load{
    
    Class class = [self class];
    SEL originalSelector = @selector(sendAction:to:forEvent:);
    SEL replacementSelector = @selector(JZT_sendAction:to:forEvent:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method replacementMethod = class_getInstanceMethod(class, replacementSelector);
    
    method_exchangeImplementations(originalMethod, replacementMethod);
}

/** 切面统计  */
-(void)JZT_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    [self JZT_sendAction:action to:target forEvent:event];
    //埋点
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{

        NSLog(@"======响应事件=======");
        
    });
}


@end
