//
//  MVVModel.h
//  LHZTestIOS
//
//  Created by rainsoft on 2019/1/25.
//  Copyright © 2019年 dazhuanjia. All rights reserved.
//

#import "BaselVMModel.h"
#import "Model.h"
@interface MVVModel : BaselVMModel

@property (strong,nonatomic)Model* model;
- (void)loadData;
@end
