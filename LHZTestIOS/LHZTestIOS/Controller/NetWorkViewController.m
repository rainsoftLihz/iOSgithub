//
//  NetWorkViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "NetWorkViewController.h"
#import "LHZHttpManager.h"
@interface NetWorkViewController ()

@property (nonatomic,assign)BOOL sucess;

@end

@implementation NetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%d",calut(5));
    NSString *minutes;
    @try{
        minutes = [@"1223333333" substringFromIndex:14];
        NSLog(@"%@",minutes);
    }@catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }@finally {
        // 结果处理
        minutes = @"122";
    }
    NSLog(@"=======%@",minutes);
    
    __weak __block void (^blocks)(int);
    blocks = ^(int i){
        if(i > 0){
            NSLog(@"%d===Hello, world!",i);
            blocks(i - 1);
        }
    };
    blocks(calut(2));
    
    [self requestWeather];
}

-(void)requestWeather
{
    /* 拼接的链接包含中文的 一定要转码 否则直接崩 */
    NSString *gdPath = [[NSString stringWithFormat:@"https://restapi.amap.com/v3/weather/weatherInfo?key=b74b13cfc2842d5c5a397e752ee764e1&extensions=base&city=%@",@"武汉"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
    
//    NSDictionary* params = @{@"key":@"b74b13cfc2842d5c5a397e752ee764e1",
//                             @"extensions":@"base",
//                             @"city":@"武汉"};

    [[LHZHttpManager shareManager] GET:gdPath parameters:nil completion:^(NSURLSessionDataTask *task, id JSON, NSError *anError) {
        
    }];
    
//    [[LHZHttpManager shareManager] GET:@"/v3/weather/weatherInfo" parameters:params completion:^(NSURLSessionDataTask *task, id JSON, NSError *anError) {
//        
//        
//        
//        if (anError) {
//            /*  请求失败时候 重复请求 */
//            //[self requestWeather];
//        }
//    }];
}

#pragma mark --- 递归
/**
 5*4*3*2*1
**/

int calut(int x){
    if (x == 1 || x == 2) {
        return x;
    }

    return x*calut(x-1);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NetWorkViewController* vc = [[NetWorkViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)dealloc
{
    
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
