//
//  JZTGoodsInfoCell.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/4/25.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "JZTGoodsInfoCell.h"
#import "UIView+JZTCategory.h"
@interface JZTGoodsInfoCell()

//药品图片
@property(nonatomic,strong)UIImageView* imgView;

//零售价格
@property(nonatomic,strong)UILabel* retailPriceLab;

//药品名称
@property(nonatomic,strong)UILabel* nameLab;

//药品规格 药品厂家
@property(nonatomic,strong)UILabel* specAndfactoryLab;

//药品价格
@property(nonatomic,strong)UILabel* priceLab;

//库存 上月销量
@property(nonatomic,strong)UILabel* storAndLastsalesLab;

//购物车
@property(nonatomic,strong)UIButton* cartBtn;

//自定义的分割线
@property(nonatomic,strong)UIView* separatorView;
@end

@implementation JZTGoodsInfoCell

+ (__kindof JZTGoodsInfoCell *) cellWithTableView:(UITableView*)tableView
{
    static NSString *ID = @"JZTGoodsInfoCell";
    JZTGoodsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[JZTGoodsInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

//使用懒加载创建分割线view
-(UIView *)separatorView
{
    if (_separatorView == nil) {
        UIView *separatorView = [[UIView alloc]init];
        self.separatorView = separatorView;
        separatorView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:separatorView];
    }
    return _separatorView;
}


//重写layoutSubViews方法，设置位置及尺寸
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 20;
    self.separatorView.frame = CGRectMake(x, self.bounds.size.height-1,     self.bounds.size.width-x, 1);
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
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.backgroundColor = [UIColor redColor];
    
    self.retailPriceLab = [self createLabWith:[UIColor redColor] andFontSize:6.0];
    self.retailPriceLab.textAlignment = NSTextAlignmentCenter;
    
    self.nameLab = [self createLabWith:[UIColor blackColor] andFontSize:12.0];
    
    self.specAndfactoryLab = [self createLabWith:[UIColor lightGrayColor] andFontSize:10.0];
    
    self.priceLab = [self createLabWith:[UIColor grayColor] andFontSize:10.0];
    
    self.storAndLastsalesLab = [self createLabWith:[UIColor grayColor] andFontSize:10.0];
    
    self.cartBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cartBtn.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubViews:@[self.imgView,self.retailPriceLab,self.nameLab,self.specAndfactoryLab,self.priceLab,self.storAndLastsalesLab,self.cartBtn]];
    
    [self setupMas];
}

-(void)setupMas{
    
    CGFloat topSpace = 10.0;
    CGFloat leftSpace = 10.0;
    CGFloat botomSpace = 10.0;
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(leftSpace);
        make.top.mas_equalTo(self.contentView.mas_top).offset(topSpace);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.retailPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom);
        make.left.and.right.mas_equalTo(self.imgView);
        make.bottom.mas_equalTo(botomSpace);
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView.mas_right).offset(5.0);
        make.top.mas_equalTo(self.imgView.mas_top);
    }];
    
    [self.specAndfactoryLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLab);
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(3.0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10.0);
    }];
    
    [self.storAndLastsalesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-botomSpace);
        make.left.mas_equalTo(self.nameLab.mas_left);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLab.mas_left);
        make.bottom.mas_equalTo(self.storAndLastsalesLab.mas_top).offset(-3.0);
    }];
    
    [self.cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15.0);
        make.top.mas_equalTo(self.specAndfactoryLab.mas_bottom).offset(5.0);
    }];
}


#pragma mark ---- 赋值
-(void)setModel:(JZTGoodsInfoModel *)model
{
    _model = model;
    self.nameLab.text = model.prodName;
    self.priceLab.text = model.memberPrice;
    self.specAndfactoryLab.text = [NSString stringWithFormat:@"%@  %@",model.prodSpecification,model.manufacturer];
    self.retailPriceLab.text = [NSString stringWithFormat:@"零售价:¥%@", model.retailPrice];
    self.storAndLastsalesLab.text = [NSString stringWithFormat:@"库存:%@  上月销量：%@",model.storageNumber,model.salesLastMonth];
}

-(UILabel*)createLabWith:(UIColor*)textColor andFontSize:(CGFloat)size{
    UILabel* lab = [[UILabel alloc] init];
    lab.textColor = textColor;
    lab.font = [UIFont systemFontOfSize:size];
    lab.textAlignment = NSTextAlignmentLeft;
    return lab;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
