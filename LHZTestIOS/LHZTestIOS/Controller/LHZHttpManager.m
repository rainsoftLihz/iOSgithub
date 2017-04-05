//
//  LHZHTTPRequest.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "LHZHttpManager.h"

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
- (LHZURLSessionTask*) downLoadWithUrl:(NSString *)URLString parameters:(id)parameters saveToPath:(NSString *)saveToPath progress:(LHZDownloadProgress)progressBlock completion:(LHZHttpResponseBlock)completion{
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    LHZURLSessionTask *sessionTask = [self downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progressBlock) {
            progressBlock(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        if (!saveToPath) {
            
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSLog(@"默认路径--%@",downloadURL);
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
            
        }else{
            return [NSURL fileURLWithPath:saveToPath];
            
        }

    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (!error) {
            if (completion) {
                /* 返回文件保存的地址 */
                completion(filePath,nil);
            }
        }
        else {
            if (completion) {
                completion(nil,error);
            }
        }
        
    }];
    
    return sessionTask;
}


- (LHZURLSessionTask*)breakPointResumeDownLoadWithUrl:(NSString *)URLString parameters:(id)parameters saveToPath:(NSString *)saveToPath progress:(LHZDownloadProgress)progressBlock completion:(LHZHttpResponseBlock)completion{
    
    NSURLRequest *downloadRequest = [self downLoatdUrl:URLString anddownPath:saveToPath];
    unsigned long long downLoadSize = [self fileSizeForPath:saveToPath];
    
    LHZURLSessionTask *sessionTask = [self downloadTaskWithResumeData:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progressBlock) {
            progressBlock(downloadProgress.completedUnitCount+downLoadSize,downloadProgress.totalUnitCount);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        if (!saveToPath) {
            
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSLog(@"默认路径--%@",downloadURL);
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
            
        }else{
            return [NSURL fileURLWithPath:saveToPath];
            
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (!error) {
            if (completion) {
                /* 返回文件保存的地址 */
                completion(filePath,nil);
            }
        }
        else {
            if (completion) {
                completion(nil,error);
            }
        }
        
    }];
    
    return sessionTask;
}

#pragma mark --- 断点续传
//获取已下载的文件大小
- (unsigned long long)fileSizeForPath:(NSString *)path {
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new];
    // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}


-(NSURLRequest *)downLoatdUrl:(NSString*)downloadUrl anddownPath:(NSString*)downloadPath
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:downloadUrl]];
    //检查文件是否已经下载了一部分
    unsigned long long downloadedBytes = 0;
    if ([[NSFileManager defaultManager] fileExistsAtPath:downloadPath]) {
        //获取已下载的文件长度
        downloadedBytes = [self fileSizeForPath:downloadPath];
        if (downloadedBytes > 0) {
            NSMutableURLRequest *mutableURLRequest = [request mutableCopy];
            NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
            [mutableURLRequest setValue:requestRange forHTTPHeaderField:@"Range"];
            request = mutableURLRequest;
        }
    }
    //不使用缓存，避免断点续传出现问题
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    return request;
}


@end
