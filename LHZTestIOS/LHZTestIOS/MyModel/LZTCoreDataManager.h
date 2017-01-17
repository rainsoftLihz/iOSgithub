//
//  LZTCoreDataManager.h
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/28.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface LZTCoreDataManager : NSObject
/*数据库操作：NSManagedObjectContext 管理对象的上下文，类似于应用程序和数据存储
间的一块缓冲区，你可以增删改查管理对象*/
@property (readonly,strong, nonatomic) NSManagedObjectContext *managedObjectContext;
/*数据库模型：NSManagedObjectModel  管理对象数据模型，包含一个你想存储到数据存储中的管理对象的定义*/
@property (readonly,strong, nonatomic) NSManagedObjectModel *managedObjectModel;
/*数据库存储方式：NSPersistentStoreCoordinator 持久化存储协调者 ，包含数据存储的名字和位置，*/
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(instancetype)sharedManager;

- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

@end

/* 增删改查 */
@interface LZTCoreDataManager(Operation)

/* 查询 */
/* entityName 表名 predStr 查询条件*/
+ (void)selectFromEntityWithEntityName:(NSString *)entityName predStr:(NSString *)predStr resultsBlock:(void(^)(NSArray *results))resultsBlock;

/* 插入(增加)数据 */
+ (void)insertEntityWithEntityName:(NSString *)entityName manageObj:(NSManagedObject *)resultObj;

/* 删除表/数据 */
+ (void)deleteEntityWithEntityName:(NSString *)entityName andPredStr:(NSString*)predStr;

//更新
+ (void)updateWitnEntityName:(NSString *)entityName andPredStr:(NSString*)predStr andUpdateProperties:(NSString*)updataProperties andupdateWith:(id)newValue;

@end
