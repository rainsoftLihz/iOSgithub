//
//  JZTAnchorVC.m
//  JZTAudio
//
//  Created by 梁泽 on 2017/2/21.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#import "JZTAnchorVC.h"

@interface JZTAnchorVC ()

@end

@implementation JZTAnchorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(goBackVC) forControlEvents:UIControlEventTouchUpInside];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        
    }];
}

-(void)goBackVC
{
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController popViewControllerAnimated:YES];
}


@end
