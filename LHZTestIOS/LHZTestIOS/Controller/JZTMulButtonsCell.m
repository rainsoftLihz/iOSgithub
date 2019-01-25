//
//  JZTMulButtonsCell.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/4/23.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "JZTMulButtonsCell.h"

@implementation JZTMulButtonsCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{

    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLab];
}

/**
 ** topSpace 距上 centerSpace 图片和文字的间距
 **/
-(void)layoutUIwihtTopSpace:(CGFloat)topSpace andImgW:(CGSize) imgSize  andCenterSpeace:(CGFloat)centerSpace {
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topSpace);
        make.size.mas_equalTo(imgSize);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(centerSpace);
        make.width.mas_equalTo(self.contentView.mas_width);
    }];
    
}



-(UIImageView *)imgView
{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

-(UILabel *)titleLab
{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:12.0];
        _titleLab.textColor = [UIColor redColor];
    }
    return _titleLab;
}

+(NSString*)cellId
{
    return @"JZTMulButtonsCellId";
}

@end
