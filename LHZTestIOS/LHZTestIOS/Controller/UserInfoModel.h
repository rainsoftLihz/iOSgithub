//
//  UserInfoModel.h
//  LHZTestIOS
//
//  Created by rainsoft on 2017/5/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,Sex) {
    SexMale,
    SexFemale};
@class UserPerson;
@interface UserInfoModel : NSObject

@property (strong, nonatomic) NSNumber *money;

@property (strong, nonatomic) UserPerson *user;

@property (strong, nonatomic) NSArray<UserPerson*> *userArr;

@end


@interface UserPerson : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *headerUrl;
@property (assign, nonatomic) int age;
@property (assign, nonatomic) double height;
@property (assign, nonatomic) Sex sex;

@end
