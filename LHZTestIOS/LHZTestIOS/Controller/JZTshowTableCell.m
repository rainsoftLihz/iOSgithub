//
//  JZTshowTableCell.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/8/15.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "JZTshowTableCell.h"

@implementation JZTshowTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    if (!_contLAb) {
        _contLAb = [[UILabel alloc] init];
        _contLAb.numberOfLines = 3;
    }
    
    self.openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_openBtn setTitle:@"展开" forState:UIControlStateNormal];
    [_openBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_openBtn setTitle:@"收起" forState:UIControlStateSelected];
    [_openBtn addTarget:self action:@selector(clickOpen:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.contLAb];
    [self.contentView addSubview:self.openBtn];
    
//    [self.contLAb mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(12);
//        make.top.mas_equalTo(12);
//        make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
//        //
//    }];
//    [self.openBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.contLAb.mas_bottom).offset(12);
//        make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
//        make.bottom.mas_equalTo(self.contentView).offset(-12);
//    }];
}


-(void)setContStr:(NSString *)contStr{
    self.contLAb.text = contStr;
    
    NSInteger numLines  = [self numberOfLinesForFont:self.contLAb.font constrainedToSize:CGSizeMake(Screen_Width-24, MAXFLOAT) lineBreakMode:self.contLAb.lineBreakMode and:contStr];
    
    if (numLines >= 3) {
//        self.contLAb.numberOfLines = 3;
        self.openBtn.hidden = NO;
//
        [self.contLAb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.top.mas_equalTo(12);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
//
        }];
        [self.openBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contLAb.mas_bottom).offset(12);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
            make.bottom.mas_equalTo(self.contentView).offset(-12);
        }];
       
    }else {
//        self.contLAb.numberOfLines = 0;
        self.openBtn.hidden = YES;
        [self.contLAb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.top.mas_equalTo(12);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
            make.bottom.mas_equalTo(self.contentView).offset(-12);

        }];
  
    }
}


- (NSInteger)numberOfLinesForFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode and:(NSString*)content {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName : font}];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                CFRangeMake(0, [attString length]), path, NULL);
    NSArray *lines = (NSArray *)CTFrameGetLines(frame);
    CFRelease(path);
    CFRelease(framesetter);
    CFRelease(frame);
    return lines.count;
}

- (void)clickOpen:(id)sender {
    if ([self.openBtn.currentTitle isEqualToString:@"展开"]) {
        //展开
        [self.openBtn setTitle:@"收起" forState:UIControlStateNormal];
        self.contLAb.numberOfLines = 0;
//
//        [self.openBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(self.contentView).offset(-12);
//            make.bottom.mas_equalTo(self.contentView).offset(-12);
//            make.top.mas_equalTo(self.contLAb).offset(12);
//        }];
        
    }else {
        self.contLAb.numberOfLines = 3;
        [self.openBtn setTitle:@"展开" forState:UIControlStateNormal];
        
//        [self.contLAb mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(12);
//            make.top.mas_equalTo(12);
//            make.right.mas_equalTo(self.contentView).offset(-12);
//            make.bottom.mas_equalTo(self.contentView).offset(-12);
//
//        }];
    }
    
    if ([self.dellegte respondsToSelector:@selector(clickAction)]) {
        [self.dellegte clickAction];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
