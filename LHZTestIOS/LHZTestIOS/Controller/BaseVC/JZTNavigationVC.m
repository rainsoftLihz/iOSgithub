//
//  JZTNavigationVC.m
//  JZTAudio
//
//  Created by 梁泽 on 2017/2/20.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#import "JZTNavigationVC.h"

#import "UIColor+Common.h"

@interface JZTNavigationVC ()

@end

@implementation JZTNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
+ (void)initialize
{
    // 1.设置导航栏主题
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 设置背景图片
    navBar.tintColor = [UIColor whiteColor];
    NSString *bgName =  @"navigationbar_bg_64";
    [navBar setBackgroundImage:[UIImage imageNamed:bgName] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage imageNamed:@"navigation_line@"]];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor navTitleColor];
    attrs[NSFontAttributeName] = [UIFont fontWithName:@"Avenir-Heavy" size:20];
    [navBar setTitleTextAttributes:attrs];
    
    //2.设置BarButtonItem的主题  这是左右的不是标题
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
}

/**
 *  重写这个方法,能拦截所有的push操作
 *
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count>0) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"fanhui" style:UIBarButtonItemStylePlain target:self action:@selector(clickBackItem)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)clickBackItem{
    [self popViewControllerAnimated:YES];
}

@end
