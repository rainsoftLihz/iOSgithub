//
//  JZTOpenTableCell.h
//  LHZTestIOS
//
//  Created by rainsoft on 2018/8/15.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZTshowTableCell.h"
@interface JZTOpenTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *conLab;
@property (weak, nonatomic) IBOutlet UIButton *openBtn;
@property (nonatomic,strong)NSString* contStr;

@property (nonatomic,weak) id<JZTshowTableCellDelegete> dellegte;
@end
