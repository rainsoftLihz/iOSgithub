//
//  JZTOpenVController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/8/15.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "JZTOpenVController.h"
#import "JZTshowTableCell.h"
#import "JZTOpenTableCell.h"
@interface JZTOpenVController ()<UITableViewDelegate,UITableViewDataSource,JZTshowTableCellDelegete>
@property (nonatomic,strong)UITableView* tableView;
@end

@implementation JZTOpenVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //不管调用[self class]还是[super class]，接受消息的对象都是当前 JZTOpenVControll ＊xxx 这个对象 所以输出的都是JZTOpenVController
    NSLog(@"%@", NSStringFromClass([self class]));
    NSLog(@"%@", NSStringFromClass([super class]));
    
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

#pragma mark ---  tableView
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, Screen_Height-STATUS_BAR_HEIGHT - 44 ) style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = YES;
        _tableView.showsVerticalScrollIndicator = NO;
        
        _tableView.estimatedRowHeight = 99.9;
        
//        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JZTOpenTableCell class]) bundle:nil] forCellReuseIdentifier:@"JZTOpenTableCell"];
        
        
    }
    return _tableView;
}

-(void)clickAction{
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        JZTOpenTableCell* cell = [tableView dequeueReusableCellWithIdentifier:@"JZTOpenTableCell"];
        if (!cell) {
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"JZTOpenTableCell" owner:nil options:nil];
            cell = [nibs lastObject];
        }
        cell.dellegte = self;
        if (indexPath.row%2) {
            cell.contStr = @"您的订单--南京白下雅合诊所购买的【阿莫西林... 】等商品被负责人驳回，点击查看详情，您的订单--南京白下雅合诊所购买的【阿莫西林... 】等商品被负责人驳回， 点击查看详情！点击查看详情！";
        }else{
            cell.contStr = @"您的订单--南京白下雅合诊所购买的【阿莫西林... 】等商品被负责人驳回，点击查看详情.";
        }
        return cell;
    }
    
    static  NSString  *CellIdentiferId = @"JZTshowTableCell";
    JZTshowTableCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell = [[JZTshowTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentiferId];
    };
    cell.dellegte = self;
    if (indexPath.row%2) {
        cell.contStr = @"您的订单--南京白下雅合诊所购买的【阿莫西林... 】等商品被负责人驳回，点击查看详情，您的订单--南京白下雅合诊所购买的【阿莫西林... 】等商品被负责人驳回， 点击查看详情！点击查看详情！";
    }else{
        cell.contStr = @"您的订单--南京白下雅合诊所购买的【阿莫西林... 】等商品被负责人驳回，点击查看详情.";
    }
    
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
