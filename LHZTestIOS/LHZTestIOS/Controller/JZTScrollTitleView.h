//
//  JZTNewBtnScrollView.h
//  JK_BLB
//
//  Created by rainsoft on 16/10/27.
//  Copyright © 2016年 com.JoinTown.jk998. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
   Scroll视图样式：等宽度和等间距
*/

typedef NS_ENUM(NSInteger,kScrollTitleType) {
    
    kScrollTitleTypeEqualToSpace, //等间距 默认值
    
    kScrollTitleTypeEqualToWidth,//等宽
};

typedef void (^ClickBtnBack)(NSInteger segIndex);

@interface JZTScrollTitleView : UIScrollView

@property (nonatomic,strong)ClickBtnBack clickBack;

-(instancetype)initWithFrame:(CGRect)frame andDataArr:(NSArray*)dataArr andselectTextColor:(UIColor*)textColor;

-(instancetype)initWithFrame:(CGRect)frame andDataArr:(NSArray*)dataArr andselectTextColor:(UIColor*)textColor andTitleType:(kScrollTitleType)type;

-(void)setSelectedIndex:(NSInteger)selectedIndex; //滑动事件
@end

