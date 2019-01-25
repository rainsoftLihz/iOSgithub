//
//  JZTNewBtnScrollView.m
//  JK_BLB
//
//  Created by rainsoft on 16/10/27.
//  Copyright © 2016年 com.JoinTown.jk998. All rights reserved.
//


#import "JZTScrollTitleView.h"

#define LINE_HEIGHT 2 //线条高度度

#define BTN_TAG 1667 //按钮TAG值

@interface JZTScrollTitleView()

@property (nonatomic,strong)NSArray* titleArr; //标题数组

@property (nonatomic,strong)NSMutableArray* btnWithArr;

@property (nonatomic,strong)UIView* line;

@property (nonatomic,assign)NSInteger selectIndex; //选中的btn

@property (nonatomic,assign)kScrollTitleType type; //视图类型

@end


@implementation JZTScrollTitleView

-(instancetype)initWithFrame:(CGRect)frame andTitleArr:(NSArray*)titleArr andselectTextColor:(UIColor*)textColor
{
    if (self = [super initWithFrame:frame]) {
        [self configDefaultValue];
        [self setUIWithTitleArr:titleArr andSelectTextColor:textColor];
    }
    return self;
}

#pragma mark ---  设置默认值
-(void)configDefaultValue
{
    self.selectIndex = -1;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    //设置默认值
    self.equalWidth = Screen_Width/5.0;
    self.equalSpace = 10.0;
    self.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
}


-(instancetype)initWithFrame:(CGRect)frame andTitleArr:(NSArray*)titleArr andselectTextColor:(UIColor*)textColor andTitleType:(kScrollTitleType)type
{
    if (self = [super initWithFrame:frame]) {
        [self configDefaultValue];
        self.type = type;
        [self setUIWithTitleArr:titleArr andSelectTextColor:textColor];
    }
    return self;
}

-(void)setUIWithTitleArr:(NSArray*)titleArr andSelectTextColor:(UIColor*)textColor
{
    if (titleArr.count < 1) {
        return;
    }
    
    self.btnWithArr = [NSMutableArray array];
    
    self.titleArr = [titleArr copy];
    
    float origX = 0; //纪录初始位置
    float origY = 0;
    
    for (NSString* titleStr in titleArr) {
        float width =[self stringWithWidthText:titleStr andFont:[UIFont systemFontOfSize:14]]; //保留一定的间距
        
        /** 按钮等宽 **/
        if (self.type == kScrollTitleTypeEqualToWidth) {
            width = self.equalWidth;
        }
       
        [self.btnWithArr addObject:[NSString stringWithFormat:@"%f",width]];
    }

    //做成等间距
    CGFloat space = 0;
    /** 按钮等间距 **/
    if (self.type == kScrollTitleTypeEqualToSpace) {
        space = self.equalSpace;
    }
    
    for (int i = 0; i < self.titleArr.count; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(origX, origY, [self.btnWithArr[i] floatValue] , self.height-LINE_HEIGHT);
        //宽度递增 //改变x轴的值
        if (i != self.titleArr.count-1) {
            origX += [self.btnWithArr[i] floatValue]+space;
        }
   
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:textColor forState:UIControlStateSelected];//选中时候的颜色
        [btn setTitleColor:UIColorFromRGB(0x848484) forState:UIControlStateNormal];
        btn.tag = BTN_TAG+i; //设置tag值

        [self addSubview:btn];
        
        //btn 点击事件
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
     
    }
    
    //改变视图的宽度
    self.contentSize = CGSizeMake(origX+[[self.btnWithArr lastObject] floatValue],self.frame.size.height);
    
    //线条的默认位置 btn0
    UIButton* button = (UIButton*)[self viewWithTag:BTN_TAG];
    self.line = [[UIView alloc]initWithFrame:CGRectMake(0,self.height-LINE_HEIGHT, [self.btnWithArr[0] floatValue]-10, LINE_HEIGHT+2)];
    self.line.backgroundColor = textColor;
    self.line.centerX = button.centerX;
    [self addSubview:self.line];
}


#pragma mark --- 点击事件
- (void)btnClick:(UIButton *)button {
    
    NSInteger index = [button tag]-BTN_TAG;
    if (self.selectIndex ==[button tag]-BTN_TAG) {
        return;
    }
    
    [self doActionWith:index];
}

#pragma mark --- 滑动返回事件
- (void)setSelectedIndex:(NSInteger)index {
    
    if (self.selectIndex == index) {
        return;
    }
    
    [self doActionWith:index];
}

-(void)doActionWith:(NSInteger)index
{

    UIButton* button = (UIButton*)[self viewWithTag:BTN_TAG+index];
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [(UIButton *)subview setSelected:NO];
        }
    }
    [button setSelected:YES];
    
    CGFloat left = button.frame.origin.x;
    
    if (left - self.frame.size.width/2.0 > 0 && self.contentSize.width - left > Screen_Width/2.0) {
        left = left - self.frame.size.width/2.0;
    }
    
    if (left - self.frame.size.width/2.0 > 0 && self.contentSize.width - left < Screen_Width/2.0) {
        left = self.contentSize.width - self.frame.size.width;
    }
 
    if (index <= 2) {
        left = 0;
    }

    [self setContentOffset:CGPointMake(left, 0) animated:YES];
    
    self.line.width = [self.btnWithArr[index] floatValue]; //改变线条的宽度
    self.line.centerX = button.centerX; //改变线条的位置
    
    if (self.clickBack) {
        self.clickBack(index);
    }
    
    self.selectIndex = index;
}


/**
 *  text 宽度
 */
- (CGFloat)stringWithWidthText:(NSString *)text andFont:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    return rect.size.width;
}

@end
