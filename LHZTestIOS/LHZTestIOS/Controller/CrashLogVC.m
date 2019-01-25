//
//  CrashLogVC.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/6/19.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "CrashLogVC.h"
#import "JZTMulButtonsCell.h"
#import "JZTMulButtonsCollectionView.h"
#import "JZTGoodsInfoCell.h"
#import "JZTGoodsInfoModel.h"

@interface CrashLogVC ()<UITableViewDelegate,UITableViewDataSource,JZTMulButtonsCollectionViewDelegate>
@property(strong,nonatomic)JZTMulButtonsCollectionView* collectionView;

@property(nonatomic,strong)UITableView* tableView;
@end

@implementation CrashLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSArray* arr = @[@"1",@"2"];
//    for (int i = 0; i < 5; i++) {
//        NSString* str = arr[i];
//    }
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view2.backgroundColor=[UIColor redColor];
    [self.view addSubview:view2];
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view2.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //maskLayer.frame = view2.bounds;
//    maskLayer.path = maskPath.CGPath;
    view2.layer.mask = maskLayer;
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 100)];//开始点
    [path addLineToPoint:CGPointMake(50, 0)];//向这条线上加点
    [path addLineToPoint:CGPointMake(100, 50)];
    maskLayer.path = path.CGPath;
    
    self.collectionView = [[JZTMulButtonsCollectionView alloc] initWith:CGRectMake(0,0, Screen_Width, 100) WithTitles:[self titleArr] andImgs:[self imgArr]];
    self.collectionView.delegate = self;
//    [self.view addSubview:self.collectionView];
//
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.collectionView;
}

#pragma mark ---  tableView
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.collectionView.bottom, Screen_Width, Screen_Height-self.collectionView.bottom) style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}


-(void)requestData
{
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [manager GET:@"http://sup.test.yyjzt.com/mobile/salesman/searchMerchandise.json?branchId=FDG&custId=&isOnlyResponse=0&classifyId=98&page=1&pageSize=20" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary* dic = (NSDictionary*)responseObject;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];
}

#pragma mark --- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JZTGoodsInfoCell* cell = [JZTGoodsInfoCell cellWithTableView:tableView];
    JZTGoodsInfoModel* model = [JZTGoodsInfoModel new];
    model.prodName = @"阿胶";
    model.memberPrice = @"100";
    model.retailPrice = @"1000";
    model.manufacturer = @"山东东阿阿胶集团";
    model.storageNumber = @"11";
    model.salesLastMonth = @"197733";
    model.packageUnit = @"袋";

    cell.model = model;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)collectionView:(JZTMulButtonsCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSArray*)titleArr{
    return @[@"扫一扫",@"问题反馈",@"新客登记",@"消息中心"];
}

-(NSArray*)imgArr{
    return @[@"001",@"002",@"003",@"004"];
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
