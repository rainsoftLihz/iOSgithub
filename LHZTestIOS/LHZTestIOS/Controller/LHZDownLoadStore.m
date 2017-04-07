//
//  LHZDownLoadStore.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/4/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "LHZDownLoadStore.h"
#import <YYCategories/YYCategories.h>
#import <YYCache/YYCache.h>
@implementation LHZDownLoadStore

#pragma mark --- 删除所有缓存
+(void)removeAllCaches
{
    [self removeAllResumeData];
    [self removeAllStoreFiles];
}

#pragma mark --- 计算所有缓存
+ (double)allFileSize{
    return [self allFileSize] + [self allResumeDataSize];
}


@end


@implementation LHZDownLoadStore(fileManger)

#pragma mark --- 创建存储目录
NSString *fileDirPath(NSString *dirName){
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *directryPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:dirName];
    if ([fileManager fileExistsAtPath:directryPath]) {
        BOOL isDirectory;
        if ([fileManager fileExistsAtPath:directryPath isDirectory:&isDirectory]) {
            if (!isDirectory) {
                if ([fileManager removeItemAtPath:directryPath error:nil]) {
                    if ([fileManager createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil]) {
                        return directryPath;
                    }
                }
            }else{
                return directryPath;
            }
        }
    }else{
        if ([fileManager createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil]) {
            return directryPath;
        }
    }
    return nil;
}

#pragma mark --- 存储的文件目录
NSString *fileStoreDirectory(){
    return fileDirPath(@"fileStore");
}


#pragma mark --- 存储的文件名
NSString *storeFileNamed(id URL){
    NSString *fileName = nil;
    NSString *ext = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        /* 以下载链接的MD5值为文件名 */
        NSString *tempStr = [URL absoluteString];
        fileName = [tempStr md5String];
        ext = [tempStr pathExtension];
    }else if ([URL isKindOfClass:[NSString class]]){
        fileName = [(NSString *)URL md5String];
        ext = [(NSString *)URL pathExtension];
    }
    if (ext) {
        /* 添加对应链接文件的后缀名 */
        return [fileName stringByAppendingPathExtension:ext];
    }
    return fileName;
    
}


#pragma mark --- downloadTask所需参数 即下载文件所存储的完整路径名
+ (NSURL *)downLoadPathWithURL:(id)URL{
    NSString *fileName = storeFileNamed(URL);
    
    if (!fileName) {
        return nil;
    }
    
    NSString *filePath = [fileStoreDirectory() stringByAppendingPathComponent:fileName];
    return [NSURL fileURLWithPath:filePath];
}

#pragma mark --- 判断下载链接是否存在
+ (BOOL)fileExistWithURL:(id)URL{
    NSString *fileName = storeFileNamed(URL);
    if (!fileName) {
        return NO;
    }
    NSString *filePath = [fileStoreDirectory() stringByAppendingPathComponent:fileName];
    return [[NSFileManager defaultManager]fileExistsAtPath:filePath];
}


#pragma mark --- 清除某一个链接对应的缓存(删除时候使用)
+ (BOOL)removeStoreFileWithURL:(id)URL{
    NSString *fileName = storeFileNamed(URL);
    
    if (!fileName) {
        return YES;
    }
    NSString *filePath = [fileStoreDirectory() stringByAppendingPathComponent:fileName];
    if (!filePath) {
        return YES;
    }
    
    return [[NSFileManager defaultManager]removeItemAtPath:filePath error:nil];
}

#pragma mark --- 某个下载文件对应的大小 M
+ (double)fileSizeWithURL:(id)URL{
    NSString *fileName = storeFileNamed(URL);
    
    if (!fileName) {
        return 0;
    }
    NSString *filePath = [fileStoreDirectory() stringByAppendingPathComponent:fileName];
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    unsigned long long fileSize = [attrs fileSize];
    return fileSize / (1024.0 * 1024.0);
}

#pragma mark --- 文件大小转换
+ (NSString *)fileStrSizeWithURL:(id)URL
{
    NSString *fileName = storeFileNamed(URL);
    
    if (!fileName) {
        return nil;
    }
    NSString *filePath = [fileStoreDirectory() stringByAppendingPathComponent:fileName];
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    unsigned long long fileSize = [attrs fileSize];
    
    return [self CountBytesBy:fileSize];
}

+ (NSString *)CountBytesBy:(unsigned long long)bytes{
    NSString * bytesStr = nil;
    if (!(bytes / 1024)) {
        bytesStr = [NSString stringWithFormat:@"%lldB",bytes];//B
    }else if (!(bytes / 1024 / 1024)){
        bytesStr = [NSString stringWithFormat:@"%.2fkb",(float)bytes / 1024 ];
    }else{
        bytesStr = [NSString stringWithFormat:@"%.2fM",(float) bytes / 1024 / 1024];
    }
    return  bytesStr;
}



#pragma mark --- 清除all缓存(清除缓存时候使用)
+ (BOOL)removeAllStoreFiles{
    NSString *directory = fileStoreDirectory();
    if (!directory) {
        return YES;
    }
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:directory]) {
        return YES;
    }
    
    return [[NSFileManager defaultManager]removeItemAtPath:directory error:nil];
}

#pragma mark --- 文件夹目录大小
+ (unsigned long long)folderSizeAtPath:(NSString*)folderPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:folderPath];
    if (isExist){
        NSEnumerator *childFileEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
        unsigned long long folderSize = 0;
        for (NSString *fileName in childFileEnumerator) {
            NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
            NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            folderSize += [attrs fileSize];
        }
        return folderSize;
    } else {
        return 0;
    }
}

@end

@implementation LHZDownLoadStore(resumeData)
NSString *urlStr(id URL){
    NSString *fileName = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        fileName = [URL absoluteString];
    }else if ([URL isKindOfClass:[NSString class]]){
        fileName = (NSString *)URL;
    }
    return fileName;
}

#pragma mark --- 初始化cache
+ (YYCache *)resumeDataCache{
    static NSString *name = @"resumeDataStore";
    return [YYCache cacheWithName:name];
}

#pragma mark --- 保存resumeData
+ (void)saveResumeData:(NSData*)resumeData WithKey:(id)URL{
    NSString *key = urlStr(URL);
    [[self resumeDataCache]setObject:resumeData forKey:key];
}


#pragma mark --- 缓存的data数据 downloadTask所需参数
+ (NSData *)resumeDataWithKey:(id)URL{
    NSString *key = urlStr(URL);
    return (NSData*)[[self resumeDataCache]objectForKey:key];
}

#pragma mark ---- 所有缓存大小
+ (double)allResumeDataSize{//单位M
    return [[[self resumeDataCache] diskCache]totalCost] / (1024.0 * 1024.0);
}

#pragma mark --- 计算缓存大小 单位M
+ (double)resumeDataSizeWithKey:(id)URL{
    NSData *data = [self resumeDataWithKey:URL];
    return data.length / (1024.0 * 1024.0);
}

#pragma mark --- 删除对应缓存
+ (void)removeResumeDataWithKey:(id)URL{
    NSString *key = urlStr(URL);
    [[self resumeDataCache]removeObjectForKey:key];
}

#pragma mark --- 删除所有缓存
+ (void)removeAllResumeData{
    [[self resumeDataCache]removeAllObjects];
}

@end


#pragma mark --- 下载列表models缓存
@implementation LHZDownLoadStore(downLoadModels)

#define kDownloadModelsKey @"kDownloadModelsKey"
+ (YYCache *)downloadModelsCache{
    static NSString *name = @"DownloadModels";
    return [YYCache cacheWithName:name];
}

+ (void)saveModels:(NSArray*)models{
    [[self downloadModelsCache]setObject:models forKey:kDownloadModelsKey];
}

+ (NSArray *)locationModels{
    return (NSArray *)[[self downloadModelsCache] objectForKey:kDownloadModelsKey];
}

+ (void)removeLocationModels{
    [[self downloadModelsCache]removeAllObjects];
}

@end
