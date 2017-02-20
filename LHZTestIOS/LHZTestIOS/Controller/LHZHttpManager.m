//
//  LHZHTTPRequest.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "LHZHttpManager.h"

@implementation LHZHttpManager

+(LHZHttpManager*)shareManager
{
    static LHZHttpManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LHZHttpManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://restapi.amap.com"]];
//        manager = [LHZHttpManager manager];
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
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

- (NSURLSessionDataTask *) GET:(NSString *)URLString parameters:(id)parameters completion:(void(^)(NSURLSessionDataTask *task, id JSON, NSError* anError))completion{
    
    NSURLSessionDataTask *task = [self GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (completion) {
            completion(task,responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (completion) {
            completion(task,nil,error);
        }
    }];
    
    return task;
    
}

@end
