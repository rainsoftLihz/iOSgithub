//
//  JZTDropDownTableMenu.h
//  LHZTestIOS
//
//  Created by rainsoft on 2018/5/15.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZTDropDownConfigManager.h"
@class JZTDropDownTableMenu;
@protocol JZTDropDownTableMenuDataSource <NSObject>
@required
- (NSInteger)menu:(JZTDropDownTableMenu *)menu numberOfRowsInColumn:(NSInteger)column;
- (NSString *)menu:(JZTDropDownTableMenu *)menu titleForColumn:(NSInteger)column;
/// 选中以后刷新标题
- (NSString *)menu:(JZTDropDownTableMenu *)menu titleForColumn:(NSInteger)column row:(NSInteger)row;
- (UITableViewCell *)menu:(JZTDropDownTableMenu *)menu tableView:(UITableView*)tableView tableColumn:(NSInteger)column selectedRow:(NSInteger)selectedRow cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

#pragma mark - delegate
@protocol JZTDropDownTableMenuDelegate <NSObject>
@optional
- (void)menu:(JZTDropDownTableMenu *)menu didSelectRow:(NSInteger)row column:(NSInteger)column;
@end

@interface JZTDropDownTableMenu : UIView

@property (nonatomic, weak) id <JZTDropDownTableMenuDataSource> dataSource;

@property (nonatomic, weak) id <JZTDropDownTableMenuDelegate> delegate;

//颜色等配置管理
@property (nonatomic,strong)JZTDropDownConfigManager* configManager;

//标题
@property (nonatomic, strong) NSArray<NSString*>* titleDataSource;

//初始化
- (instancetype)initWithFrame:(CGRect)frame andConfigManager:(JZTDropDownConfigManager*)manger;
@end
