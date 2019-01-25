//
//  LHZViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/4/25.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "LHZViewController.h"
#import "AAViewController.h"
@interface LHZViewController ()

@end

@implementation LHZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.view.backgroundColor = [UIColor yellowColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[AAViewController new] animated:YES];
}

-(void)myPrint{
    NSLog(@"======>>>>myPrint");
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
