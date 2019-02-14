//
//  BlockViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2019/2/13.
//  Copyright © 2019年 dazhuanjia. All rights reserved.
//

#import "BlockViewController.h"

@interface BlockViewController ()

@end

typedef int (^MyBlock) (int);
typedef void (^VoidBlock) (int);

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /****
     1.全局block  _NSGloblalBlock 静态区
     2.堆block _NSMallocBlock
     3.栈block  _NSStackBlock
     ****/
    
    [self test1];
    [self test2];
    [self test3];
}

#pragma mark --- 全局block
-(void)test1{
    void (^block)(void) = ^{
        NSLog(@"hello blcok");
    };
    
    block();
    
    NSLog(@"第一种blcok:%@",block);
}

#pragma mark --- 堆block
-(void)test2{
    
    int a = 10;//捕获了外部变量
    
    //ARC模式下为堆block
    //MRC模式下为栈block
    
    void (^block)(void) = ^{
        NSLog(@"hello blcok %d",10);
    };
    
    block();
    
    NSLog(@"第一种blcok:%@",block);
    
}

#pragma mark --- 栈block
-(void)test3{
    int a = 10;
    NSLog(@"第三种blcok:%@",^{
        NSLog(@"%d",a);
    });
    
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
