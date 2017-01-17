//
//  PropertyTestViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/22.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import "PropertyTestViewController.h"

@interface PropertyTestViewController ()

/*

1.属性就是一种支持访问对象成员变更的快捷的方法，可以自动的生成setter和getter方法（setter只支持传一个参数）
 
2.如果没有声明为只读的，它默认会生成两个方法 - (type)name 和 - (void)setName; 为了可读性等其它原因，也可以改变属性的setter和getter访问名称，
 
 @property  (setter=setMyValue, getter=getBool) NSInteger  value;
 
 这样的话就可以通过 [obj setMyValue:10] 和 [obj getBool]方法业访问成员变量了，此时setValue方法会被覆盖，不再存在。
 
*/
@property (nonatomic,strong,getter=isMyGetter)NSString* testGetter;

@property (nonatomic,strong,setter=isMySetter:)NSString* testSetter;

@end

@implementation PropertyTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel* labGet = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, Screen_Width, 100)];
    labGet.text = self.testGetter;
    labGet.backgroundColor = [UIColor yellowColor];
    labGet.textAlignment = NSTextAlignmentCenter;
    labGet.numberOfLines = 0;
    [self.view addSubview:labGet];
    
    
    [self isMySetter:@"更改了setter方法\n@property (nonatomic,strong,setter=isMySetter:)NSString* testSetter"];
    UILabel* labSet = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, Screen_Width, 100)];
    labSet.textAlignment = NSTextAlignmentCenter;
    labSet.text = self.testSetter;
    labSet.numberOfLines = 0;
    labSet.backgroundColor = [UIColor redColor];
    [self.view addSubview:labSet];
}

-(NSString *)isMyGetter
{
    return @"更改了getter方法\n@property (nonatomic,strong,getter=isMyGetter)NSString* testGetter;";
}

-(void)isMySetter:(NSString*)testSetter
{
    _testSetter = testSetter;
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
