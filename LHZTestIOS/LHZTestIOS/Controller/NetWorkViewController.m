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

@property (nonatomic,strong)UIImageView* imgV;

@property (nonatomic,strong)UILabel* processLab;

@property (nonatomic,strong) LHZURLSessionTask *sessionTask;

@property (nonatomic,strong) NSURLSessionDownloadTask *task;

@end

@implementation NetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%d",calut(5));
//    NSString *minutes;
//    @try{
//        minutes = [@"1223333333" substringFromIndex:14];
//        NSLog(@"%@",minutes);
//    }@catch (NSException * e) {
//        NSLog(@"Exception: %@", e);
//    }@finally {
//        // 结果处理
//        minutes = @"122";
//    }
//    NSLog(@"=======%@",minutes);
    
//    __weak __block void (^blocks)(int);
//    blocks = ^(int i){
//        if(i > 0){
//            NSLog(@"%d===Hello, world!",i);
//            blocks(i - 1);
//        }
//    };
//    blocks(calut(2));
    
    //[self requestWeather];
    
    [self configUI];
    
    [self downLoadData];
}

-(void)configUI
{
    self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 111, Screen_Width, 111)];
    [self.view addSubview:self.imgV];
    
    self.processLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgV.bottom, Screen_Width, 100)];
    [self.view addSubview:self.processLab];
    self.processLab.textAlignment = NSTextAlignmentCenter;
    self.processLab.backgroundColor = [UIColor yellowColor];
    self.processLab.textColor = [UIColor redColor];
    self.processLab.font = [UIFont systemFontOfSize:15.0];
    
    NSArray* arr = @[@"暂停",@"继续"];
    for (int i = 0; i < arr.count; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(Screen_Width/2.0*i, self.processLab.bottom, Screen_Width/2.0, 100);
        UIColor* colro = i?[UIColor greenColor]:[UIColor redColor];
        [btn setTitleColor:colro forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark --- 暂停和继续
-(void)btnClick:(UIButton*)sender
{
    if ([sender.currentTitle isEqualToString:@"暂停"]) {
        [self.sessionTask suspend];
    }
    else {
        [self.sessionTask resume];
    }
}

#pragma mark --- GET方法
-(void)httpGetData
{
    /* 拼接的链接包含中文的 一定要转码 否则直接崩 */
    NSString *gdPath = [[NSString stringWithFormat:@"https://restapi.amap.com/v3/weather/weatherInfo?key=b74b13cfc2842d5c5a397e752ee764e1&extensions=base&city=%@",@"武汉"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
    
//    NSDictionary* params = @{@"key":@"b74b13cfc2842d5c5a397e752ee764e1",
//                             @"extensions":@"base",
//                             @"city":@"武汉"};

    [[LHZHttpManager shareManager] GET:gdPath parameters:nil completion:^(id response, NSError *anError) {
        
    }];
    
//    [[LHZHttpManager shareManager] GET:@"/v3/weather/weatherInfo" parameters:params completion:^(NSURLSessionDataTask *task, id JSON, NSError *anError) {
    
//    }];
}


#pragma mark --- 下载方法
-(void)downLoadData
{
    NSString* urlStr = @"http://desk.fd.zol-img.com.cn/t_s960x600c5/g4/M01/0D/04/Cg-4WVP_npmIY6GRAKcKYPPMR3wAAQ8LgNIuTMApwp4015.jpg";
    NSString* pathName = [[urlStr componentsSeparatedByString:@"/"] lastObject];
    NSString *path=[NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@",pathName]];

    __weak typeof(self)wkSelf = self;
    self.sessionTask = [[LHZHttpManager manager]breakpointResume:YES downLoadWithUrl:urlStr parameters:nil saveToPath:path progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
        NSLog(@"%@",[NSString stringWithFormat:@"进度==%.2f",1.0 * bytesProgress/totalBytesProgress]);
        
        NSLog(@"totalBytesProgress:%lld",totalBytesProgress);
        
        /* 必须:主线程更新UI */
        dispatch_async(dispatch_get_main_queue(), ^{
            wkSelf.processLab.text = [NSString stringWithFormat:@"%.2f",1.0 *bytesProgress/totalBytesProgress];
        });
        
    } completion:^(id response, NSError *anError) {
        NSString *imgFilePath = [response path];// 将NSURL转成NSString
        UIImage *img = [UIImage imageWithContentsOfFile:imgFilePath];
        wkSelf.imgV.image = img;
    }];
    
    [self.sessionTask resume];
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

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NetWorkViewController* vc = [[NetWorkViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//}


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
