//
//  NSObject+Tracker.h
//  JK_BLB
//
//  Created by rainsoft on 16/6/22.
//  Copyright © 2016年 com.JoinTown.jk998. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "JZTTrackModel.h"

@interface UIViewController (Tracker)<UITableViewDelegate>

/*!
 *
 */
@property (nonatomic,weak) id fromPush;

/*!
 *  描点模型
 */
@property (nonatomic,strong) JZTTrackModel* trackModel;


-(void)sendDataToServer;

@end
