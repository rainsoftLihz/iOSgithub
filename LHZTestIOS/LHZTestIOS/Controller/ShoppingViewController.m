//
//  ShoppingViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/4.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "ShoppingViewController.h"
#import "ShoppingCell.h"
#import "ShopViewModel.h"
@interface ShoppingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView* tableView;

@property (nonatomic,strong)ShopViewModel* viewModel;

@property (nonatomic,strong)UILabel* bootomPriceLab;

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.viewModel requestData];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bootomPriceLab];
    
    [self checkPrice];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkPrice) name:@"checkPrice" object:nil];
}

-(void)checkPrice
{
    self.bootomPriceLab.text = [NSString stringWithFormat:@"%.2f",[self.viewModel totlePrice]];
}

-(UILabel *)bootomPriceLab
{
    if (!_bootomPriceLab) {
        _bootomPriceLab = [[UILabel alloc] init];
        _bootomPriceLab.text = @"0.0";
        _bootomPriceLab.textAlignment = NSTextAlignmentCenter;
        _bootomPriceLab.frame = CGRectMake(0, Screen_Height-64-50, Screen_Width, 50);
        _bootomPriceLab.backgroundColor = [UIColor yellowColor];
        _bootomPriceLab.textColor = [UIColor redColor];
    }
    return _bootomPriceLab;
}

#pragma mark ---  tableView
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = YES;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 100.0;
    }
    return _tableView;
}



-(ShopViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[ShopViewModel alloc] init];
    }
    return _viewModel;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCell* cell = [ShoppingCell cellWithTable:tableView];
    cell.model = self.viewModel.dataArr[indexPath.row];
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
