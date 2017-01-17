//
//  UserInfo+CoreDataProperties.m
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/29.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import "UserInfo+CoreDataProperties.h"

@implementation UserInfo (CoreDataProperties)

+ (NSFetchRequest<UserInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserInfo"];
}

@dynamic iconUrl;
@dynamic name;
@dynamic phoneNo;
@dynamic sex;
@dynamic authInfo;

@end
