//
//  LZTCoreDataManager.m
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/28.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import "LZTCoreDataManager.h"

#import "UserInfo+CoreDataClass.h"

@implementation LZTCoreDataManager

static LZTCoreDataManager* _sharedManager;
+(instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;

-(NSManagedObjectContext *)managedObjectContext
{
    if (!_managedObjectContext) {
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (!coordinator) {
            return nil;
        }
        
        //NSMainQueueConcurrencyType主线程操作
        /*NSMainQueueConcurrencyType 的context用于响应 UI 事件，其他涉及大量数据操作可能会阻塞 UI 的，就使用NSPrivateQueueConcurrencyType的 context */
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
   
        [_managedObjectContext setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
    }
  
    return _managedObjectContext;
}

/*NSManagedObjectModel 是描述应用程序的数据模型，这个模型包含实体（Entity），特性（Property），读取请求（Fetch Request）等。（下文都使用英文术语。）*/
-(NSManagedObjectModel *)managedObjectModel
{
    if (!_managedObjectModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"UserModel" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}


-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (!_persistentStoreCoordinator) {
      
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        
        // Create the coordinator and store
        
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"UserModel.sqlite"];
        NSError *error = nil;
        NSString *failureReason = @"There was an error creating or loading the application's saved data.";
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
            // Report any error we got.
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
            dict[NSLocalizedFailureReasonErrorKey] = failureReason;
            dict[NSUnderlyingErrorKey] = error;
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
    }

    return _persistentStoreCoordinator;
}

-(void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end

@implementation LZTCoreDataManager(Operation)

/* 查询 */
/* entityName 表名 predStr 查询条件*/
+ (void)selectFromEntityWithEntityName:(NSString *)entityName predStr:(NSString *)predStr resultsBlock:(void(^)(NSArray *results))resultsBlock{
    
    /* NSEntityDescription:相当于数据库中的一个表*/
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[[LZTCoreDataManager sharedManager] managedObjectContext]];
    
    /*NSFetchRequest:获取数据的请求，通过被管理数据的上下文来执行查询 以 NSArray 形式返回查询结果*/
    NSFetchRequest *frq = [[NSFetchRequest alloc] init];
    [frq setEntity:entity];
    if (predStr&&predStr.length>0) {
        NSPredicate *preds = [NSPredicate predicateWithFormat:predStr];
        [frq setPredicate:preds];
    }
    
    NSArray *selectDataArr = [[LZTCoreDataManager sharedManager].managedObjectContext executeFetchRequest:frq error:nil];
    if (resultsBlock) {
        resultsBlock(selectDataArr);
    }
}

/* 插入(增加)数据 */
+ (void)insertEntityWithEntityName:(NSString *)entityName manageObj:(NSManagedObject *)resultObj {
    
    [[LZTCoreDataManager sharedManager].managedObjectContext refreshObject:resultObj mergeChanges:YES];
    [[LZTCoreDataManager sharedManager] saveContext];
}

//更新
+ (void)updateWitnEntityName:(NSString *)entityName andPredStr:(NSString*)predStr andUpdateProperties:(NSString*)updataProperties andupdateWith:(id)newValue
{
    NSManagedObjectContext *context = [LZTCoreDataManager sharedManager].managedObjectContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    
    //首先你需要建立一个request
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    if (predStr&&predStr.length>0) {
        NSPredicate *preds = [NSPredicate predicateWithFormat:predStr];
        [request setPredicate:preds];
    }
    
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];
    //这里获取到的是一个数组，你需要取出你要更新的那个obj
    for (UserInfo *info in result) {
 
        NSLog(@"containsObject=====%d",[[info allPropertyNames] containsObject:updataProperties]);
        NSLog(@"%@",[info allPropertyNames]);
        /* 判断是否存在这个字段 */
        if ([[info allPropertyNames] containsObject:updataProperties]) {
             [info setValue:newValue forKey:updataProperties];
        }
        else NSLog(@"没有这个属性，无法修改");
    }
    
    //保存
    if ([context save:&error]) {
        //更新成功
        NSLog(@"更新成功");
    }
}

/* 删除数据 */
+ (void)deleteEntityWithEntityName:(NSString *)entityName andPredStr:(NSString*)predStr{
    if (!entityName) {
        return;
    }
    
    [LZTCoreDataManager selectFromEntityWithEntityName:entityName predStr:predStr resultsBlock:^(NSArray *results) {
        for (id item in results) {
            [[LZTCoreDataManager sharedManager].managedObjectContext deleteObject:item];
            [[LZTCoreDataManager sharedManager] saveContext];
        }
    }];
}

@end
