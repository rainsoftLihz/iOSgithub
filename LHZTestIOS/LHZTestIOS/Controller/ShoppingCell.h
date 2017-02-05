//
//  ShoppingCell.h
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/4.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopModel.h"
@interface ShoppingCell : UITableViewCell
+(__kindof UITableViewCell *)cellWithTable:(UITableView*)tableView;

@property (nonatomic,strong)ShopModel* model;

@end
