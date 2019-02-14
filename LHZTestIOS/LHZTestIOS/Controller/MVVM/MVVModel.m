//
//  MVVModel.m
//  LHZTestIOS
//
//  Created by rainsoft on 2019/1/25.
//  Copyright © 2019年 dazhuanjia. All rights reserved.
//

#import "MVVModel.h"
@interface MVVModel()
@property(nonatomic,strong) NSMutableArray* dataArr;
@end
@implementation MVVModel

// 数据 -- 逻辑 vm
- (instancetype)init{
    if (self==[super init]) {
        
        // 响应式编程
        [RACObserve(self, model) subscribeNext:^(id  _Nullable x) {
            // 数据变化 model <---> UI
            @synchronized (self.dataArr) {
                [self.dataArr removeObject:x];
                if (self.successBlock) {
                    self.successBlock(self.dataArr);
                }
            }
        }];
        
    }
    return self;
}


- (void)loadData{
    // 异步
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSArray *array = @[@"转账",@"信用卡",@"充值中心",@"蚂蚁借呗",@"电影票",@"滴滴出行",@"城市服务",@"蚂蚁森林"];
        NSMutableArray* arr = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            Model* model = [[Model alloc] init];
            model.name = array[i];
            [arr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataArr=arr;
            if (self.successBlock) {
                self.successBlock(arr);
            }
        });
    });
    
}

@end
