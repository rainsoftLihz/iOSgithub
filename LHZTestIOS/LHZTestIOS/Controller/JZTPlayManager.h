//
//  JZTPlayManager.h
//  LHZTestIOS
//
//  Created by rainsoft on 2017/5/15.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AVFoundation/AVFoundation.h>

@interface JZTPlayManager : NSObject

@property (nonatomic,strong) AVAudioPlayer *player;

+(instancetype)shareManager;

-(void)play;

-(void)stop;

-(void)playNext;

-(void)playPre;

-(void)pause;

@end
