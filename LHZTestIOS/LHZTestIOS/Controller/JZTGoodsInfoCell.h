//
//  JZTGoodsInfoCell.h
//  LHZTestIOS
//
//  Created by rainsoft on 2018/4/25.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZTGoodsInfoModel.h"
@interface JZTGoodsInfoCell : UITableViewCell

@property (nonatomic,strong)JZTGoodsInfoModel* model;
+(__kindof JZTGoodsInfoCell *)cellWithTableView:(UITableView*)tableView;
@end
