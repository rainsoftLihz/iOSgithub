//
//  JZTLHZTabBarVController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/5/30.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "JZTLHZTabBarVController.h"
#import "JZTLHZTabBar.h"
#import "JZTHomeVC.h"
#import "JZTNavigationVC.h"
@interface JZTLHZTabBarVController ()<UITabBarDelegate>
@property (nonatomic, strong) NSArray *rootViewControllers;
@property (nonatomic, strong) NSArray *normalImageArray;
@property (nonatomic, strong) NSArray *selectedImageArray;

@property (nonatomic, strong) JZTLHZTabBar *tabBarMy;
@end

@implementation JZTLHZTabBarVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSubControllers];
}


- (void)configSubControllers {
    
    JZTLHZTabBar *tabBar = [[JZTLHZTabBar alloc] initWithFrame:CGRectMake(0, Screen_Height - 49, Screen_Width, 49)];
    __weak typeof(self)weakSelf = self;
    tabBar.delegate = self;
    tabBar.callItemBack = ^(NSInteger index){
        weakSelf.selectedIndex = index;
        NSArray* titleArr = @[@"哈哈",@"订阅",@"发现",@"我的"];
        self.navigationItem.title = titleArr[index];
    };
    [self setValue:self.tabBarMy = tabBar forKey:@"tabBar"];
    
    
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i<4; i++) {
        JZTNavigationVC *navVC = [[JZTNavigationVC alloc]initWithRootViewController:self.rootViewControllers[i]];
        navVC.title = @"hallVc";
        [navVC setNavigationBarHidden:YES];
    }
    self.viewControllers = arr;
    
    tabBar.btnImageSelected = self.selectedImageArray;
    tabBar.btnImageNormal = self.normalImageArray;
    tabBar.defaultSelect = 0;
    
    //默认选中项 需要先加载tabbar 再设置rootVC 再设置这行代码
    self.selectedIndex = 1;
}


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSArray* titleArr = @[@"哈哈",@"订阅",@"发现",@"我的"];
    NSArray* itemArr = tabBar.items;
    [itemArr enumerateObjectsUsingBlock:^(UITabBarItem*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([item isEqual:obj]) {
            *stop = YES;
            
            self.navigationItem.title = titleArr[idx];
        }
    }];
}

- (NSArray *)rootViewControllers{
    JZTHomeVC *home1 = [[JZTHomeVC alloc]init];
    home1.title = @"哈哈";
    JZTHomeVC *home2 = [[JZTHomeVC alloc]init];
    home2.title = @"订阅";
    JZTHomeVC *home4 = [[JZTHomeVC alloc]init];
    home4.title = @"发现";
    JZTHomeVC *home5 = [[JZTHomeVC alloc]init];
    home5.title = @"我的";
    return @[home1,home2,home4,home5];
}

/**
 *  正常的图片
 */
- (NSArray *)normalImageArray {
    if(!_normalImageArray) {
        _normalImageArray = @[[UIImage imageNamed:@"sy2"],
                              [UIImage imageNamed:@"gwc2"],
                              [UIImage imageNamed:@"ywq2"],
                              [UIImage imageNamed:@"wd2"]
                              ];
    }
    return _normalImageArray;
}

/**
 *  选中的图片
 */
- (NSArray *)selectedImageArray {
    if(!_selectedImageArray) {
        _selectedImageArray = @[[UIImage imageNamed:@"sy_15"],
                                [UIImage imageNamed:@"gwc_15"],
                                [UIImage imageNamed:@"ywq_15"],
                                [UIImage imageNamed:@"wd_15"]];
    }
    return _selectedImageArray;
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
