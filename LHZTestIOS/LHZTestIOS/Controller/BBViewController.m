//
//  BBViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/4/25.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "BBViewController.h"
#import "LHZViewController.h"
@interface BBViewController ()

@end

@implementation BBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[LHZViewController class]]) {
            LHZViewController* vc =  (LHZViewController*)controller;
            [self.navigationController popToViewController:vc animated:YES];
            [vc myPrint];
        }
    }
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
