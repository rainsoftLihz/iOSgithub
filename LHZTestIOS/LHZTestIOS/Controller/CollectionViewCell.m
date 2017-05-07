//
//  CollectionViewCell.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/5/7.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.iconImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImg];
    
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(35.0*kHProportion);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(28.0);
        make.height.mas_equalTo(28.0);
    }];
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.textColor = UIColorFromRGB(0x4e4e4e);
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.font = [UIFont systemFontOfSize:13.0];
    [self.contentView addSubview:self.titleLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImg.mas_bottom).offset(3.0);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
}

@end
