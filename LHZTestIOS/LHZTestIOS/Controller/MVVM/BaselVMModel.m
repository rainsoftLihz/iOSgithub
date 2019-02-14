//
//  BaselVMModel.m
//  LHZTestIOS
//
//  Created by rainsoft on 2019/1/25.
//  Copyright © 2019年 dazhuanjia. All rights reserved.
//

#import "BaselVMModel.h"

@implementation BaselVMModel
- (void)initWithBlock:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    _successBlock = successBlock;
    _failBlock    = failBlock;
}
@end
