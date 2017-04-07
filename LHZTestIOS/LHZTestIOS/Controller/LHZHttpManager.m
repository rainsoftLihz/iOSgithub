//
//  LHZHTTPRequest.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "LHZHttpManager.h"

#import "LHZDownLoadStore.h"

@implementation LHZHttpManager

+(LHZHttpManager*)shareManager
{
    static LHZHttpManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LHZHttpManager alloc] initWithBaseURL:nil];
    });
    
    return manager;
}


-(instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/javascript", @"text/json", @"text/html", @"text/plain", nil];
        self.requestSerializer.timeoutInterval = 60;
    }
    return self;
}

#pragma mark ---- GET
- (LHZURLSessionTask*) GET:(NSString *)URLString parameters:(id)parameters completion:(LHZHttpResponseBlock)completion{
    
    LHZURLSessionTask *sessionTask = [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            completion(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(nil,error);
        }
    }];

    return sessionTask;
}


#pragma mark ---- POST
- (LHZURLSessionTask*) POST:(NSString *)URLString parameters:(id)parameters completion:(LHZHttpResponseBlock)completion{
    
    LHZURLSessionTask *sessionTask = [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            completion(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(nil,error);
        }
    }];
    
    return sessionTask;
}

#pragma mark ---- downLoad
- (LHZURLDownloadSessionTask*) downLoadWithUrl:(NSString *)URLString parameters:(id)parameters progress:(LHZDownloadProgress)progressBlock completion:(LHZDownLoadCompletion)completion{
    
    /* 如果文件存在 表示已经是下载过的 无需创建task */
    if ([LHZDownLoadStore fileExistWithURL:URLString]) {
        if (progressBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSProgress *progress = [[NSProgress alloc]init];
                unsigned long long size = [LHZDownLoadStore fileSizeWithURL:URLString]*(1024.*1024.);
                progress.totalUnitCount = size;
                progress.completedUnitCount = size;
                progressBlock(progress);
            });
        }
        if (completion) {
            completion(nil,[LHZDownLoadStore downLoadPathWithURL:URLString],nil);
        }
        return nil;
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    NSData *resumeData = [LHZDownLoadStore resumeDataWithKey:URLString];

    return [self downloadTaskWithRequest:downloadRequest resumeData:resumeData progress:^(NSProgress *progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"%@",[NSString stringWithFormat:@"文件大小:%@ 已下载:%@ %.2f%@",[LHZDownLoadStore CountBytesBy:progress.totalUnitCount],[LHZDownLoadStore CountBytesBy:progress.completedUnitCount],100.0 * progress.completedUnitCount/progress.totalUnitCount,@"%"]);
            if (progressBlock) {
                progressBlock(progress);
            }
        });
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        /* 文件下载后存储的路径 */
        NSURL *localUrl = [LHZDownLoadStore downLoadPathWithURL:URLString];
        return localUrl;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSURL *localUrl = [LHZDownLoadStore downLoadPathWithURL:URLString];
        BOOL result = NO;
        if ([localUrl isEqual:filePath]) {
            result = YES;
            [LHZDownLoadStore removeResumeDataWithKey:URLString];
        }
        if (result && completion) {
            completion(response,filePath,error);
        }
        else {
            if (completion) {
                completion(nil,nil,error);
            }
        }
    }];

}


#pragma mark --- 下载
- (LHZURLDownloadSessionTask *)downloadTaskWithRequest:(NSURLRequest *)request resumeData:(NSData *)resumeData  progress:(LHZDownloadProgress)downloadProgressBlock destination:(NSURL * (^)(NSURL * targetPath, NSURLResponse * response))destination completionHandler:(LHZDownLoadCompletion) completionHandler{
//    if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
//        NSError *error = [NSError errorWithDomain:@"com.jzt.error" code:1001 userInfo:@{@"error":@"用户网络不存在"}];
//        completionHandler(nil,nil,error);
//        return nil;
//    }
    
    LHZURLDownloadSessionTask *downloadTask = nil;
    if (resumeData) {
        downloadTask = [super downloadTaskWithResumeData:resumeData progress:downloadProgressBlock destination:destination completionHandler:completionHandler];
    }else{
        downloadTask = [super downloadTaskWithRequest:request progress:downloadProgressBlock destination:destination completionHandler:completionHandler];
    }
    [downloadTask resume];
    return downloadTask;
}

@end
