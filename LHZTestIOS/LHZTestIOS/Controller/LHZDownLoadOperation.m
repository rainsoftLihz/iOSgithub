//
//  LHZDownLoadOperation.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/4/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "LHZDownLoadOperation.h"
#import "LHZDownLoadStore.h"
#import "LHZHttpManager.h"
@interface LHZDownLoadOperation()
{
    BOOL executing;
    BOOL finished;
    BOOL ready;
}

@property (nonatomic, weak) id<LHZDownLoadModel> model;
@property (nonatomic, strong) LHZURLDownloadSessionTask *task;
@end

@implementation LHZDownLoadOperation

//-(instancetype)init
//{
//    if (self = [super init]) {
//        executing = NO;
//        finished = NO;
//        ready = YES;
//    }
//    return self;
//}

- (instancetype)initWithDownloadModel:(id<LHZDownLoadModel>)model{
    if (self = [super init]) {
        executing = NO;
        finished = NO;
        ready = YES;
        self.model = model;
        self.model.state = LHZDownloadStateWaiting;
    }
    return self;
}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

- (BOOL)isReady{
    return ready;
}

- (void)start{
    self.model.state = LHZDownloadStateRunning;
    [self download];
    
    [self willChangeValueForKey:@"isExecuting"];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)suspend{
    self.model.state = LHZDownloadStateSuspended;
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isReady"];
    ready = NO;
    executing = NO;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isReady"];
}

- (void)readyGo{
    self.model.state = LHZDownloadStateWaiting;
    [self willChangeValueForKey:@"isReady"];
    ready = YES;
    [self didChangeValueForKey:@"isReady"];
}

- (void)cancel{
    self.model.state = LHZDownloadStateSuspended;
    [self.task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        [LHZDownLoadStore saveResumeData:resumeData WithKey:self.model.downloadURL];
    }];
    
    [self completeOperation];
}

- (void)completeOperation {
    self.model.operation = nil;
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

#pragma mark - 下载
- (void)download{
    self.task = [[LHZHttpManager shareManager] downLoadWithUrl:self.model.downloadURL parameters:nil progress:^(NSProgress *progress) {
        
        if (progress.fractionCompleted < 1 && self.model.state != LHZDownloadStateRunning) {
           self.model.state = LHZDownloadStateRunning;
        }
        
        
    } completion:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) {
            self.model.state = LHZDownloadStateFailed;
        }else{
            self.model.state = LHZDownloadStateCompleted;
        }
        [self completeOperation];
    }];

}


@end
