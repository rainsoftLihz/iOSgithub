//
//  BiaoChiViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/28.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "BiaoChiViewController.h"

#import "JZTRulerCellModel.h"
#import "JZTRulerCell.h"
#import "JZTRulerView.h"
#import "JZTRulerScrollView.h"

@interface BiaoChiViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSArray<JZTRulerCellModel *> *dataArr;

@property (nonatomic,strong) NSString* currentHealthAccount;

@property (nonatomic,strong) NSDictionary* valueDic;

@property (nonatomic, copy  ) void(^didSaveCompletion)(BOOL success);
@property (nonatomic, copy  ) dispatch_block_t didClickCancelDismissCompletion;

@end

@implementation BiaoChiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JZTRulerCellModel *model1 = [JZTRulerCellModel new];
    model1.onlyStopMark = YES;
    model1.defaultValue = 4.0;
    model1.rulerMin = 0.0;
    model1.markCount = 1;
    model1.rulerCount = 1200;
    model1.rulerValue = 4.0;
    model1.rulerAverage = 0.01;
    model1.showValidNumCount = 2;
    model1.type = @"11";
    self.dataArr = @[model1];
    
    [self setupUI];

}


-(void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat leftSpace = 40*kProportion;
    UIView* titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    UIButton* cancelBtn = [self creatBtnWithTitle:@"取消" andBackColor:[UIColor clearColor] andTitleColor:UIColorFromRGB(0x28c4af)];
    [cancelBtn addTarget:self action:@selector(backToVC:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* saveBtn = [self creatBtnWithTitle:@"  保存  " andBackColor:UIColorFromRGB(0x28c4af) andTitleColor:[UIColor whiteColor]];
    [saveBtn addTarget:self action:@selector(saveData) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:cancelBtn];
    [titleView addSubview:saveBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleView.mas_left).offset(leftSpace);
        make.centerY.equalTo(titleView);
    }];
    
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleView.mas_right).offset(-leftSpace);
        make.centerY.equalTo(titleView);
        make.height.mas_equalTo(28);
    }];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, saveBtn.bottom, self.view.width, self.view.height-64-saveBtn.bottom) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 85.;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(saveBtn.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
}



#pragma mark --- 保存数据
-(void)saveData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"weight"] = [self.dataArr[0] currentValueStr];
}
#pragma mark --- 取消返回
-(void)backToVC:(UIButton*)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_didClickCancelDismissCompletion) {
        _didClickCancelDismissCompletion();
    }
}

-(UIButton*)creatBtnWithTitle:(NSString*)title andBackColor:(UIColor*)bGcolor andTitleColor:(UIColor*)titleColor
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.backgroundColor = bGcolor;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2.0;
    btn.titleLabel.font  = [UIFont systemFontOfSize:14.0];
    return btn;
}
#pragma mark - UITableViewDelegate|UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return  25;
    }
    CGFloat sapce = (Screen_Height - 20 - 50 - 44 - 50 - self.dataArr.count*(Screen_Height + 30))/self.dataArr.count;
    return MIN(sapce, 180 * kHProportion);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.dataArr.count-1 == section) {
        return 25;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRulerViewHeight + 30;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]init];
    header.backgroundColor = [UIColor clearColor];
    return header;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc]init];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JZTRulerCellModel *model = self.dataArr[indexPath.section];
    JZTRulerCell *cell = [JZTRulerCell cellWithTableView:tableView model:model];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
