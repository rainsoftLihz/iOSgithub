//
//  WirteView.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/20.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "WirteView.h"

@interface WirteView () <UITextViewDelegate>

@property(nonatomic,strong) UIView *bottomView;

@property(nonatomic,strong) UITextView *writeText;

@property(nonatomic,strong) UIButton *submitBtn;

@end

@implementation WirteView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self =[super initWithFrame:frame];
    
    self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.45];
    
    [self configUI];
    
    return self;
}

-(void)configUI
{
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [self addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.and.bottom.mas_equalTo(self);
        make.height.mas_equalTo(165/3);
    }];
    
    self.writeText = [[UITextView alloc] init];

    self.writeText.delegate =self;
    self.writeText.layer.borderColor =[UIColor whiteColor].CGColor;
    self.writeText.layer.borderWidth =0.3;
    self.writeText.layer.cornerRadius =3;
    self.writeText.returnKeyType =UIReturnKeyDefault;
    self.writeText.textAlignment =NSTextAlignmentLeft;
    self.writeText.textColor = UIColorFromRGB(0x343434);
    self.writeText.font =[UIFont systemFontOfSize:14.5];
    [self.bottomView addSubview:self.writeText];
    
    self.submitBtn = [[UIButton alloc] init];
    [_submitBtn setTitle:@"发送" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:UIColorFromRGB(0xff852e) forState:UIControlStateNormal];
    _submitBtn.titleLabel.font =[UIFont systemFontOfSize:16];
    [self.bottomView addSubview:_submitBtn];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView.mas_centerY);
        make.right.mas_equalTo(self.bottomView.mas_right).offset(-10.0);
        make.size.mas_equalTo(CGSizeMake(64.0, 44.0));
    }];
    
    
    [self.writeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(self.bottomView).offset(10.0);
        make.right.mas_equalTo(self.submitBtn.mas_left).offset(-10.0);
        make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(-10);
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    // 获得键盘的frame
    CGRect frame = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 修改底部约束
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.and.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(- frame.size.height);
    }];

    // 执行动画
    [UIView animateWithDuration:0.1 animations:^{
        // 如果有需要,重新排版
        [self layoutIfNeeded];
    }];
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat height = [self heightForTextView:textView WithText:textView.text];
    
    NSLog(@"=========%f",height);
    
    /* 更新textview的高度 */
    
    [self.writeText mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(height);
        
    }];
    
    /* 同步更新视图的高度 */
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height+20);
    }];
    
    // 执行动画
    [UIView animateWithDuration:0.1 animations:^{
        // 如果有需要,重新排版
        [self layoutIfNeeded];
    }];;
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    /* 更新视图的底部约束 */
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}


- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
    CGSize constraint = CGSizeMake(textView.contentSize.width , CGFLOAT_MAX);
    CGRect size = [strText boundingRectWithSize:constraint
                                        options:( NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: textView.font}
                                        context:nil];
    float textHeight = size.size.height + 22.0;
    return textHeight;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end
