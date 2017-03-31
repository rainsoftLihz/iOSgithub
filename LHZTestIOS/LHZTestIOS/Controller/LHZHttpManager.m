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


+(NSMutableArray *)tasks{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //NSLog(@"创建数组");
        tasks = [[NSMutableArray alloc] init];
    });
    return tasks;
}

-(instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/javascript", @"text/json", @"text/html", @"text/plain", nil];
        self.requestSerializer.timeoutInterval = 60;
    }
    return self;
}

- (LHZURLSessionTask*) GET:(NSString *)URLString parameters:(id)parameters completion:(LHZHttpResponseBlock)completion{
    
    LHZURLSessionTask *sessionTask = [self GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (completion) {
            completion(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (completion) {
            completion(nil,error);
        }
    }];
    
    if (sessionTask) {
        //[[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
}




@end
