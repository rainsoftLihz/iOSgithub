//
//  ShoppingCell.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/4.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "ShoppingCell.h"

@interface ShoppingCell()

@property (nonatomic,strong)UIImageView* iconImg;

@property (nonatomic,strong)UILabel* titleLab;

@property (nonatomic,strong)UILabel* subTitleLab;

@property (nonatomic,strong)UILabel* priceLab;

@property (nonatomic,strong)UILabel* numLab;

@property (nonatomic,strong)UIButton* numAddBtn;

@property (nonatomic,strong)UIButton* numReduceBtn;

@end

@implementation ShoppingCell

+(__kindof UITableViewCell *)cellWithTable:(UITableView*)tableView
{
    NSString *ID = [NSString stringWithFormat:@"ShoppingCell"];
    ShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[self class] alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    self.iconImg = [[UIImageView alloc] init];
    self.iconImg.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.iconImg];
    
    self.titleLab = [self createLabWithColor:[UIColor blackColor] andFont:14.0];
    self.titleLab.numberOfLines = 2;
    
    self.subTitleLab = [self createLabWithColor:[UIColor grayColor] andFont:12.0];
    
    self.priceLab = [self createLabWithColor:[UIColor redColor] andFont:12.0];
    
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.subTitleLab];
    [self.contentView addSubview:self.priceLab];
    
    
    self.numAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.numAddBtn setTitle:@"+" forState:UIControlStateNormal];
    [self.numAddBtn setBackgroundColor:[UIColor redColor]];
    [self.numAddBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    
    self.numLab = [self createLabWithColor:[UIColor yellowColor] andFont:12.0];
    self.numLab.textAlignment = NSTextAlignmentCenter;
    
    self.numLab.textColor = [UIColor redColor];
    
    self.numReduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.numReduceBtn setTitle:@"-" forState:UIControlStateNormal];
    [self.numReduceBtn addTarget:self action:@selector(reduce:) forControlEvents:UIControlEventTouchUpInside];
    [self.numReduceBtn setBackgroundColor:[UIColor redColor]];
    
    self.numReduceBtn.layer.borderWidth = 0.5;
    self.numLab.layer.borderWidth = 0.5;
    self.numAddBtn.layer.borderWidth = 0.5;
    
    self.numReduceBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.numAddBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.numLab.layer.borderColor = [UIColor redColor].CGColor;
    
    [self.contentView addSubview:self.numAddBtn];
    [self.contentView addSubview:self.numLab];
    [self.contentView addSubview:self.numReduceBtn];
    
    [self layoutUI];
    
    
    
}

-(void)layoutUI
{
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).offset(10.0);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10.0);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImg.mas_right).offset(10.0);
        make.top.mas_equalTo(self.iconImg.mas_top);
        make.right.mas_equalTo(self.contentView).offset(-15.0);
    }];
    
    [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(5.0);
    }];
    
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.subTitleLab.mas_left);
        //make.top.mas_equalTo(self.subTitleLab.mas_bottom).offset(5.0);
        make.bottom.mas_equalTo(self.iconImg.mas_bottom);
    }];
    
    [self.numAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15.0);
        make.bottom.mas_equalTo(self.iconImg.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(50, 50.0*3.0/4.0));
    }];
    
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.numAddBtn.mas_left);
        make.bottom.mas_equalTo(self.numAddBtn.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(50, 50.0*3.0/4.0));
    }];
    
    [self.numReduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.numLab.mas_left);
        make.bottom.mas_equalTo(self.numAddBtn.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(50, 50.0*3.0/4.0));
    }];

    
}


-(void)setModel:(ShopModel *)model
{
    _model = model;
    
    self.titleLab.text = model.titleStr;
    
    self.subTitleLab.text = model.subTitleStr;
    
    self.priceLab.text = [NSString stringWithFormat:@"%.2f",self.model.prices];
    
    self.numLab.text = [NSString stringWithFormat:@"%ld",self.model.nums];
}

-(void)add:(UIButton*)btn
{
    self.model.nums++;
    
    self.numLab.text = [NSString stringWithFormat:@"%ld",self.model.nums];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"checkPrice" object:nil];
}

-(void)reduce:(UIButton*)btn
{
    if (self.model.nums == 0) {
        return;
    }
    self.model.nums--;
    
    
    self.numLab.text = [NSString stringWithFormat:@"%ld",self.model.nums];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"checkPrice" object:nil];
}

-(UILabel*)createLabWithColor:(UIColor*)textColor andFont:(CGFloat)textFontSize
{
    UILabel* lab = [[UILabel alloc] init];
    lab.font = [UIFont systemFontOfSize:textFontSize];
    lab.textColor = textColor;
    lab.textAlignment = NSTextAlignmentLeft;
    return lab;
}

@end
