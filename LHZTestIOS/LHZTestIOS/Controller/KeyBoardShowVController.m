//
//  KeyBoardShowVController.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/20.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "KeyBoardShowVController.h"
#import "WirteView.h"
@interface KeyBoardShowVController ()

@property (nonatomic,strong)WirteView* rview;

@end

@implementation KeyBoardShowVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.rview = [[WirteView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64)];
    
    __weak typeof(self)wkSelf = self;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [wkSelf.rview endEditing:YES];
        wkSelf.rview.hidden = YES;
    }];
    [self.rview addGestureRecognizer:tap];
    [self.view addSubview:self.rview];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.rview.hidden = NO;
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
