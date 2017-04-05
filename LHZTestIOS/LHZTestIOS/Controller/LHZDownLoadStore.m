//
//  LHZDownLoadStore.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/4/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "LHZDownLoadStore.h"
//#import <YYCategories/YYCategories.h>
//#import <YYCache/YYCache.h>
@implementation LHZDownLoadStore

NSString *audioStoreDirectory(){
    return  @"";//directoryPath(@"audioStore");
}

NSString *audioFileNamed(id URL){
    NSString *fileName = nil;
    NSString *ext = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        NSString *tempStr = [URL absoluteString];
        fileName = [tempStr md5String];
        ext = [tempStr pathExtension];
    }else if ([URL isKindOfClass:[NSString class]]){
        fileName = [(NSString *)URL md5String];
        ext = [(NSString *)URL pathExtension];
    }
    if (ext) {
        return [fileName stringByAppendingPathExtension:ext];
    }
    return fileName;
    
}


+ (NSURL *)downPathWithKey:(id)URL{
    NSString *fileName = audioFileNamed(URL);
    
    if (!fileName) {
        return nil;
    }
    
    NSString *filePath = [audioStoreDirectory() stringByAppendingPathComponent:fileName];
    return [NSURL fileURLWithPath:filePath];
}

@end
