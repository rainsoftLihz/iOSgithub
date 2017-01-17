//
//  UserInfo+CoreDataProperties.h
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/29.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import "UserInfo+CoreDataClass.h"
#import "AuthInfo+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo (CoreDataProperties)

+ (NSFetchRequest<UserInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *iconUrl;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *phoneNo;
@property (nonatomic) int16_t sex;
@property (nullable, nonatomic, retain) AuthInfo *authInfo;

@end

NS_ASSUME_NONNULL_END
