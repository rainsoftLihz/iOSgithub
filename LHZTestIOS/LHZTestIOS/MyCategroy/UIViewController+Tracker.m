//
//  NSObject+Tracker.m
//  JK_BLB
//
//  Created by rainsoft on 16/6/22.
//  Copyright © 2016年 com.JoinTown.jk998. All rights reserved.
//

#import "UIViewController+Tracker.h"

static char kfromPush;

static char ktrackModel;

// 无返回值的IMP
typedef void (* _VIMP)(id,SEL, ...);
// 有返回值的IMP
typedef id(*_IMP)(id,SEL, ...);

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
//    dispatch_once(&onceToken, ^{
//        [[self class] swizzleOriginalSelector:@selector(viewWillAppear:) swizzledSelector:@selector(jzt_viewWillAppear:)];
//        [[self class] swizzleOriginalSelector:@selector(viewWillDisappear:) swizzledSelector:@selector(jzt_viewWillDisappear:)];
//        [[self class] swizzleOriginalSelector:@selector(tableView: didSelectRowAtIndexPath:) swizzledSelector:@selector(jztTableView: didSelectRowAtIndexPath:)];
//    });
    
    dispatch_once(&onceToken, ^{
        
        // 获取原始方法
        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
        // 获取原始方法的实现指针(IMP)
        _VIMP viewDidLoad_IMP = (_VIMP)method_getImplementation(viewDidLoad);
        
        // 重新设置方法的实现
        method_setImplementation(viewDidLoad, imp_implementationWithBlock(^(id target, SEL action) {
            // 调用系统的原生方法
            viewDidLoad_IMP(target, @selector(viewDidLoad));
            // 新增的功能代码
            NSLog(@"%@ did load", target);
        }));
    });
   
}

-(void)jztTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self jztTableView:tableView didSelectRowAtIndexPath:indexPath];
    
    NSLog(@"====tableviewSelect====");
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
