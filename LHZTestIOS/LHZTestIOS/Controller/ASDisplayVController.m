//
//  ASDisplayVController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2019/1/11.
//  Copyright © 2019年 dazhuanjia. All rights reserved.
//

#import "ASDisplayVController.h"

@interface ASDisplayVController ()<ASTableDelegate,ASTableDataSource>

@end

@implementation ASDisplayVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"ASDisplayNode测试";
    [self testView];
    [self testLab];
    [self testImg];
    [self testTable];
}

#pragma mark --- view
-(void)testView{
    //view
    ASDisplayNode* node = [[ASDisplayNode alloc] initWithViewBlock:^UIView * _Nonnull{
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        view.backgroundColor = UIColor.redColor;
        return view;
    }];
    [self.view addSubnode:node];
}

#pragma mark --- lab
-(void)testLab{
    
    // attribute a string
    NSDictionary *attrs = @{
                            NSFontAttributeName: [UIFont systemFontOfSize:18.0f],
                            NSForegroundColorAttributeName: [UIColor redColor],
                            };
    NSAttributedString *string = [[NSAttributedString alloc] initWithString: @"shuffle" attributes:attrs];
    
    ASTextNode* lab = [[ASTextNode alloc] init];
    lab.frame = CGRectMake(230, 100, 66, 100);
    lab.attributedText = string;
    [self.view addSubnode:lab];
    
//    CGFloat extendY = roundf(44.0f );
//    lab.hitTestSlop = UIEdgeInsetsMake(-extendY, 0.0f, -extendY, 0.0f);
}

#pragma mark --- img
-(void)testImg{
    ASImageNode* img = [[ASImageNode alloc] init];
    img.image = [UIImage imageNamed:@"tabbar_icon_find_pressed"];
    img.frame = CGRectMake(0, 200, 66, 66);
    [self.view addSubnode:img];
}

#pragma mark --- table
-(void)testTable{
    ASTableNode* table = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
    table.frame = CGRectMake(0, 274, Screen_Width, 1000);
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubnode:table];
}

// MARK: - ASTableDelegate & ASTableDataSource
- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    // 1
    return 1;
}
//
- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 3
    ASCellNode *(^ASCellNodeBlock)() = ^ASCellNode *() {
        ASTextCellNode *cellNode = [[ASTextCellNode alloc] init];
        cellNode.text = [NSString stringWithFormat:@"ABC%ld",indexPath.row];
        return cellNode;
    };

    return ASCellNodeBlock;
}
//
- (BOOL)shouldBatchFetchForTableNode:(ASTableNode *)tableNode {
    return YES;
}

- (ASCellNode *)tableNode:(ASTableNode *)tableNode nodeForRowAtIndexPath:(NSIndexPath *)indexPath{
    ASTextCellNode *cellNode = [[ASTextCellNode alloc] init];
    cellNode.text = [NSString stringWithFormat:@"ABC%ld",indexPath.row];
    
    return cellNode;
}


- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode{
    // 4
    return 1;
}

//- (ASLayoutSpec*)layoutSpecThatFits:(ASSizeRange)constrainedSize{
//
//}

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
