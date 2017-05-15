//
//  JZTPlayManager.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/5/15.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "JZTPlayManager.h"

@interface JZTPlayManager ()<AVAudioPlayerDelegate>

@property (nonatomic,strong)NSArray* musicPathArr;

@property (nonatomic,assign)NSInteger index;

@end

@implementation JZTPlayManager

+(instancetype)shareManager
{
    static JZTPlayManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JZTPlayManager alloc] init];
    });
    return manager;
}


-(instancetype)init
{
    if (self = [super init]) {
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:self.musicPathArr[0]] error:nil];
        
        self.player.numberOfLoops = 0;
        
        self.player.delegate = self;

        self.index = 0;
    }
    return self;
}

-(NSArray *)musicPathArr
{
    NSArray* nameArr = @[@"薛之谦-认真的雪",@"蔡淳佳-陪我看日出",@"张学友-每天爱你多一些"];
    NSMutableArray* arr = [NSMutableArray array];
    for (NSString* str in nameArr) {
        NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:@"mp3"];
        [arr addObject:[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    }

    return arr;
}


-(void)play
{
    [self.player prepareToPlay];//分配播放所需的资源，并将其加入内部播放队列
    [self.player play];//播放
}

-(void)stop
{
    [self.player stop];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (self.index < self.musicPathArr.count-1) {
        self.index++;
    }
    else self.index = 0;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:self.musicPathArr[self.index]] error:nil];
    [self play];
}

@end
