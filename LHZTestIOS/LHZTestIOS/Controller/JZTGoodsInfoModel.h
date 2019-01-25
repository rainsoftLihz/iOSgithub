//
//  JZTGoodsInfoModel.h
//  LHZTestIOS
//
//  Created by rainsoft on 2018/4/25.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZTGoodsInfoModel : NSObject

//件包装数量 大包装
@property (nonatomic,strong)NSString* bigPackageQuantity;

//是否展会
@property (nonatomic,assign)BOOL fairsInfo;

//是否允许小数
@property (nonatomic,strong)NSNumber* isDecimal;

//是否是负责的厂家品种
@property (nonatomic,strong)NSNumber* isSalesProd;

//是否拆零
@property (nonatomic,strong)NSNumber*  isUnpick;

//生产厂家
@property (nonatomic,strong)NSString* manufacturer;

//会员价
@property (nonatomic,strong)NSString* memberPrice;

//中包装数量
@property (nonatomic,strong)NSString* midPackageQuantity;

//包装单位
@property (nonatomic,strong)NSString* packageUnit;

//零售价
@property (nonatomic,strong)NSString* retailPrice;

//药品ID
@property (nonatomic,strong)NSString* prodId;

//药品名称
@property (nonatomic,strong)NSString* prodName;

//通用名称
@property (nonatomic,strong)NSString* prodLocalName;

//药品编号
@property (nonatomic,strong)NSString* prodNo;

//药品规格
@property (nonatomic,strong)NSString* prodSpecification;

//是否医保
@property (nonatomic,strong)NSString* isYiBao;

//远效期
@property (nonatomic,strong)NSString* farValidityDate;

//近效期至
@property (nonatomic,strong)NSString* nearValidityDate;

//政策奖励兑付
@property (nonatomic,strong)NSString* rewardCash;

//上月销量
@property (nonatomic,strong)NSString* salesLastMonth;

//前台显示库存样式库存
@property (nonatomic,strong)NSString* showTactics;

//库存
@property (nonatomic,strong)NSString* storageNumber;

//处方药类型
@property (nonatomic,strong)NSString* chuffl;

@end
