//
//  LHZDownLoadOperationManager.h
//  LHZTestIOS
//
//  Created by rainsoft on 17/4/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHZDownLoadModel.h"
#import "LHZDownLoadOperation.h"
/* 
  操作队列管理类
*/
@interface LHZDownLoadOperationManager : NSObject

@property (nonatomic, assign) NSInteger maxConcurrentOperationCount;
@property (nonatomic, strong) NSMutableArray *downLoadModels;

+ (instancetype)manager;

- (void)startWithModel:(id<LHZDownLoadModel>)model;
- (void)stopWiethModel:(id<LHZDownLoadModel>)model;

/*!
 @brief 下载中任务数量
 
 @return 下载中任务数量
 */
- (NSInteger)numberOfDownloadingTask;

/**
 删除任务
 
 @param index 任务的index
 */
- (void)deleteTaskAtIndex:(NSInteger)index;

@end
