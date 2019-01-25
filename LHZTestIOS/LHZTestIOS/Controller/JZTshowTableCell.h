//
//  JZTshowTableCell.h
//  LHZTestIOS
//
//  Created by rainsoft on 2018/8/15.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JZTshowTableCellDelegete<NSObject>
-(void)clickAction;
@end
@interface JZTshowTableCell : UITableViewCell
@property (strong, nonatomic)  UILabel *contLAb;
@property (strong, nonatomic)  UIButton *openBtn;
@property (nonatomic,strong)NSString* contStr;
@property (nonatomic,weak) id<JZTshowTableCellDelegete> dellegte;
@end
