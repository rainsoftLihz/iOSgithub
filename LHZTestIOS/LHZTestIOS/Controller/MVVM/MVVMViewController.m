//
//  MVVMViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2019/1/25.
//  Copyright © 2019年 dazhuanjia. All rights reserved.
//

#import "MVVMViewController.h"
#import "MVVModel.h"
#import "MVVMView.h"
@interface MVVMViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray    *dataArray;
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) MVVModel     *vm;
@end
static NSString *const reuserId = @"reuserId";


@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    __weak typeof(self) weakSelf = self;
    self.vm = [[MVVModel alloc] init];

    [self.vm initWithBlock:^(id data) {
        NSArray *array = data;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:array];
        MVVMView *headView = [[MVVMView alloc] init];
        [headView headViewWithData:array];
        weakSelf.tableView.tableHeaderView = headView;
        [weakSelf.tableView reloadData];
        
    } fail:nil];
    
    [self.vm loadData];
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuserId];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserId forIndexPath:indexPath];
    Model* mol = self.dataArray[indexPath.row];
    cell.textLabel.text = mol.name;
    return cell;
}


#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 标记
    self.vm.model = self.dataArray[indexPath.row];
    
}


#pragma mark - lazy

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
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
