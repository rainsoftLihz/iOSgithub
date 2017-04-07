//
//  NSObject+JZTSwizzleClass.m
//  JK_BLB
//
//  Created by 朱小亮 on 16/6/22.
//  Copyright © 2016年 com.JoinTown.jk998. All rights reserved.
//

#import "UIViewController+Tracker.h"

static char kfromPush;

static char ktrackModel;

@implementation UIViewController (Tracker)

@dynamic fromPush;

@dynamic trackModel;

#pragma mark ---  运行时加载
-(id)fromPush
{
    return objc_getAssociatedObject(self, &kfromPush);
}

- (void)setFromPush:(id)fromPush
{
    [self willChangeValueForKey:@"fromPush"];
    objc_setAssociatedObject(self, &kfromPush,
                             fromPush,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"fromPush"];
}

-(JZTTrackModel *)trackModel
{
    return objc_getAssociatedObject(self, &ktrackModel);
}

-(void)setTrackModel:(JZTTrackModel *)trackModel
{
    [self willChangeValueForKey:@"trackModel"];
    objc_setAssociatedObject(self, &ktrackModel,
                             trackModel,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"trackModel"];
}

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] swizzleOriginalSelector:@selector(viewWillAppear:) swizzledSelector:@selector(jzt_viewWillAppear:)];
        [[self class] swizzleOriginalSelector:@selector(viewWillDisappear:) swizzledSelector:@selector(jzt_viewWillDisappear:)];
    });
   
}

- (void)jzt_viewWillAppear:(BOOL)b{

    [self jzt_viewWillAppear:b];
    NSLog(@"appearClass = %@",self.class);
    [self sendDataToServer];
}

- (void)jzt_viewWillDisappear:(BOOL)b{
    [self jzt_viewWillDisappear:b];
    NSLog(@"disappearClass = %@",self.class);

}

-(void)sendDataToServer
{
    NSLog(@"=====sendDataToServer");
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
