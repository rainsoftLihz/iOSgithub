//
//  UserInfoModel.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/5/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel


/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"userArr" : @"UserPerson",
             };
}

@end

@implementation UserPerson

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"headerUrl" : @"icon"
             };
}


@end
