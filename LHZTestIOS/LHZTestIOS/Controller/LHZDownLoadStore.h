//
//  LHZDownLoadStore.h
//  LHZTestIOS
//
//  Created by rainsoft on 17/4/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHZDownLoadStore : NSObject

+ (double)allFileSize;

+(void)removeAllCaches;

@end

#pragma mark --- 下载文件处理
@interface LHZDownLoadStore(fileManger)

+ (NSURL *)downLoadPathWithURL:(id)URL;

+ (BOOL)fileExistWithURL:(id)URL;

+ (BOOL)removeStoreFileWithURL:(id)URL;

+ (BOOL)removeAllStoreFiles;

+ (double)fileSizeWithURL:(id)URL;

@end


#pragma mark --- 下载数据缓存
@interface LHZDownLoadStore(resumeData)

+ (void)saveResumeData:(NSData*)resumeData WithKey:(id)URL;

+ (NSData *)resumeDataWithKey:(id)URL;

+ (void)removeResumeDataWithKey:(id)URL;

+ (void)removeAllResumeData;

+ (double)resumeDataSizeWithKey:(id)URL;//单位M

+ (double)allResumeDataSize;//单位M

@end

#pragma mark --- 下载列表缓存
@interface LHZDownLoadStore(downLoadModels)

+ (void)saveModels:(NSArray*)models;//保存数组

+ (NSArray *)locationModels;//取数组

@end
