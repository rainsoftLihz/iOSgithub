//
//  PageMainVC.h
//  LHZTestIOS
//
//  Created by rainsoft on 2017/4/26.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "MyBaseViewController.h"

@protocol kRefrashUpFinshDelegate <NSObject>

-(void)refrashUpFinsh;

@end

@interface PageMainVC : MyBaseViewController

@property (nonatomic,assign)id<kRefrashUpFinshDelegate>delegate;


/* 滑动到指定位置 */
-(void)scrollTo:(CGFloat)contentY;

@end
