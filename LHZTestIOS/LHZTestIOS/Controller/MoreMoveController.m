//
//  MoreMoveController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/7/30.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "MoreMoveController.h"
#import "RATreeView.h"
#import "RaTreeModel.h"
@interface MoreMoveController ()<RATreeViewDelegate,RATreeViewDataSource>
@property (weak, nonatomic) RATreeView *treeView;
@property (nonatomic,strong)NSArray* dataSource;
@end

@implementation MoreMoveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RATreeView *treeView = [[RATreeView alloc] initWithFrame:CGRectMake(0, 44.0, Screen_Width, Screen_Height-44.0)];
    treeView.delegate = self;
    treeView.dataSource = self;
    treeView.treeFooterView = [UIView new];
    treeView.separatorStyle = RATreeViewCellSeparatorStyleNone;
    self.treeView = treeView;
    
    [self.view addSubview:self.treeView];
    
    [self initData];
    [self.treeView reloadData];
}

//加载数据
- (void)initData {
    
    //宝鸡市 (四层)
    RaTreeModel *zijingcun = [RaTreeModel dataObjectWithName:@"紫荆村" children:nil];
    
    RaTreeModel *chengcunzheng = [RaTreeModel dataObjectWithName:@"陈村镇" children:@[zijingcun]];
    
    RaTreeModel *fengxiang = [RaTreeModel dataObjectWithName:@"凤翔县" children:@[chengcunzheng]];
    RaTreeModel *qishan = [RaTreeModel dataObjectWithName:@"岐山县" children:nil];
    RaTreeModel *baoji = [RaTreeModel dataObjectWithName:@"宝鸡市" children:@[fengxiang,qishan]];
    
    //西安市
    RaTreeModel *yantaqu = [RaTreeModel dataObjectWithName:@"雁塔区" children:nil];
    RaTreeModel *xinchengqu = [RaTreeModel dataObjectWithName:@"新城区" children:nil];
    
    RaTreeModel *xian = [RaTreeModel dataObjectWithName:@"西安" children:@[yantaqu,xinchengqu]];
    
    RaTreeModel *shanxi = [RaTreeModel dataObjectWithName:@"陕西" children:@[baoji,xian]];
    
    
    self.dataSource = @[shanxi,shanxi];
}

#pragma mark --- datasource
- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(nullable id)item{
    RaTreeModel* model = (RaTreeModel*)item;
    if (item == nil) {
        return self.dataSource.count;
    }
    
    return model.children.count;
    
}


- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item {
    
    RaTreeModel *model = item;
    if (item==nil) {
        
        return self.dataSource[index];
    }
    
    return model.children[index];
}


//返回cell
- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item {
    
    
    //获取cell
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    //当前item
    RaTreeModel *model = item;
    
    //当前层级
    NSInteger level = [treeView levelForCellForItem:item];
 
    //赋值
    cell.textLabel.text = model.name;
 
    if (level == 0) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (level == 1){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor yellowColor];
    }else {
        cell.textLabel.textColor = [UIColor blueColor];
    }
    
    return cell;
    
}


#pragma mark --- detelegate

//cell的点击方法
- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item {
    
    //获取当前的层
    NSInteger level = [treeView levelForCellForItem:item];
    
    //当前点击的model
    RaTreeModel *model = item;
    
    if (model.children.count ==0 &&model.children ==nil) {
        NSLog(@"没有数据啦-----------");
    }
    
    NSLog(@"点击的是第%ld层,name=%@",level,model.name);
    
}

//返回行高
- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item {
    
    return 50;
}

//将要展开
- (void)treeView:(RATreeView *)treeView willExpandRowForItem:(id)item {
    
//    UITableViewCell *cell = (UITableViewCell *)[treeView cellForItem:item];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}
//将要收缩
- (void)treeView:(RATreeView *)treeView willCollapseRowForItem:(id)item {
    
//    UITableViewCell *cell = (UITableViewCell *)[treeView cellForItem:item];
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
}

//已经展开
- (void)treeView:(RATreeView *)treeView didExpandRowForItem:(id)item {
    
    
    NSLog(@"已经展开了");
}
//已经收缩
- (void)treeView:(RATreeView *)treeView didCollapseRowForItem:(id)item {
    
    NSLog(@"已经收缩了");
}


- (BOOL)treeView:(RATreeView *)treeView shouldExpandRowForItem:(id)item
{
    RaTreeModel *data = item;
    if (data.children.count >0) {
        return YES;
    }
    return NO;
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
