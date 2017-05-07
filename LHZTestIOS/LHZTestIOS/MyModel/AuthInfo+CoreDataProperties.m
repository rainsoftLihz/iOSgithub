//
//  AuthInfo+CoreDataProperties.m
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/29.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import "AuthInfo+CoreDataProperties.h"

@implementation AuthInfo (CoreDataProperties)

+ (NSFetchRequest<AuthInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AuthInfo"];
}

@dynamic email;
@dynamic address;
@dynamic relationship;

-(NSString *)address
{
    return @"11111111";
}

@end
