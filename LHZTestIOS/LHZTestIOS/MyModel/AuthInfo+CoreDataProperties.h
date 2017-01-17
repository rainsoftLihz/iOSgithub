//
//  AuthInfo+CoreDataProperties.h
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/29.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import "AuthInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AuthInfo (CoreDataProperties)

+ (NSFetchRequest<AuthInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, retain) NSSet<UserInfo *> *relationship;

@end

@interface AuthInfo (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(UserInfo *)value;
- (void)removeRelationshipObject:(UserInfo *)value;
- (void)addRelationship:(NSSet<UserInfo *> *)values;
- (void)removeRelationship:(NSSet<UserInfo *> *)values;

@end

NS_ASSUME_NONNULL_END
