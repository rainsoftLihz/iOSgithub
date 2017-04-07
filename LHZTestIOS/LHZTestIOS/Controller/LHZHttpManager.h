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
typedef void( ^ LHZDownloadProgress)(NSProgress *progress);

/* 下载完成block */
typedef void (^ LHZDownLoadCompletion)(NSURLResponse *response, NSURL * filePath, NSError *error);

/* 上传进度block */
typedef void (^ LHZUpLoadProgress)(int64_t byteProgress,int64_t totlytesProgress);

/**
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
typedef NSURLSessionTask LHZURLSessionTask;

typedef NSURLSessionDownloadTask LHZURLDownloadSessionTask;

@interface LHZHttpManager : AFHTTPSessionManager

+(LHZHttpManager*)shareManager;


/* GET */
- (LHZURLSessionTask *) GET:(NSString *)URLString parameters:(id)parameters completion:(LHZHttpResponseBlock)completion;

/* downLoad */
- (LHZURLDownloadSessionTask*) downLoadWithUrl:(NSString *)URLString parameters:(id)parameters progress:(LHZDownloadProgress)progressBlock completion:(LHZDownLoadCompletion)completion;

@end
