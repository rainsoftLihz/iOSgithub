//
//  LHZHTTPRequest.h
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 返回结果block */
typedef void (^ LHZHttpResponseBlock)(id response, NSError* anError);

/* 下载进度block */
typedef void( ^ LHZDownloadProgress)(int64_t bytesProgress,
int64_t totalBytesProgress);

/* 上传进度block */
typedef void (^ LHZUpLoadProgress)(int64_t byteProgress,int64_t totlytesProgress);

/**
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
typedef NSURLSessionTask LHZURLSessionTask;

@interface LHZHttpManager : AFHTTPSessionManager

+(LHZHttpManager*)shareManager;


/* GET */
- (LHZURLSessionTask *) GET:(NSString *)URLString parameters:(id)parameters completion:(LHZHttpResponseBlock)completion;

/* downLoad */
- (LHZURLSessionTask*) downLoadWithUrl:(NSString *)URLString parameters:(id)parameters saveToPath:(NSString *)saveToPath progress:(LHZDownloadProgress)progressBlock completion:(LHZHttpResponseBlock)completion;

- (LHZURLSessionTask*)breakpointResume:(BOOL)breakPoint downLoadWithUrl:(NSString *)URLString parameters:(id)parameters saveToPath:(NSString *)saveToPath progress:(LHZDownloadProgress)progressBlock completion:(LHZHttpResponseBlock)completion;

@end
