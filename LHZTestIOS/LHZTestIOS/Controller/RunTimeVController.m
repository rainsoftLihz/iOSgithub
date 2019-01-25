//
//  RunTimeVController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2019/1/15.
//  Copyright © 2019年 dazhuanjia. All rights reserved.
//

#import "RunTimeVController.h"

@interface RunTimeVController ()

@end

@implementation RunTimeVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

#pragma mark --- 获取类方法
-(void)getClassMethod{
    u_int      count;
    //元类  就是类方法列表
    Method* methods= class_copyMethodList(objc_getMetaClass("RunTimeVController"), &count);
    for (int i = 0; i < count ; i++)
    {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString  stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
    }
    
    //获取类method
    Method m1 = class_getClassMethod(RunTimeVController.class, @selector(AAA));
    
    NSString *strName = [NSString  stringWithCString:sel_getName(method_getName(m1)) encoding:NSUTF8StringEncoding];
    NSLog(@"m1====%@", strName);
}

#pragma mark --- 获取实例方法
-(void)getMyMethod{
    u_int      count;
    //实例列表
    Method* methods= class_copyMethodList([RunTimeVController class], &count);
    for (int i = 0; i < count ; i++)
    {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString  stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
    }
    
    //获取实例method
    Method m1 = class_getInstanceMethod(RunTimeVController.class, @selector(didReceiveMemoryWarning));
    //class_getClassMethod(vv.class, @selector(test1));
    
    NSString *strName = [NSString  stringWithCString:sel_getName(method_getName(m1)) encoding:NSUTF8StringEncoding];
    NSLog(@"m1====%@", strName);
}

+(void)AAA{}
+(void)BBB{}

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
