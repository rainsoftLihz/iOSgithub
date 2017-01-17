//
//  WeakAndStrongViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/22.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import "WeakAndStrongViewController.h"

@interface WeakAndStrongViewController ()

@end

@implementation WeakAndStrongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor whiteColor];
    UILabel* weakLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, Screen_Width, 150)];
    weakLab.numberOfLines = 0;
    weakLab.text = @"  weak表示的是一个弱引用，这个引用不会增加对象的引用计数，并且在所指向的对象被释放之后，weak指针会被设置的为nil。weak引用通常是用于处理循环引用的问题，如代理及block的使用中，相对会较多的使用到weak。";
    weakLab.backgroundColor = [UIColor yellowColor];
    [weakLab sizeToFit];
    //weakLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:weakLab];
    
    UILabel* strongLab = [[UILabel alloc] initWithFrame:CGRectMake(0, weakLab.bottom, Screen_Width, 250)];
    //strongLab.textAlignment = NSTextAlignmentCenter;
    strongLab.text = @"（weak和strong）不同的是 当一个对象不再有strong类型的指针指向它的时候 它会被释放  ，即使还有weak型指针指向它。\n一旦最后一个strong型指针离去 ，这个对象将被释放，所有剩余的weak型指针都将被清除。\n可能有个例子形容是妥当的。\n想象我们的对象是一条狗，狗想要跑掉（被释放）。\nstrong型指针就像是栓住的狗。只要你用牵绳挂住狗，狗就不会跑掉。如果有5个人牵着一条狗（5个strong型指针指向1个对象），除非5个牵绳都脱落 ，否着狗是不会跑掉的。\nweak型指针就像是一个小孩指着狗喊到：“看！一只狗在那” 只要狗一直被栓着，小孩就能看到狗，（weak指针）会一直指向它。只要狗的牵绳脱落，狗就会跑掉，不管有多少小孩在看着它。\n只要最后一个strong型指针不再指向对象，那么对象就会被释放，同时所有的weak型指针都将会被清除。";
    strongLab.numberOfLines = 0;
    strongLab.backgroundColor = [UIColor yellowColor];
    [strongLab sizeToFit];
    [self.view addSubview:strongLab];
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
