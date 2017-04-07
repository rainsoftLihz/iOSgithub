//
//  LHZDownLoadOperation.h
//  LHZTestIOS
//
//  Created by rainsoft on 17/4/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHZDownLoadModel.h"

@interface LHZDownLoadOperation : NSOperation

- (instancetype)initWithDownloadModel:(id<LHZDownLoadModel>)model;

/*!
 @brief 正在等待 -> 暂停下载
 */
- (void)suspend;
- (void)readyGo;

- (void)completeOperation;

@end
