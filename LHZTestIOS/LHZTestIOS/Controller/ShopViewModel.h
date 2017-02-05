//
//  ShopViewModel.h
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/4.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopModel.h"
@interface ShopViewModel : NSObject

@property (nonatomic,strong)NSArray<ShopModel*> *dataArr;

@property (nonatomic,assign)CGFloat totlePrice;

-(void)requestData;

@end
