//
//  CollectionFooterView.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/5/16.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "CollectionFooterView.h"

#import "JZTPlayManager.h"

@interface CollectionFooterView()

@property (nonatomic,strong)UIButton* nextBtn;

@property (nonatomic,strong)UIButton* playBtn;

@property (nonatomic,strong)UIButton* preBtn;

@end

@implementation CollectionFooterView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        
        [self configUI];
        
    }
    return self;
}

-(void)configUI
{
    self.nextBtn = [self createBtnWithIMG:@"player_btn_next"];
    
    self.playBtn = [self createBtnWithIMG:@"player_btn_play"];
    
    self.preBtn = [self createBtnWithIMG:@"player_btn_pre"];
    
    [self addSubview:self.nextBtn];
    
    [self addSubview:self.preBtn];
    
    [self addSubview:self.playBtn];
    
    if (![JZTPlayManager shareManager].player.isPlaying) {
        [self.playBtn setImage:[UIImage imageNamed:@"player_btn_pause"] forState:UIControlStateNormal];
    }
    else {
        [self.playBtn setImage:[UIImage imageNamed:@"player_btn_play"] forState:UIControlStateNormal];
    }
    
    
    CGFloat leftSpace = 20.0;
    CGFloat btnW = 128/3.0;
    
    [self.preBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(leftSpace);
        make.size.mas_equalTo(CGSizeMake(btnW, btnW));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(btnW, btnW));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-leftSpace);
        make.size.mas_equalTo(CGSizeMake(btnW, btnW));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.preBtn addTarget:self action:@selector(preClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)preClick:(UIButton*)btn
{
    [[JZTPlayManager shareManager] playPre];
}

-(void)nextClick:(UIButton*)btn
{
     [[JZTPlayManager shareManager] playNext];
}

-(void)playClick:(UIButton*)btn
{
    if ([JZTPlayManager shareManager].player.isPlaying) {
       [self.playBtn setImage:[UIImage imageNamed:@"player_btn_pause"] forState:UIControlStateNormal];
       [[JZTPlayManager shareManager] pause];
    }
    else {
       [self.playBtn setImage:[UIImage imageNamed:@"player_btn_play"] forState:UIControlStateNormal];
       [[JZTPlayManager shareManager] play];
    }
}




-(UIButton*)createBtnWithIMG:(NSString*)imgName
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    
    return btn;
}

@end
