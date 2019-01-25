//
//  AppDelegate+CatchCrash.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/6/19.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "AppDelegate+CatchCrash.h"

@implementation AppDelegate (CatchCrash)

void uncaughtExceptionHandler(NSException *exception)

{
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    
    // 出现异常的原因
    NSString *reason = [exception reason];
    
    // 异常名称
    NSString *name = [exception name];
    
    //异常log信息
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@",name, reason, stackArray];
    
    NSLog(@"%@", exceptionInfo);
    
    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:stackArray];
    
    [tmpArr insertObject:reason atIndex:0];
    
    //保存到本地  --  当然你可以在下次启动的时候，上传这个log
    [exceptionInfo writeToFile:[NSString stringWithFormat:@"%@/Documents/error.log",NSHomeDirectory()]  atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
}

@end
