//
//  ViewController.m
//  MasonryTest
//
//  Created by rainsoft on 16/9/14.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import "MasonryViewController.h"
@interface MasonryViewController ()

{
    CGFloat step;
    
    BOOL showMore;
    
    UIView* testView;
}

@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel* lab1 = [UILabel new];
    lab1.text = @"Hugging priority 确定view有多大的优先级阻止自己变大。\n Compression Resistance priority确定有多大的优先级阻止自己变小。";
    lab1.textAlignment = NSTextAlignmentLeft;
    lab1.numberOfLines = 0;

    UILabel* lab2 = [UILabel new];
    lab2.text = @"就算这个LAB1的文字多了，也不回挤压到LAB2的显示";
    lab2.textAlignment = NSTextAlignmentRight;
    lab2.numberOfLines = 0;
    
    UILabel* lab3 = [UILabel new];
    lab3.text = @"setContentCompressionResistancePriority这个属性的优先级（Priority）越高，越不“容易”被压缩";
    lab3.numberOfLines = 0;
    [self.view addSubview:lab2];
    [self.view addSubview:lab1];
    [self.view addSubview:lab3];
    /* 这个属性的优先级（Priority）越高，越不“容易”被压缩 */
    /* 设置约束的优先级 */
    [lab2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [lab2 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //lab2.preferredMaxLayoutWidth = 10;
    
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.offset(0);
        make.left.mas_equalTo(@10);/* 在父视图坐标系中的绝对坐标 */
        //make.left.mas_equalTo(self.view);/* mas_equalTo 后面是一个对象  */
        make.top.offset(10);
        /* 设置控件的相对于另一空间的水平间距 */
        make.right.mas_equalTo(lab2.mas_left).offset(-5);
        //make.width.mas_greaterThanOrEqualTo(100);
    }];
    
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);/* 默认是相对于父视图 */
        make.top.offset(10);
        //make.left.mas_equalTo(lab1.mas_right).offset(5);
        //make.width.mas_equalTo.(lab1.preferredMaxLayoutWidth)
        /* 设置控件的最大宽度 */
        make.width.mas_lessThanOrEqualTo(100);
        //make.height.mas_equalTo(100);
    }];
    
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);/* 默认是相对于父视图 */
        make.left.offset(10);
        make.top.mas_equalTo(lab2.mas_bottom).offset(10);
    }];

    [self.view layoutIfNeeded];
    
    
    NSArray* name = @[@"one",@"two",@"three"];
    UIButton *previousView = nil;
    for (int i = 0; i < 3; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = i == 1 ? [UIColor redColor]:[UIColor grayColor];
        [btn setTitle:name[i] forState:UIControlStateNormal];
        //[btn addTarget:self action:@selector(toto) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        if (!previousView) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(lab3.mas_bottom).offset(10.0);
                make.width.mas_equalTo(self.view.mas_width).multipliedBy(1.0/3);/*比例*/
            }];
        }
        else {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(previousView.mas_right);
                make.top.mas_equalTo(previousView.mas_top);
                make.width.mas_equalTo(previousView.mas_width);
            }];
        }
        
        previousView = btn;
        
        
    }

    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"改变约束" forState:UIControlStateNormal];\
    [btn addTarget:self action:@selector(changeMas:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(100);
        make.bottom.mas_equalTo(self.view);
    }];
    
    UIView* vieww = [[UIView alloc] init];
    [self.view addSubview:vieww];
    vieww.backgroundColor = [UIColor blueColor];
    
    testView = [[UIView alloc] init];
    [self.view addSubview:testView];
    testView.backgroundColor = [UIColor yellowColor];
    
    
    
    [vieww mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(200);
        
    }];

    [testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(100);
        make.top.mas_equalTo(200);
        make.bottom.mas_equalTo(vieww.mas_bottom).offset(-10.0);
    }];
    
    
    
}

-(void)changeMas:(UIButton*)btn
{
    [self.view layoutIfNeeded];
    step += 2;
    
    showMore = !showMore;
    if (showMore) {
        /* 更新约束的方法 */
        [testView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(250);
        }];
        testView.backgroundColor = [UIColor redColor];
    }
    else {
        [testView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(100);
        }];
        testView.backgroundColor = [UIColor yellowColor];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
