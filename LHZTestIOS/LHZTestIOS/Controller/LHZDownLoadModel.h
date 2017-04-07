//
//  LHZDownLoadModel.h
//  LHZTestIOS
//
//  Created by rainsoft on 17/4/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "LHZDownLoadOperation.h"
/*
 有种依赖关系，相互依赖，所以在编译的时候是通不过的
 1、在其中一个头文件中，把import改成@class
 2、这两个头文件中，全都用@class
 为什么要用@class,是为了能够防止重复编译，导致的编译不通过，@class的作用只是声明一个类，不能调用方法以及属性
*/

@class LHZDownLoadOperation;
typedef NS_ENUM(NSInteger, LHZDownloadState) {
    LHZDownloadStateNone = 0,       // 初始状态
    LHZDownloadStateRunning = 1,    // 下载中
    LHZDownloadStateSuspended = 2,  // 下载暂停
    LHZDownloadStateCompleted = 3,  // 下载完成
    LHZDownloadStateFailed  = 4,    // 下载失败
    LHZDownloadStateWaiting = 5,    // 等待下载
    //LHZDownloadStateCancel = 6      // 取消下载
};

@protocol  LHZDownLoadModel<NSObject>

@property (nonatomic, strong) LHZDownLoadOperation *operation;
@property (nonatomic, strong) NSString *downloadURL;

@property (nonatomic, assign) LHZDownloadState state;

@property (nonatomic, strong) NSProgress *progress;

@end
