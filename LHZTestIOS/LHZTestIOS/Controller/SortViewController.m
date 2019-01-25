//
//  SortViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/6/21.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "SortViewController.h"

@interface SortViewController ()

@end

#define  Array_Len(array)   (sizeof(array) / sizeof(array[0]))

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    int dataArr[] = {7, 8, 8, 9, 5, 16, 5, 3, 56, 21, 34, 15, 42};
    bubble_sort(dataArr);
   
}

#pragma mark --- 冒泡排序
void bubble_sort(int a[]) {
    int size = sizeof(a) / sizeof(int);
    for (int i = 0; i < size; i++) {
        for (int j = i; j < size-i; j++) {
            if (a[i] > a[j]) {
                int temp;
                temp = a[i];
                a[j] = a[i];
                a[i] = temp;
            }
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
