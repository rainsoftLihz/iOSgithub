//
//  JZTHomeVC.m
//  JZTAudio
//
//  Created by 梁泽 on 2017/2/21.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#import "JZTHomeVC.h"
#import "JZTRecommendVC.h"
#import "JZTCategoryVC.h"
#import "JZTBangDanVC.h"
#import "JZTAnchorVC.h"

@interface JZTHomeVC ()<UIScrollViewDelegate>

@end

@implementation JZTHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(goToVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        
    }];
}

-(void)goToVC
{
    JZTAnchorVC* vc = [[JZTAnchorVC alloc] init];
    vc.title = @"TEST";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
