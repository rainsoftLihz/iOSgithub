//
//  AppDelegate+CatchCrash.h
//  LHZTestIOS
//
//  Created by rainsoft on 2017/6/19.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (CatchCrash)

void uncaughtExceptionHandler(NSException *exception); 

@end
