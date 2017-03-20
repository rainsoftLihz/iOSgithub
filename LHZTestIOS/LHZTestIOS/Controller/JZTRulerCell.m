//
//  JZTRulerCell.m
//  JZTArchives
//
//  Created by 梁泽 on 2016/11/4.
//  Copyright © 2016年 梁泽. All rights reserved.
//

#import "JZTRulerCell.h"
#import "JZTRulerView.h"
#import "JZTRulerScrollView.h"

#define COLOR_HEI1f  [UIColor colorWithHexString:@"1f1f1f"]
#define COLOR_ZHUSE [UIColor colorWithRed:0.157 green:0.769 blue:0.686 alpha:1.000]
#define COLOR_HEIbe [UIColor colorWithWhite:0.745 alpha:1.000]/*bebebe*/

@interface JZTRulerCell()<JZTRulerViewDelegate>
@property (nonatomic, strong,readwrite) JZTRulerView *rulerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UILabel *unitLabel;
@property (nonatomic, strong) JZTRulerCellModel *model;
@end

@implementation JZTRulerCell
+ (__kindof UITableViewCell *)cellWithTableView:(UITableView*)tableView model:(JZTRulerCellModel*)model{
    NSString *ID = [model description];
    JZTRulerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[self class] alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.model = model;
    }
    return cell;
}

+ (__kindof UITableViewCell *)cellWithTableView:(UITableView*)tableView{
    static NSString *ID = @"JZTRulerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[self class] alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupUI];
    return self;
}

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:48*kProportion];
        _titleLabel.textColor = COLOR_HEI1f;
        [self.contentView addSubview:_titleLabel];
    }
    
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc]init];
        _valueLabel.font = [UIFont systemFontOfSize:78*kProportion];
        _valueLabel.textColor = COLOR_HEI1f;
        _valueLabel.text = @"100";
        [self.contentView addSubview:_valueLabel];
    }
    
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc]init];
        _unitLabel.font = [UIFont systemFontOfSize:12.5];
        _unitLabel.textColor = COLOR_HEIbe;
        [self.contentView addSubview:_unitLabel];
    }
    
    if (!_rulerView) {
        _rulerView = [[JZTRulerView alloc]initWithFrame:CGRectMake(15,0, Screen_Width - 30, kRulerViewHeight)];
        _rulerView.delegate = self;
        _rulerView.indicatorColor = [UIColor blackColor];
        [self.contentView addSubview:_rulerView];
    }
    
    [self jzt_layoutSubviews];
}

- (void)jzt_layoutSubviews{
    [self.rulerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(kRulerViewHeight);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rulerView);
        make.bottom.equalTo(self.rulerView.mas_top);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rulerView);
        make.bottom.equalTo(self.rulerView.mas_top);
        make.top.equalTo(self.contentView);
    }];
    
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).offset(32);
        make.bottom.equalTo(self.rulerView.mas_top).offset(-4);
    }];
}

- (void)setModel:(JZTRulerCellModel *)model{
    _model = model;
    
    [self.rulerView configRulerScorllViewWithMin:model.rulerMin count:model.rulerCount average:model.rulerAverage currentValue:model.rulerValue markCount:model.markCount];
    self.rulerView.onlyStopMark = model.onlyStopMark;
    self.titleLabel.text = [model name];
    self.valueLabel.text = [model defaultValueStr];
    self.unitLabel.text = [model unit];
    
}
#pragma mark - JZTRulerViewDelegate
- (void)JZTRulerView:(JZTRulerView *)rulerView willBeginScroll:(JZTRulerScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(JZTRulerCellRulerDidScorll:)]) {
        [self.delegate JZTRulerCellRulerDidScorll:self];
    }
}

- (void)JZTRulerView:(JZTRulerView *)rulerView didRefreshTick:(JZTRulerScrollView *)scrollView{
    CGFloat result = scrollView.rulerValue;
    if (fabs(self.model.defaultValue -result) >= 0.00001) {
        self.rulerView.indicatorColor = COLOR_ZHUSE;
        self.titleLabel.textColor = COLOR_ZHUSE;
        self.valueLabel.textColor = COLOR_ZHUSE;
    }
    self.model.rulerValue = result;
    self.valueLabel.text = [self.model currentValueStr];
}
#pragma mark - public
- (void)setupUIWithColor:(UIColor *)color{
    self.rulerView.indicatorColor = color;
    self.titleLabel.textColor = color;
    self.valueLabel.textColor = color;
}

- (void)scrollToDefault{
    [self.rulerView scrollWithRulerValue:self.model.defaultValue];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.rulerView.indicatorColor = COLOR_HEI1f;
        self.titleLabel.textColor = COLOR_HEI1f;
        self.valueLabel.textColor = COLOR_HEI1f;
    });
    
}
- (void)scrollToRulerValue:(CGFloat)rulerValue{
    [self.rulerView scrollWithRulerValue:rulerValue];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.rulerView.indicatorColor = COLOR_ZHUSE;
        self.titleLabel.textColor = COLOR_ZHUSE;
        self.valueLabel.textColor = COLOR_ZHUSE;
    });
}
@end
