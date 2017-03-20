//
//  JZTRulerCell.h
//  JZTArchives
//
//  Created by 梁泽 on 2016/11/4.
//  Copyright © 2016年 梁泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZTRulerCellModel.h"
#define kRulerViewHeight 65
@class JZTRulerCell;
@protocol JZTRulerCellDelegate <NSObject>
- (void)JZTRulerCellRulerDidScorll:(JZTRulerCell*)cell;

@end

@interface JZTRulerCell : UITableViewCell
@property (nonatomic, weak  ) id<JZTRulerCellDelegate> delegate;
+ (__kindof UITableViewCell *)cellWithTableView:(UITableView*)tableView;
+ (__kindof UITableViewCell *)cellWithTableView:(UITableView*)tableView model:(JZTRulerCellModel*)model;

- (void)setupUIWithColor:(UIColor *)color;
- (void)scrollToDefault;
- (void)scrollToRulerValue:(CGFloat)rulerValue;
@end
