//
//  BaselVMModel.h
//  LHZTestIOS
//
//  Created by rainsoft on 2019/1/25.
//  Copyright © 2019年 dazhuanjia. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessBlock)(id data);
typedef void(^FailBlock)(id data);
@interface BaselVMModel : NSObject
@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailBlock failBlock;

- (void)initWithBlock:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
@end
