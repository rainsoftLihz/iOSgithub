//
//  MVVMView.m
//  LHZTestIOS
//
//  Created by rainsoft on 2019/1/25.
//  Copyright © 2019年 dazhuanjia. All rights reserved.
//

#import "MVVMView.h"

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#import "Model.h"
@interface MVVMView()
@property(nonatomic,strong) NSMutableArray* titleAry;
@end
@implementation MVVMView

-(void)headViewWithData:(NSArray*)titleAry{
    //btn 起始坐标
    CGFloat orgX = 13.0;
    CGFloat pointY = 10.0;

    CGFloat pointX = orgX;
    
    CGFloat btnSpace = 11.0;
    CGFloat btnH = 31;
    CGFloat allWidth = Screen_Width;
    UIFont *titleFont = [UIFont systemFontOfSize:14.0];
    UIColor *titleColor = UIColorFromRGB(0x444444);
    NSCharacterSet  *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    for (int i = 0; i < titleAry.count; i++) {
        Model* model = titleAry[i];
        NSString* titleStr = model.name;
        titleStr = [titleStr stringByTrimmingCharactersInSet:set];

        CGRect rect = [titleStr boundingRectWithSize:CGSizeMake(MAXFLOAT, btnH) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : titleFont} context:nil];
        CGFloat  width = rect.size.width + 22;
        
        if (i == 0) {
            if (width > allWidth) {
                width = allWidth - 2*orgX;
            }
        }else {
            if (width > allWidth) {
                width = allWidth - 2*orgX;
                pointX = orgX;//X从新开始
                pointY += 13.0+btnH;//换行后Y+
            }else {
                //换行
                if (pointX + width > allWidth) {
                    pointX = orgX;//X从新开始
                    pointY += 13.0+btnH;//换行后Y+
                }
                
            }
            
            
        }
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(pointX, pointY, width, btnH);
        but.tag = i + 1000;
        [but addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
        but.backgroundColor = UIColorFromRGB(0xf6f6f6);
        [but setTitleColor:titleColor forState:UIControlStateNormal];
        [but setTitle:titleStr forState:UIControlStateNormal];
        but.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        but.titleLabel.font = titleFont;
        //每次X都加上button宽和间距
        pointX += (width + btnSpace);
        
        [self addSubview:but];
        
        but.backgroundColor = UIColorFromRGB(0xf6f6f6);
    }
    CGRect rect2 = self.frame;
    rect2.size.height = pointY + 35;
    self.frame = rect2;
}

#pragma mark - action

- (void)butAction:(UIButton *)sender{
    
    NSInteger tag = sender.tag - 1000;
    
    NSLog(@"%zd",tag);
    
}

@end
