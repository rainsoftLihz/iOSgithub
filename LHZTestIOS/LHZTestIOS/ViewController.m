//
//  ViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/22.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import "ViewController.h"

#import "PropertyTestViewController.h"

#import "WeakAndStrongViewController.h"

#import "MasonryViewController.h"

#import "CoreDataViewcontroller.h"

#import "TableRefreshViewController.h"

#import "ShoppingViewController.h"

#import "MutilThreadVC.h"

#import "CoreAnimationVC.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView* tableView;

@property (nonatomic,strong)NSArray* titleArr;

@property (nonatomic,strong)NSArray* pushVcArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"IOS";
}

#pragma mark --- 初始化
-(NSArray *)titleArr{
    return @[@"property属性",@"weak与strong",@"Mansory约束",@"coreData",@"下拉刷新",@"多线程",@"Core Animation",@"购物车"];
}

-(NSArray *)pushVcArr
{
    return @[[PropertyTestViewController class],
             [WeakAndStrongViewController class],
             [MasonryViewController class],
             [CoreDataViewcontroller class],
             [TableRefreshViewController class],
             [MutilThreadVC class],
             [CoreAnimationVC class],
             [ShoppingViewController class]];
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
    }
    return _tableView;
}

#pragma mark --- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark ----UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyBaseViewController* vc = [[self.pushVcArr[indexPath.row] alloc] init];
    
    vc.titleStr = self.titleArr[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
