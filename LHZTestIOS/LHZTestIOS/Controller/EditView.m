//
//  EditView.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/5/7.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "EditView.h"
@interface EditView()<UITextFieldDelegate>

@property (nonatomic,strong)UILabel* titleLab;

@end

@implementation EditView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    UITextField* valueTextField = [[UITextField alloc] init];
    valueTextField.borderStyle = UITextBorderStyleRoundedRect;
    valueTextField.delegate = self;
    valueTextField.keyboardType = UIKeyboardTypeNumberPad;
    valueTextField.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:valueTextField];
    
    [valueTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset(2.0);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(50.0);
    }];
}

-(void)configTitleWith:(NSString*)str
{
    self.titleLab.text = str;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.editBack) {
        self.editBack(textField.text);
    }
}

@end
