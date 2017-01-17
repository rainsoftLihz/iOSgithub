//
//  TableRefreshViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/29.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import "TableRefreshViewController.h"

#import "UIScrollView+RefreshView.h"

@interface TableRefreshViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic,strong)UITableView* tableView;

@property (nonatomic,strong)NSMutableArray* dataArr;

@property (nonatomic,strong)UISearchBar* serarchBar;

@end

@implementation TableRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
    __typeof (&*self) __weak weakSelf = self;
    [self.tableView addRefreshHeaderWithActionHandler:^{
       
        [weakSelf requestData];
    }];
    
    
    /* 搜索 */
    self.serarchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 2, [UIScreen mainScreen].bounds.size.width, 40)];
    //[self.view addSubview:self.serarchBar];
    [self.serarchBar searchBarStyle];
    self.serarchBar.placeholder = @"搜索";
    self.serarchBar.delegate=self;
    self.serarchBar.backgroundColor =[UIColor clearColor];
    
    
    //    NSArray *list= [[self.searchBar.subviews objectAtIndex:0] subviews];
    //    [[list firstObject] removeFromSuperview];
    
    for (UIView* subview in [[self.serarchBar.subviews lastObject] subviews]) {
        
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)subview;
            //修改输入框的颜色
            [textField setBackgroundColor:UIColorFromRGB(0xf5f5f5)];
            //修改placeholder的颜色
            [textField setValue:UIColorFromRGB(0x898989)forKeyPath:@"_placeholderLabel.textColor"];
        }
        else if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            [subview removeFromSuperview];
        }
    }

}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.refreshView = nil;
}

-(void)requestData
{
    double delayInSeconds = 1.0;
    __typeof (&*self) __weak weakSelf = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        NSString* numberStr = [NSString stringWithFormat:@"%d",arc4random_uniform(1000)];
        [weakSelf.dataArr addObject:numberStr];
        
        [weakSelf.tableView  reloadData];
        
        [weakSelf.tableView.refreshView endRefresh];
        NSLog(@"====***********====");
    });
}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    };
    return _dataArr;
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row]];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(void)dealloc
{
    
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
