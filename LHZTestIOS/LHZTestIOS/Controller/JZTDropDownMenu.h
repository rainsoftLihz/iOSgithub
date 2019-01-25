//
//  JZTDropDowmMenu.h
//  JZTDropDownMenu
//
//  Created by 梁泽 on 2017/2/8.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - data source protocol
@class JZTDropDownMenu;

@protocol JZTDropDownMenuDataSource <NSObject>
@required
- (NSInteger)numberOfColumnsInMenu:(JZTDropDownMenu *)menu;
- (NSInteger)menu:(JZTDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column;
- (NSString *)menu:(JZTDropDownMenu *)menu titleForColumn:(NSInteger)column;
/// 选中以后刷新标题
- (NSString *)menu:(JZTDropDownMenu *)menu titleForColumn:(NSInteger)column row:(NSInteger)row;
- (UITableViewCell *)menu:(JZTDropDownMenu *)menu tableView:(UITableView*)tableView tableColumn:(NSInteger)column selectedRow:(NSInteger)selectedRow cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

#pragma mark - delegate
@protocol JZTDropDownMenuDelegate <NSObject>
@optional
- (void)menu:(JZTDropDownMenu *)menu didSelectRow:(NSInteger)row column:(NSInteger)column;
@end

#pragma mark - interface
@interface JZTDropDownMenu : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <JZTDropDownMenuDataSource> dataSource;
@property (nonatomic, weak) id <JZTDropDownMenuDelegate> delegate;

@property (nonatomic, strong) UIColor *bgNormalColor;
@property (nonatomic, strong) UIColor *bgSelectedColor;
//文字未选的颜色
@property (nonatomic, strong) UIColor *textNormalColor;
//文字选中的颜色
@property (nonatomic, strong) UIColor *textSelectedColor;//default = indicatorSelectedColor
//上下动画尖尖的默认色
@property (nonatomic, strong) UIColor *indicatorNormalColor;
//上下动画尖尖的及勾勾的勾选色
@property (nonatomic, strong) UIColor *indicatorSelectedColor;
//头部中间竖线的颜色
@property (nonatomic, strong) UIColor *separatorColor;
//头部下面横线的颜色
@property (nonatomic, strong) UIColor *bottomLineColor;

/// 配置默认选中行，不设默认为第一行 {@0:@(-1),@1:@2...}第0列，默认不选中，第1列选中下标第3行
- (void)setupDefaultSelectedCloumRow:(NSDictionary*)dic;

//标题
@property (nonatomic, strong) NSArray* titleSourceArr;
@end


