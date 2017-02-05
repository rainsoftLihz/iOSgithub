//
//  ShopViewModel.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/4.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "ShopViewModel.h"

@implementation ShopViewModel

-(CGFloat)totlePrice
{
    CGFloat totlePrices = 0.0;
    for (ShopModel* model in self.dataArr) {
        totlePrices += [model subTotlePrice];
    }
    
    return totlePrices;
}

-(void)requestData
{
    ShopModel* model1 = [[ShopModel alloc] init];
    model1.prices = 199.0;
    model1.nums = 1;
    model1.titleStr = @"就是劳动节放假似的牌吹风机，势均力敌加夫里什的加夫里什的";
    model1.subTitleStr = @"进口大品牌";
    
    ShopModel* model2 = [[ShopModel alloc] init];
    model2.prices = 11.0;
    model2.nums = 5;
    model2.titleStr = @"就是劳动节放假似的牌电风扇，势均力敌加夫里什的加夫里什的";
    model2.subTitleStr = @"全新系列";
    
    self.dataArr = @[model1,model2];
    
}

@end
