//
//  DownloadCell.h
//  LHZTestIOS
//
//  Created by rainsoft on 17/4/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LHZDownLoadModel.h"

#import "LHZDownExampleModel.h"

@interface DownloadCell : UITableViewCell

@property (nonatomic,strong)UILabel* taskNameLab;

@property (nonatomic,strong)UILabel* processLab;

@property (nonatomic,strong)LHZDownExampleModel* model;

@property (nonatomic, strong) UILabel *stateLabel;

@end
