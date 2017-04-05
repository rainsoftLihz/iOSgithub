//
//  LHZHTTPRequest.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "LHZHttpManager.h"

#import "LHZDownLoadStore.h"

/* 任务组 */
static NSMutableArray *tasks;

@implementation LHZHttpManager

+(LHZHttpManager*)shareManager
{
    static LHZHttpManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LHZHttpManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://restapi.amap.com"]];
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
- (LHZURLSessionTask*) downLoadWithUrl:(NSString *)URLString parameters:(id)parameters progress:(LHZDownloadProgress)progressBlock completion:(LHZDownLoadCompletion)completion{
    
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
    
    if (resumeData) {
        return [self downLoadWithResumedata:resumeData withUrl:URLString progress:progressBlock completion:completion];
    }
    
    LHZURLSessionTask *sessionTask = [self downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progressBlock) {
            progressBlock(downloadProgress);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *localUrl = [LHZDownLoadStore downLoadPathWithURL:URLString];
        return localUrl;

    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
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
    
    [sessionTask resume];
    
    return sessionTask;
}


- (LHZURLSessionTask*)downLoadWithResumedata:(NSData *)resumeData withUrl:(NSString *)URLString progress:(LHZDownloadProgress)progressBlock completion:(LHZDownLoadCompletion)completion{
    
    LHZURLSessionTask *sessionTask = [self downloadTaskWithResumeData:resumeData progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progressBlock) {
            progressBlock(downloadProgress);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *localUrl = [LHZDownLoadStore downLoadPathWithURL:URLString];
        return localUrl;
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
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
    
    [sessionTask resume];
    
    return sessionTask;
}


- (LHZURLSessionTask *)downloadTaskWithRequest:(NSURLRequest *)request resumeData:(NSData *)resumeData  progress:(LHZDownloadProgress)downloadProgressBlock destination:(NSURL * (^)(NSURL * targetPath, NSURLResponse * response))destination completionHandler:(LHZDownLoadCompletion) completionHandler{
    if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
        NSError *error = [NSError errorWithDomain:@"com.jzt.error" code:1001 userInfo:@{@"error":@"用户网络不存在"}];
        completionHandler(nil,nil,error);
        return nil;
    }
    
    LHZURLSessionTask *downloadTask = nil;
    if (resumeData) {
        downloadTask = [super downloadTaskWithResumeData:resumeData progress:downloadProgressBlock destination:destination completionHandler:completionHandler];
    }else{
        downloadTask = [super downloadTaskWithRequest:request progress:downloadProgressBlock destination:destination completionHandler:completionHandler];
    }
    [downloadTask resume];
    return downloadTask;
}

@end
