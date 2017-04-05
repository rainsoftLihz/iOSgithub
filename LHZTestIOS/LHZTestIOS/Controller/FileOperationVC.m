//
//  FileOperationVC.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/4/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "FileOperationVC.h"

@interface FileOperationVC ()

@end

@implementation FileOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *filePath = @"http://www.baidu.com/img/baidu_logo_fqj_10.gif";
    
    // 从路径中获得完整的文件名（带后缀）
    NSString* exestr = [filePath lastPathComponent];
    NSLog(@"%@",exestr);
    
    // 获得文件名（不带后缀）
    exestr = [exestr stringByDeletingPathExtension];
    NSLog(@"%@",exestr);
    
    // 获得文件的后缀名（不带'.'）
    exestr = [filePath pathExtension];
    NSLog(@"%@",exestr);
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
