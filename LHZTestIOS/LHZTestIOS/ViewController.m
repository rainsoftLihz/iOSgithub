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

#import "JZTTabBarVC.h"

#import "BiaoChiViewController.h"

#import "UIDynamicViewController.h"

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
  
    NSMutableString *url = [@"https://test-m.998pz.cn/view/index.html?ch=1&par=5&userId=10000000000@qq.com" mutableCopy];
    
    //NSLog(@"%@",[self lz_OriginUrl:url StringdeleteParameter:@"userId"]);
    
    NSError *error;
    // 创建NSRegularExpression对象并指定正则表达式
    NSRegularExpression *regex = [NSRegularExpression
                        regularExpressionWithPattern:@"userId=[\\w@\\.]*&*"
                                  options:0
                                  error:&error];
    if (!error) { // 如果没有错误
        // 获取特特定字符串的范围
        NSTextCheckingResult *match = [regex firstMatchInString:url
                options:0 range:NSMakeRange(0, [url length])];
        if (match) {
            // 截获特定的字符串
            NSString *result = [url substringWithRange:match.range];
            NSLog(@"result====%@",result);
            [url deleteCharactersInRange:match.range];
            NSLog(@"url=====%@",url);
        }
        
        
    }

}

#pragma mark --- 初始化
-(NSArray *)titleArr{
    return @[@"动力行为",@"property属性",@"weak与strong",@"Mansory约束",@"coreData",@"下拉刷新",@"多线程",@"Core Animation",@"购物车",@"递归算法",@"UI细节处理+视图拖拽",@"键盘弹出动画",@"蓝牙连接",@"TabBar",@"标尺"];
}

-(NSArray *)pushVcArr
{
    return @[[UIDynamicViewController class],
             [PropertyTestViewController class],
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
             [BlueViewController class],
             [JZTTabBarVC class],
             [BiaoChiViewController class]];
}

#pragma mark ---  tableView
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-64.0) style:UITableViewStylePlain];
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
    
    NSString* str = self.titleArr[indexPath.row];
    
    if ([str isEqualToString:@"TabBar"]) {
        JZTTabBarVC* vc = [[JZTTabBarVC alloc] init];
        //[vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
          /* 动画 */
//        CATransition *animation = [CATransition animation];
//        animation.duration = 1.0;
//        animation.timingFunction = UIViewAnimationCurveEaseInOut;
//        animation.type = @"rippleEffect";
////        animation.type = kCATransitionMoveIn;
//        //animation.subtype = kCATransitionFromRight;
//        [self.view.window.layer addAnimation:animation forKey:nil];
//        [self presentViewController:vc animated:NO completion:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
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

- (NSString *)lz_OriginUrl:(NSString*)originUrl StringdeleteParameter:(NSString *)parameter;{
    NSString *finalStr = @"";
    NSMutableString * mutStr = originUrl.mutableCopy;
    NSArray *strArray = [mutStr componentsSeparatedByString:parameter];
    NSMutableString *firstStr = [strArray firstObject];
    NSMutableString *lastStr = [strArray lastObject];
    NSRange characterRange = [lastStr rangeOfString:@"&"];
    if (characterRange.location != NSNotFound) {
        NSArray *lastArray = [lastStr componentsSeparatedByString:@"&"];
        NSMutableArray *mutArray = lastArray.mutableCopy;
        [mutArray removeObjectAtIndex:0];
        NSString *modifiedStr = [mutArray componentsJoinedByString:@"&"];
        finalStr = [firstStr stringByAppendingString:modifiedStr];
    } else {
        //以'?'、'&'结尾
        finalStr = [firstStr substringToIndex:[firstStr length] -1];
    }
    return finalStr;
}

@end
