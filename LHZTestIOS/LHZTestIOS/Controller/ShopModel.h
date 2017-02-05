//
//  ShopModel.h
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/4.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject

@property (nonatomic,assign)NSInteger nums;

@property (nonatomic,assign)CGFloat prices;

@property (nonatomic,strong)NSString* titleStr;

@property (nonatomic,strong)NSString* subTitleStr;

@end

@interface ShopModel ()

@property (nonatomic,assign)CGFloat subTotlePrice;

@end
