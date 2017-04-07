//
//  DownloadCell.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/4/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "DownloadCell.h"

#import "LHZDownLoadOperationManager.h"

#import "LHZDownLoadStore.h"

#define BTN_TAG 100

@implementation DownloadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    self.taskNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 111, Screen_Width/2.0, 111)];
    self.taskNameLab.backgroundColor = [UIColor whiteColor];
    self.taskNameLab.textColor = [UIColor blackColor];
    self.taskNameLab.font = [UIFont systemFontOfSize:18.0];
    [self.contentView addSubview:self.taskNameLab];
    
    self.stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/2.0, 111, Screen_Width/2.0, 111)];
    self.stateLabel.backgroundColor = [UIColor blackColor];
    self.stateLabel.textColor = [UIColor whiteColor];
    self.stateLabel.font = [UIFont systemFontOfSize:18.0];
    [self.contentView addSubview:self.stateLabel];
    
    self.processLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.taskNameLab.bottom, Screen_Width, 100)];
    [self.contentView addSubview:self.processLab];
    self.processLab.textAlignment = NSTextAlignmentCenter;
    self.processLab.backgroundColor = [UIColor yellowColor];
    self.processLab.textColor = [UIColor redColor];
    self.processLab.font = [UIFont systemFontOfSize:15.0];
    
    NSArray* arr = @[@"暂停",@"继续"];
    for (int i = 0; i < arr.count; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = BTN_TAG+i;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(Screen_Width/2.0*i, self.processLab.bottom, Screen_Width/2.0, 100);
        UIColor* colro = i?[UIColor greenColor]:[UIColor redColor];
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        [btn setTitleColor:colro forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark --- 暂停和继续
-(void)btnClick:(UIButton*)sender
{
    for (int i = 0; i < 2; i++) {
        UIButton* btn = [self.contentView viewWithTag:BTN_TAG+i];
        btn.layer.borderWidth = 0;
    }
   
    sender.layer.borderWidth = 1.0;
    
    LHZDownLoadOperationManager *manger = [LHZDownLoadOperationManager manager];
 
    if ([sender.currentTitle isEqualToString:@"暂停"]) {
        switch (self.model.state) {

            case LHZDownloadStateWaiting:
            case LHZDownloadStateRunning:
                [manger stopWiethModel:self.model];
                break;
            default:
                break;
        }
    }
    else {
        switch (self.model.state) {
            case LHZDownloadStateWaiting:
            case LHZDownloadStateRunning:
                [manger stopWiethModel:self.model];
                break;
            default:
                break;
                
        }
    }
}

-(void)setModel:(LHZDownExampleModel *)model
{
    if (_model == model) {
        return;
    }
    _model = model;
    
    //__weak typeof(self) weakSelf = self;
  
}

- (void)setupShowLabel{
    switch (self.model.state) {
        case LHZDownloadStateNone:
            self.stateLabel.text = @" ";
            break;
        case LHZDownloadStateWaiting:
            self.stateLabel.text = @"等待中...";
            break;
        case LHZDownloadStateFailed:
            self.stateLabel.text = @"下载失败";
            break;
        case LHZDownloadStateRunning:
            self.stateLabel.text = @"正在下载...";
            break;
        case LHZDownloadStateCompleted:
            self.stateLabel.text = @"下载完成";
//            if ([self.delegate respondsToSelector:@selector(JZTBeDownloadCell:modelDidDownCompletion:)]) {
//                [self.delegate JZTBeDownloadCell:self modelDidDownCompletion:self.model];
//            }
            break;
        case LHZDownloadStateSuspended:
            self.stateLabel.text = @"暂停";
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
