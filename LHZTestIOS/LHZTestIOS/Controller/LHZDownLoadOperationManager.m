//
//  LHZDownLoadOperationManager.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/4/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "LHZDownLoadOperationManager.h"

#import "LHZDownLoadStore.h"

@interface LHZDownLoadOperationManager()

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end


@implementation LHZDownLoadOperationManager

+ (instancetype)manager{
    static LHZDownLoadOperationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        _downLoadModels = [NSMutableArray arrayWithArray:[LHZDownLoadStore locationModels]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAppTerminateSaveData:) name:UIApplicationWillTerminateNotification object:nil];
        _operationQueue = [[NSOperationQueue alloc]init];
        self.maxConcurrentOperationCount = 2;
    }
    return self;
}

- (void)setMaxConcurrentOperationCount:(NSInteger)maxConcurrentOperationCount{
    _maxConcurrentOperationCount = maxConcurrentOperationCount;
    self.operationQueue.maxConcurrentOperationCount = maxConcurrentOperationCount;
}

- (void)startWithModel:(id<LHZDownLoadModel>)model{
    if (model.state != LHZDownloadStateCompleted) {
        if (![self.operationQueue.operations containsObject:model.operation]) {
            [self.operationQueue addOperation:model.operation];
        }else{
            [model.operation readyGo];
        }
    }
}

- (void)stopWiethModel:(id<LHZDownLoadModel>)model{
    if (model.operation.isExecuting) {
        [model.operation cancel];
    } else {
        [model.operation suspend];
    }
}

- (NSInteger)numberOfDownloadingTask{
    return self.downLoadModels.count;
}

- (void)deleteTaskAtIndex:(NSInteger)index{
    id<LHZDownLoadModel> model = self.downLoadModels[index];
    [model.operation cancel];
    [self.downLoadModels removeObjectAtIndex:index];
    [LHZDownLoadStore saveModels:self.downLoadModels];
    
}
#pragma mark - NSNotification
- (void)handleAppTerminateSaveData:(NSNotification *)notification{
    [self.operationQueue cancelAllOperations];
    for (id<LHZDownLoadModel> model in self.downLoadModels) {
        if (model.state != LHZDownloadStateCompleted && model.state != LHZDownloadStateFailed) {
            model.state = LHZDownloadStateNone;
        }
    }
    [LHZDownLoadStore saveModels:self.downLoadModels];
}

@end
