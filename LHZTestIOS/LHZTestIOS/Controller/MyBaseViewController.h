//
//  MyBaseViewController.h
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/22.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewController+Tracker.h"

#import "JZTTrackModel.h"

@interface MyBaseViewController : UIViewController

@property (nonatomic,strong)NSString* titleStr;

@property (nonatomic,strong)JZTTrackModel* trackModel;

-(void)configParams:(id)params;

@end
