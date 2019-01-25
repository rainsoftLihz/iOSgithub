//
//  JZTOpenTableCell.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/8/15.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "JZTOpenTableCell.h"

@implementation JZTOpenTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_openBtn setTitle:@"展开" forState:UIControlStateNormal];
    [_openBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_openBtn setTitle:@"收起" forState:UIControlStateSelected];
    [_openBtn addTarget:self action:@selector(clickOpen:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setContStr:(NSString *)contStr{
    self.conLab.text = contStr;
    
    NSInteger numLines  = [self numberOfLinesForFont:self.conLab.font constrainedToSize:CGSizeMake(Screen_Width-24, MAXFLOAT) lineBreakMode:self.conLab.lineBreakMode and:contStr];
    
    if (numLines >= 3) {
        //        self.contLAb.numberOfLines = 3;
        self.openBtn.hidden = NO;
        //
        [self.conLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.top.mas_equalTo(12);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
            //
        }];
        [self.openBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.conLab.mas_bottom).offset(12);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
            make.bottom.mas_equalTo(self.contentView).offset(-12);
        }];
        
    }else {
        //        self.contLAb.numberOfLines = 0;
        self.openBtn.hidden = YES;
        [self.conLab mas_remakeConstraints:^(MASConstraintMaker *make) {
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
        self.conLab.numberOfLines = 0;
        //
        //        [self.openBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        //            make.right.mas_equalTo(self.contentView).offset(-12);
        //            make.bottom.mas_equalTo(self.contentView).offset(-12);
        //            make.top.mas_equalTo(self.contLAb).offset(12);
        //        }];
        
    }else {
        self.conLab.numberOfLines = 3;
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
