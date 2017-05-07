//
//  MyBaseViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/22.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import "MyBaseViewController.h"

@interface MyBaseViewController ()

@end

@implementation MyBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.titleStr;
    self.view.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    /* 坐标系从navigationBar开始 */
    self.navigationController.navigationBar.translucent = NO;
    
    //self.navigationController.navigationBar.hidden = YES;
}

-(void)sendDataToServer
{
    NSLog(@"%@:sendDataToServer",[self className]);
    
    NSLog(@"trackModel:%@",[self.trackModel description]);
    
    [self.trackModel sendDataToServer];
}


-(JZTTrackModel *)trackModel
{
    if (!_trackModel) {
        _trackModel = [JZTTrackModel new];
        _trackModel.app_id = @"qmyApp";
        _trackModel.app_type = @"iOS_APP";
    }
    return _trackModel;
}

-(void)configParams:(id)params{}

-(void)dealloc
{
   NSLog(@"%@被销毁了", self);
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
