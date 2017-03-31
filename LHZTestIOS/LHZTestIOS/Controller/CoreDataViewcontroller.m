//
//  CoreDataViewcontroller.m
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/28.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import "CoreDataViewcontroller.h"

#import "UserInfo+CoreDataClass.h"

#import "AuthInfo+CoreDataClass.h"

@interface CoreDataViewcontroller ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong)UITableView* tableView;

@property (nonatomic,strong)NSMutableArray* modelDataArr;

/* 编辑多行删除的数据 */
@property (nonatomic,strong)NSMutableArray* deleteArr;

@property (nonatomic,strong)UITextField* nameT;

@property (nonatomic,strong)UITextField* iconT;

@property (nonatomic,strong)UIButton* deleteBtn;

@end

@implementation CoreDataViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self navBar];
    
    [self.view addSubview:self.tableView];
    
    self.deleteArr = [NSMutableArray array];
    
    [self addDataView];
    
    /* 增加数据 */
//    UserInfo *uinfo = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:[LZTCoreDataManager sharedManager].managedObjectContext];
//     AuthInfo* ainfo = [NSEntityDescription insertNewObjectForEntityForName:@"AuthInfo" inManagedObjectContext:[LZTCoreDataManager sharedManager].managedObjectContext];
//    ainfo.email = @"76353535@qq.com";
//    uinfo.authInfo = ainfo;
//    
//    uinfo.name = @"张大爷";
//    
//    [LZTCoreDataManager insertEntityWithEntityName:@"UserInfo" manageObj:uinfo];
//    
//    UserInfo *uinfo2 = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:[LZTCoreDataManager sharedManager].managedObjectContext];
//    uinfo2.name = @"李大爷";
//    uinfo2.authInfo = ainfo;
//     [LZTCoreDataManager insertEntityWithEntityName:@"UserInfo" manageObj:uinfo2];
    
    NSString* predUser = [NSString stringWithFormat:@"name like[cd] '%@'",@"Name1"];
    [LZTCoreDataManager selectFromEntityWithEntityName:@"UserInfo" predStr:predUser resultsBlock:^(NSArray *results) {
        
        [results enumerateObjectsUsingBlock:^(UserInfo*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSLog(@"objectID=:%@",[obj objectID]);
            AuthInfo* ainfo = [NSEntityDescription insertNewObjectForEntityForName:@"AuthInfo" inManagedObjectContext:[LZTCoreDataManager sharedManager].managedObjectContext];
            if (ainfo) {
                ainfo.email = @"34532325@qq.com";
                ainfo.address = @"湖北省武汉市";
                
                [LZTCoreDataManager insertEntityWithEntityName:@"AuthInfo" manageObj:ainfo];
            }
            
            obj.authInfo = ainfo;
            
            [[LZTCoreDataManager sharedManager] saveContext];
        }];
    }];
//    if (info) {
//        [info setValue:@"王五" forKey:@"name"];
//        [LZTCoreDataManager insertEntityWithEntityName:@"UserInfo" manageObj:info];
//    }
    
    
    
    /* 查询 */
    [LZTCoreDataManager selectFromEntityWithEntityName:@"AuthInfo" predStr:nil resultsBlock:^(NSArray *results) {
        
        [results enumerateObjectsUsingBlock:^(AuthInfo*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"name%ld=:%@",idx,[obj valueForKey:@"email"]);
            NSLog(@"imgUrl%ld=:%@",idx,[obj valueForKey:@"address"]);
            
            NSLog(@"objectID=:%@",[obj objectID]);
//            if ([[obj valueForKey:@"email"] isEqualToString: @"12345465@qq.com"]) {
//                [LZTCoreDataManager selectFromEntityWithEntityName:@"UserInfo" predStr:nil resultsBlock:^(NSArray *results) {
//                    [results enumerateObjectsUsingBlock:^(UserInfo*  _Nonnull uinfo, NSUInteger idx, BOOL * _Nonnull stop) {
//                        if ([uinfo.name isEqualToString:@"Tiger"]) {
//                            
//                            uinfo.authInfo = obj;
//                            [[LZTCoreDataManager sharedManager] saveContext];
//                        }
//                    }];
//                }];
//            }
        }];
    }];
    
    
    /* 修改数据 */
    //NSString* sqlPredStr = [NSString stringWithFormat:@"name like[cd] '%@'",@"李四"];/* 过滤条件 */
//    [LZTCoreDataManager updateWitnEntityName:@"UserInfo" andPredStr:nil andUpdateProperties:@"phoneNo" andupdateWith:@"18627810083"];
//
    /* 查询 */
    [self requestData];

}

-(void)navBar
{
    UIButton* nav = [UIButton buttonWithType:UIButtonTypeCustom];
    [nav setTitle:@"编辑" forState:UIControlStateNormal];
    nav.frame = CGRectMake(0, 0, 64, 44);
    nav.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [nav setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nav];
    
    [nav addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)editBtnClick:(UIButton*)btn
{
    if ([btn.currentTitle isEqualToString:@"编辑"]) {
        [self.tableView setEditing:YES animated:YES];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        self.deleteBtn.hidden = NO;
    }
    
    else if ([btn.currentTitle isEqualToString:@"确定"]) {
        [self.tableView setEditing:NO animated:YES];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        self.deleteBtn.hidden = YES;
    }
}

-(void)requestData
{
    /* 查询 */
    __weak typeof(self)wkSelf = self;
    [LZTCoreDataManager selectFromEntityWithEntityName:@"UserInfo" predStr:nil resultsBlock:^(NSArray *results) {
        
        [results enumerateObjectsUsingBlock:^(UserInfo*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"name%ld=:%@",idx,[obj valueForKey:@"name"]);
//            NSLog(@"imgUrl%ld=:%@",idx,[obj valueForKey:@"iconUrl"]);
//            NSLog(@"phoneNo%ld=:%@",idx,[obj valueForKey:@"phoneNo"]);
//            NSLog(@"sex%ld=:%@",idx,[obj valueForKey:@"sex"]);
            NSLog(@"objectID=:%@",[obj objectID]);
            NSLog(@"authInfo=:%@",[obj authInfo]);
        }];
        
        wkSelf.modelDataArr =  [NSMutableArray arrayWithArray:results]; ;
        [wkSelf.tableView reloadData];
    }];
}

#pragma mark ---  tableView
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-49) style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = YES;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.allowsMultipleSelectionDuringEditing = YES;
        _tableView.allowsSelectionDuringEditing = YES;
    }
    return _tableView;
}


-(void)addDataView
{
    UIButton* deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(0, Screen_Height-49*2-64, Screen_Width, 49);
    deleteBtn.backgroundColor = UIColorFromRGB(0x28c412);
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.deleteBtn = deleteBtn];
    self.deleteBtn.hidden = YES;
    
    
    UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height-49-64, Screen_Width, 49)];
    bottomView.backgroundColor = UIColorFromRGB(0xffffff);
    [self.view addSubview:bottomView];
    
    UILabel* nameLab = [UILabel new];
    nameLab.text = @"name:";
    [bottomView addSubview:nameLab];
    
    UITextField* textF = [[UITextField alloc] init];
    textF.placeholder = @"输入名字";
    [bottomView addSubview:textF];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10.0);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
    }];
    
    [textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab.mas_right).offset(2.0);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.width.mas_equalTo(60);
    }];
    
    
    UILabel* iconLab = [UILabel new];
    iconLab.text = @"phoneNo:";
    [bottomView addSubview:iconLab];
    
    UITextField* textI = [[UITextField alloc] init];
    textI.placeholder = @"输入手机号";
    [bottomView addSubview:textI];
    
    textI.delegate = self;
    textF.delegate = self;
    
    [iconLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textF.mas_right).offset(10.0);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
    }];
    
    [textI mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconLab.mas_right).offset(2.0);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.width.mas_equalTo(60);
    }];
    self.iconT = textI;
    self.nameT = textF;
    
    UIButton* addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:addBtn];
    
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn setBackgroundColor:[UIColor orangeColor]];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.mas_equalTo(bottomView);
        make.width.mas_equalTo(49*1.3);
        make.height.mas_equalTo(bottomView);
    }];
    
    [addBtn addTarget:self action:@selector(addDataToSQL) forControlEvents:UIControlEventTouchUpInside];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

-(void)deleteData
{
    if (self.deleteArr.count < 1) {
        return;
    }
    
    [self.deleteArr enumerateObjectsUsingBlock:^(UserInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[LZTCoreDataManager sharedManager].managedObjectContext deleteObject:obj];
        [[LZTCoreDataManager sharedManager] saveContext];
    }];
    
    [self.deleteArr removeAllObjects];
    
    [self requestData];
}

-(void)addDataToSQL
{
    NSString* name = self.nameT.text;
    NSString* icon = self.iconT.text;
    
    if (name.length < 1) {
        return;
    }
    
    UserInfo *info = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:[LZTCoreDataManager sharedManager].managedObjectContext];
    info.name = name;
    info.phoneNo = icon;
    
    [LZTCoreDataManager insertEntityWithEntityName:@"UserInfo" manageObj:info];
    
    [self requestData];
}

#pragma mark --- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelDataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    cell.textLabel.text = [self.modelDataArr[indexPath.row] name];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    
    cell.detailTextLabel.text = [self.modelDataArr[indexPath.row] phoneNo];//[[self.modelDataArr[indexPath.row] authInfo] email];
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}


#pragma mark --- 删除某一行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        /* coreData删除对象 */
        UserInfo* info = self.modelDataArr[indexPath.row];
        [[LZTCoreDataManager sharedManager].managedObjectContext deleteObject:info];
        [[LZTCoreDataManager sharedManager] saveContext];
        
        /* 更新数据愿 */
        [self.modelDataArr removeObjectAtIndex:indexPath.row];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [self.tableView endUpdates];
  
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

/*在多选删除时 在didSelectRowAtIndexPath这个方法中，根据cell所在行的索引值将此行的数据存到self.deleteArr中*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.deleteArr addObject:self.modelDataArr[indexPath.row]];
}

/*当取消删除时，要将self.deleteArr中的数据移除，不然会造成 （你先选中一行 然后取消选中 但是当你点击删除按钮时，这行cell还是会被删除）*/
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [self.deleteArr removeObject:self.modelDataArr[indexPath.row]];
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
