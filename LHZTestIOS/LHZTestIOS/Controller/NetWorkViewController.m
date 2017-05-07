//
//  NetWorkViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/5.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "NetWorkViewController.h"
#import "LHZHttpManager.h"
#import "LHZDownLoadStore.h"
#import "LHZDownLoadModel.h"
#import "LHZDownLoadOperationManager.h"
#import "LHZDownExampleModel.h"

@interface NetWorkViewController ()

@property (nonatomic,assign)BOOL sucess;

@property (nonatomic,strong)UIImageView* imgV;

@property (nonatomic,strong)UILabel* processLab;

@property (nonatomic,strong)UILabel* processLab1;

@property (nonatomic,strong) LHZURLDownloadSessionTask *sessionTask;

@property (nonatomic,strong) NSURLSessionDownloadTask *task;

@property (nonatomic,strong) NSMutableArray* downLoadModelsArr;

@property (nonatomic,strong) LHZDownExampleModel* model;

@property (nonatomic,strong) LHZDownExampleModel* model1;
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
    
    [self configUI1];
    [self configUI2];
    
    [self requestDataForWeb];
    
    [self downLoadData];
}

#pragma mark --- 参数
-(void)configParams:(id)params
{
    
}

#pragma mark - 网络请求
- (void)requestDataForWeb{
    
    _downLoadModelsArr = [LHZDownLoadOperationManager manager].downLoadModels;
    
 /*
    LHZDownLoadModel* model = [self.downLoadModelsArr firstObject];
    model.progressHandle = ^(NSProgress* progress){
        //NSLog(@"%@",[NSString stringWithFormat:@"文件大小:%@ 已下载:%@ %.2f%@",[LHZDownLoadStore CountBytesBy:progress.totalUnitCount],[LHZDownLoadStore CountBytesBy:progress.completedUnitCount],100.0 * progress.completedUnitCount/progress.totalUnitCount,@"%"]);
    self.processLab.text = [NSString stringWithFormat:@"文件大小:%@ 已下载:%@ %.2f%@",[LHZDownLoadStore CountBytesBy:progress.totalUnitCount],[LHZDownLoadStore CountBytesBy:progress.completedUnitCount],100.0 * progress.completedUnitCount/progress.totalUnitCount,@"%"];
    };
  */
}

-(void)configUI1
{
    self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, Screen_Width, 111)];
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

-(void)configUI2
{
    self.processLab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.processLab.bottom+110, Screen_Width, 100)];
    [self.view addSubview:self.processLab1];
    self.processLab1.textAlignment = NSTextAlignmentCenter;
    self.processLab1.backgroundColor = [UIColor yellowColor];
    self.processLab1.textColor = [UIColor redColor];
    self.processLab1.font = [UIFont systemFontOfSize:15.0];
    
    NSArray* arr = @[@"暂停",@"继续"];
    for (int i = 0; i < arr.count; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(Screen_Width/2.0*i, self.processLab1.bottom, Screen_Width/2.0, 100);
        UIColor* colro = i?[UIColor greenColor]:[UIColor redColor];
        [btn setTitleColor:colro forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark --- 暂停和继续
-(void)btnClick:(UIButton*)sender
{
    if ([sender.currentTitle isEqualToString:@"暂停"]) {
        [[LHZDownLoadOperationManager manager]stopWiethModel:self.model];
    }
    else {
        [[LHZDownLoadOperationManager manager]startWithModel:self.model];
    }
}

-(void)btnClick2:(UIButton*)sender
{
    if ([sender.currentTitle isEqualToString:@"暂停"]) {
        [[LHZDownLoadOperationManager manager]stopWiethModel:self.model1];
        }
    else {
        [[LHZDownLoadOperationManager manager]startWithModel:self.model1];
    }
}

-(void)actionWith:(LHZDownExampleModel*)model
{
    LHZDownLoadOperationManager* manger = [LHZDownLoadOperationManager manager];
    switch (model.state) {
        case LHZDownloadStateNone:
        case LHZDownloadStateFailed:
        case LHZDownloadStateSuspended:
            [manger startWithModel:model];
            break;
        case LHZDownloadStateWaiting:
        case LHZDownloadStateRunning:
            [manger stopWiethModel:model];
            break;
        case LHZDownloadStateCompleted:
            //@"下载完成";
            break;
            
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [self.sessionTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
//        [LHZDownLoadStore saveResumeData:resumeData WithKey:@"https://dzj-shared.oss-cn-shanghai.aliyuncs.com/video/%E5%A4%A7%E4%B8%93%E5%AE%B6.COM%E4%BB%8B%E7%BB%8D%E7%89%87118.mp4"];
//    }];
    //[LHZDownLoadStore saveModels:self.downLoadModelsArr];
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
    //NSString* urlStr = @"https://dzj-shared.oss-cn-shanghai.aliyuncs.com/video/%E5%A4%A7%E4%B8%93%E5%AE%B6.COM%E4%BB%8B%E7%BB%8D%E7%89%87118.mp4";
    
    //@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g4/M01/0D/04/Cg-4WVP_npmIY6GRAKcKYPPMR3wAAQ8LgNIuTMApwp4015.jpg";
    
    //https://dzj-shared.oss-cn-shanghai.aliyuncs.com/video/%E6%88%91%E6%98%AF%E5%8C%BB%E7%94%9F%E2%80%94%E2%80%94%E9%92%9F%E5%8D%97%E5%B1%B1%C2%B7%E5%8C%BB%E8%80%85%E4%BB%81%E5%BF%83.mp4
    
    self.model = [self.downLoadModelsArr firstObject];
    
    NSProgress* progress11 = self.model.progress;
    self.processLab.text = [NSString stringWithFormat:@"文件大小:%@ 已下载:%@ %.2f%@",[LHZDownLoadStore CountBytesBy:progress11.totalUnitCount],[LHZDownLoadStore CountBytesBy:progress11.completedUnitCount],100.0 * progress11.completedUnitCount/progress11.totalUnitCount,@"%"];

    __weak typeof(self) wkSelf = self;

    [self.model setProgressHandle:^(NSProgress* progress) {
         wkSelf.processLab.text = [NSString stringWithFormat:@"文件大小:%@ 已下载:%@ %.2f%@",[LHZDownLoadStore CountBytesBy:progress.totalUnitCount],[LHZDownLoadStore CountBytesBy:progress.completedUnitCount],100.0 * progress.completedUnitCount/progress.totalUnitCount,@"%"];
    }];
    [self.model setStateChangeHandle:^(LHZDownloadState state) {
     
    }];
    
    switch (self.model.state) {
        case LHZDownloadStateNone:
        case LHZDownloadStateFailed:
        case LHZDownloadStateSuspended:
            [[LHZDownLoadOperationManager manager]stopWiethModel:self.model];
            break;
        case LHZDownloadStateWaiting:
        case LHZDownloadStateRunning:
            [[LHZDownLoadOperationManager manager] startWithModel:self.model];
            break;
        case LHZDownloadStateCompleted:
            //@"下载完成";
            break;
            
    }

    
    
    
    self.model1 = [self.downLoadModelsArr lastObject];
 
    NSProgress* progress1 = self.model1.progress;
    self.processLab1.text = [NSString stringWithFormat:@"文件大小:%@ 已下载:%@ %.2f%@",[LHZDownLoadStore CountBytesBy:progress1.totalUnitCount],[LHZDownLoadStore CountBytesBy:progress1.completedUnitCount],100.0 * progress1.completedUnitCount/progress1.totalUnitCount,@"%"];
    
    [self.model1 setProgressHandle:^(NSProgress* progress) {
        wkSelf.processLab1.text = [NSString stringWithFormat:@"文件大小:%@ 已下载:%@ %.2f%@",[LHZDownLoadStore CountBytesBy:progress.totalUnitCount],[LHZDownLoadStore CountBytesBy:progress.completedUnitCount],100.0 * progress.completedUnitCount/progress.totalUnitCount,@"%"];
    }];
    [self.model1 setStateChangeHandle:^(LHZDownloadState state) {
        
    }];
    
    switch (self.model1.state) {
        case LHZDownloadStateNone:
        case LHZDownloadStateFailed:
        case LHZDownloadStateSuspended:
            [[LHZDownLoadOperationManager manager]stopWiethModel:self.model1];
            break;
        case LHZDownloadStateWaiting:
        case LHZDownloadStateRunning:
            [[LHZDownLoadOperationManager manager] startWithModel:self.model1];
            break;
        case LHZDownloadStateCompleted:
            //@"下载完成";
            break;
            
    }
    
    
//    self.sessionTask = [[LHZHttpManager shareManager] downLoadWithUrl:urlStr parameters:nil progress:^(NSProgress *progress) {
//        
//        NSLog(@"%@",[NSString stringWithFormat:@"进度==%.2f",1.0 * progress.completedUnitCount/progress.totalUnitCount]);
//        
//        wkSelf.processLab.text = [NSString stringWithFormat:@"文件大小:%@ 已下载:%@ %.2f%@",[LHZDownLoadStore CountBytesBy:progress.totalUnitCount],[LHZDownLoadStore CountBytesBy:progress.completedUnitCount],100.0 * progress.completedUnitCount/progress.totalUnitCount,@"%"];
//        
//    } completion:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        
////        NSString *imgFilePath = [filePath path];// 将NSURL转成NSString
////        UIImage *img = [UIImage imageWithContentsOfFile:imgFilePath];
////        wkSelf.imgV.image = img;
//
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

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NetWorkViewController* vc = [[NetWorkViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//}


-(void)dealloc
{
    NSLog(@"dealloc");
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
