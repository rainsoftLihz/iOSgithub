//
//  PageSubVC.h
//  LHZTestIOS
//
//  Created by rainsoft on 2017/4/26.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "MyBaseViewController.h"

@protocol kRefrashDownFinshDelegate <NSObject>

-(void)refrashDownFinsh;

@end

@interface PageSubVC : MyBaseViewController

@property (nonatomic,weak)id<kRefrashDownFinshDelegate> delegate;

@end
