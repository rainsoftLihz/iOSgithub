//
//  JZTTabBarVC.m
//  JZTAudio
//
//  Created by 梁泽 on 2017/2/20.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#import "JZTTabBarVC.h"
#import "JZTNavigationVC.h"
#import "JZTHomeVC.h"
#import "JZTTabBar.h"

@interface JZTTabBarVC ()<JZTTabBarDelegate>
@property (nonatomic, strong) NSArray *rootViewControllers;
@property (nonatomic, strong) NSArray *normalImageArray;
@property (nonatomic, strong) NSArray *selectedImageArray;
@end

#define kTabBarHeight 49
@implementation JZTTabBarVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configSubControllers];
}

- (void)configSubControllers {
 
    JZTTabBar *tabBar = [[JZTTabBar alloc] init];
    tabBar.delegate = self;
    //取消tabBar的透明效果
    //tabBar.translucent = NO;
    
    [self setValue:tabBar forKey:@"tabBar"];
  
    
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i<4; i++) {
        JZTNavigationVC *navVC = [[JZTNavigationVC alloc]initWithRootViewController:self.rootViewControllers[i]];
        navVC.tabBarItem.title = @"";
        navVC.tabBarItem.image = [self.normalImageArray[i] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navVC.tabBarItem.selectedImage = [self.selectedImageArray[i] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        [arr addObject:navVC];
        [navVC setNavigationBarHidden:YES];
        
    }
    self.viewControllers = arr;
   
    
    //默认选中项 需要先加载tabbar 再设置rootVC 再设置这行代码
    self.selectedIndex = 1;
}

#pragma mark - JZTTabBarDelegate Method
- (void)jztTabBarDidClickPlayButton:(JZTTabBar *)tabBar {
    tabBar.playBtn.selected = !tabBar.playBtn.isSelected;
//    CATransition *animation = [CATransition animation];
//    animation.duration = 1.0;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.type = @"rippleEffect";
//    //        animation.type = kCATransitionMoveIn;
//    //animation.subtype = kCATransitionFromRight;
//    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter
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

/**
 *  正常的图片
 */
- (NSArray *)normalImageArray {
    if(!_normalImageArray) {
        _normalImageArray = @[[UIImage imageNamed:@"tabbar_icon_homepage_normal"],
                              [UIImage imageNamed:@"tabbar_icon_Rss_normal"],
                              [UIImage imageNamed:@"tabbar_icon_find_normal"],
                              [UIImage imageNamed:@"tabbar_icon_my_normal"]
                              ];
    }
    return _normalImageArray;
}

/**
 *  选中的图片
 */
- (NSArray *)selectedImageArray {
    if(!_selectedImageArray) {
        _selectedImageArray = @[[UIImage imageNamed:@"tabbar_icon_homepage_pressed"],
                               [UIImage imageNamed:@"tabbar_icon_Rss_pressed"],
                               [UIImage imageNamed:@"tabbar_icon_find_pressed"],
                               [UIImage imageNamed:@"tabbar_icon_my_pressed"]];
    }
    return _selectedImageArray;
}



@end
