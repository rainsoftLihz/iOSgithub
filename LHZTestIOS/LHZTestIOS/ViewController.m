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

#import "NetWorkViewController.h"

#import "UITestViewController.h"

#import "KeyBoardShowVController.h"

#import "BlueViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView* tableView;

@property (nonatomic,strong)NSArray* titleArr;

@property (nonatomic,strong)NSArray* pushVcArr;

@property (nonatomic,strong)UIImageView* barImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"IOS";
    
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsCompact];
    
    _barImageView =
    //[[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor yellowColor]]];
    //_barImageView.frame = CGRectMake(0, -64, Screen_Width, 64);
    self.navigationController.navigationBar.subviews.firstObject;
    _barImageView.backgroundColor = [UIColor redColor];
    
    //self.navigationController.navigationBar.barTintColor = [UIColor redColor];
}

#pragma mark --- 初始化
-(NSArray *)titleArr{
    return @[@"property属性",@"weak与strong",@"Mansory约束",@"coreData",@"下拉刷新",@"多线程",@"Core Animation",@"购物车",@"递归算法",@"UI细节处理+视图拖拽",@"键盘弹出动画",@"蓝牙连接"];
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
             [ShoppingViewController class],
             [NetWorkViewController class],
             [UITestViewController class],
             [KeyBoardShowVController class],
             [BlueViewController class]];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat maxAlphaOffset = 100;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha =  offset / maxAlphaOffset;
    self.navigationController.navigationBar.alpha = alpha;
    
    NSLog(@"offset=======%lf",offset);
    NSLog(@"alpha=======%lf",alpha);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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


#pragma mark --- 等比压缩图片
+(UIImage *)compressImageWith:(UIImage *)image
{
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = 320;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
