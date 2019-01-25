//
//  RATreeModel.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/7/30.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "RATreeModel.h"

@implementation RATreeModel
- (id)initWithName:(NSString *)name children:(NSArray *)children
{
    self = [super init];
    if (self) {
        self.children = children;
        self.name = name;
    }
    return self;
}

+ (id)dataObjectWithName:(NSString *)name children:(NSArray *)children
{
    return [[self alloc] initWithName:name children:children];
}

@end
