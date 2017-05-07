//
//  LHZDownExampleModel.h
//  LHZTestIOS
//
//  Created by rainsoft on 2017/4/7.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHZDownLoadOperation.h"
#import "LHZDownLoadModel.h"
@interface LHZDownExampleModel : NSObject <NSCoding,LHZDownLoadModel>

/********** 原始属性 **************/
@property (nonatomic, strong) LHZDownLoadOperation *operation;

@property (nonatomic, strong) NSString *downloadURL;

@property (nonatomic, assign) LHZDownloadState state;

@property (nonatomic, strong) NSProgress *progress;
/************************/

@property (nonatomic, copy  ) void(^progressHandle)(NSProgress *progress);

@property (nonatomic, copy  ) void(^stateChangeHandle)(LHZDownloadState state);

-(void)setProgressHandle:(void (^)(NSProgress *))progressHandle;
-(void)setStateChangeHandle:(void (^)(LHZDownloadState))stateChangeHandle;

@end
