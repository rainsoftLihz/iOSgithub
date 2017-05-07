//
//  LHZDownExampleModel.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/4/7.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "LHZDownExampleModel.h"

@implementation LHZDownExampleModel

#pragma mark --- setter
-(void)setState:(LHZDownloadState)state
{
    if (_state != state) {
        _state = state;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.stateChangeHandle) {
                self.stateChangeHandle(state);
            }
        });
    }
}

-(void)setProgress:(NSProgress *)progress
{
    //if (_progress != progress) {
        _progress = progress;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.progressHandle) {
                self.progressHandle(progress);
            }
        });
    //}
}

- (LHZDownLoadOperation *)operation {
    if (!_operation) {
        _operation = [[LHZDownLoadOperation alloc]initWithDownloadModel:self];
    }
    return _operation;
}

#pragma mark - yymodel
- (NSString *)description{
    return [self yy_modelDescription];
}
#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

@end
