//
//  JZTTrackModel.h
//  LHZTestIOS
//
//  Created by rainsoft on 2017/4/7.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZTTrackModel : NSObject

@property (nonatomic,strong)NSString* app_id;

@property (nonatomic,strong)NSString* app_type;

-(void)sendDataToServer;
@end
