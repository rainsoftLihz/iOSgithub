//
//  LHZHTTPRequest.h
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHZHttpManager : AFHTTPSessionManager

+(LHZHttpManager*)shareManager;

- (NSURLSessionDataTask *) GET:(NSString *)URLString parameters:(id)parameters completion:(void(^)(NSURLSessionDataTask *task, id JSON, NSError* anError))completion;

@end
