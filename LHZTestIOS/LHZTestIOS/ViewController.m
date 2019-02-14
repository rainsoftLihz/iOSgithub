//
//  ViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/22.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//


#import "ViewController.h"

#import "ASDisplayVController.h"

#import "TTTViewController.h"

#import "JZTOpenVController.h"

#import "MoreMoveController.h"

#import <netdb.h>

#import <sys/socket.h>

#import "LHZViewController.h"

#import "ChartViewController.h"

#import "PropertyTestViewController.h"

#import "SocketViewController.h"

#import "TitleViewController.h"

#import "WeakAndStrongViewController.h"

#import "MasonryViewController.h"

#import "CoreDataViewcontroller.h"

#import "TableRefreshViewController.h"

#import "ShoppingViewController.h"

#import "MutilThreadVC.h"

#import "CoreAnimationVC.h"

#import "NetWorkViewController.h"

#import "UITestViewController.h"

#import "KeyBoardShowVController.h"

#import "BlueViewController.h"

#import "JZTTabBarVC.h"

#import "BiaoChiViewController.h"

#import "UIDynamicViewController.h"

#import "LHZDownLoadOperationManager.h"

#import "LHZDownLoadModel.h"

#import "IMGShowViewControlle.h"

#import "LHZDownLoadStore.h"

#import "LHZDownExampleModel.h"

#import "PageAnnimaionVC.h"

#import "UserInfoModel.h"

#import "CollectionViewController.h"

#import "GCDViewController.h"

#import "JZTPickViewController.h"

#import "StepViewController.h"

#import <sys/utsname.h>

#import "MVVMViewController.h"

#import "RunTimeVController.h"

#import "SDCycleScrollView.h"
#import "CrashLogVC.h"

#import "BlockViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UICollectionView* collectionView;

@property (nonatomic,strong)UITableView* tableView;

@property (nonatomic,strong)NSArray* titleArr;

@property (nonatomic,strong)NSArray* pushVcArr;

@property (nonatomic,strong)UIImageView* barImageView;

@property (nonatomic,strong)NSString* testStr;

@property (nonatomic,strong)SDCycleScrollView* scrollView;

@property (nonatomic,strong)NSArray* imgArr;

@property (nonatomic,strong)UIImageView* bkImageView;

@end

typedef NSString* (^kBlock)(NSString*);

typedef NS_ENUM(NSInteger,kBlockType){
    
    kBlockTypeString
    
};

typedef enum {
    
    kTypeShow
    
}kType;

typedef NS_ENUM(NSUInteger, JZTResponseStatus) {
    JZTResponseStatusSuccess = 0
};

@implementation ViewController
@synthesize myStr = _myStr;

-(void)setMyStr:(NSString*)myStr{
    _myStr = myStr;
}

-(NSString*)myStr{
    return @"111";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.myStr = @"222";
    NSLog(@"=====>%@",self.myStr);
    NSLog(@"=====>%@",_myStr);
    
//    NSMutableArray* nameArr = [[NSMutableArray array] copy];
//    [nameArr addObject:@"123"];
    
    NSString *webPath = [[NSBundle mainBundle] pathForResource:@"AAChartView.html" ofType:nil];
    
    NSDictionary* dic = @{@"hh":@"kk"};
    NSLog(@"object:%@",[dic objectForKey:@"111"]);
    NSLog(@"value:%@",[dic valueForKey:@"111"]);
    NSLog(@"object:%@",[dic objectForKey:@"hh"]);
    NSLog(@"value:%@",[dic valueForKey:@"hh"]);
    
    NSLog(@"@key:%@",dic[@"111"][@"333"]);
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"IOS";
    
    for (int i = 0 ; i < 10 ; i++) {
        NSLog(@"fibonacci(%d)=%d",i,fib(i));
    }
    
    JZTResponseStatus state = 3;
    NSLog(@"====%ld",state);
    NSString* timeStr;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStr.longLongValue/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"YYYY-MM-dd";
    //[formatter stringFromDate:date];
    NSLog(@"===%@",[formatter stringFromDate:date]);
    //NSLog(@"网络类型:%@",[self networkType]);

    //[self fileTest];
    
    //[self testDownLoad];

    //[self imgClick];
    
    //NSLog(@"%d",[self respondsToSelector:@selector(tableView: didSelectRowAtIndexPath:)]);
    
//    NSString* teSt = @"";
//    if (teSt.length) {
//        NSLog(@"======  lenth =======");
//    }
//    
//    NSArray* arr ;
//    
//    NSLog(@"======  %@ =======",arr[1]);
//    
//    [self testMJ];
    
    //NSRunLoop runLoop = [NSRunLoop r];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        /* 异步请求数据 */
        NSLog(@"异步请求数据");
        
        //[self testSocket];
        
       
    });

}

#pragma mark --- socket
-(void)testSocket {
    NSString* host = @"10.2.158.90";
    int port  = 9090;
    
    //创建socket
    int sockerTileDes = socket(AF_INET, SOCK_STREAM, 0);
    if (-1 == sockerTileDes) {
        NSLog(@"创建失败...");
        return;
    }
    
    //获取ip地址
    struct hostent* remoteHost = gethostbyname([host UTF8String]);
    if (NULL == remoteHost) {
        NSLog(@"无法解析服务器主机名");
        return;
    }
    
    struct in_addr * remoteAddr = (struct in_addr *)remoteHost->h_addr_list[0];
    
    //设置socket参数
    struct sockaddr_in socketParameters;
    socketParameters.sin_family = AF_INET;
    socketParameters.sin_addr = *remoteAddr;
    socketParameters.sin_port = htons(port);
    
    //连接socket
    int ret = connect(sockerTileDes, (struct sockaddr *) &socketParameters, sizeof(socketParameters));
    if (-1 == ret) {
        close(sockerTileDes);
        
        NSString * errorInfo = [NSString stringWithFormat:@" >> Failed to connect to %@:%d", host, port];
        
        return;
    }
    
    //接受数据
    NSMutableData * data = [[NSMutableData alloc] init];
    BOOL waitingForData = YES;
    
    
    
    // Continually receive data until we reach the end of the data
    //
    int maxCount = 5;
    int i = 0;
    while (waitingForData && i < maxCount) {
        const char * buffer[1024];
        int length = sizeof(buffer);
        
        // Read a buffer's amount of data from the socket; the number of bytes read is returned
        //
        int result = recv(sockerTileDes, &buffer, length, 0);
        if (result > 0) {
            [data appendBytes:buffer length:result];
        }
        else {
            // if we didn't get any data, stop the receive loop
            //
            waitingForData = NO;
        }
        
        ++i;
    }
    
    close(sockerTileDes);
    
    NSString * resultsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@" >> Received string: '%@'", resultsString);
}


#pragma mark --- 递归
int fib(int n)
{
    if (n == 0) {
        return 1;
    }
    if (n == 1) {
        return 2;
    }
    return fib(n-2)+fib(n-1);
}




-(NSString *)testStr
{
    if (_testStr) {
        return _testStr;
    }
    return @"test";
}

#pragma mark --- TEST MJ
-(void)testMJ
{
    NSDictionary *dict = @{
                           @"name" : @"Jack",
                           @"icon" : @"lufy.png",
                           @"age" : @20,
                           @"height" : @"1.55",
                           @"money" : @100.9,
                           @"sex" : @(SexFemale)
                           };
    
    NSArray *userPersonArray = @[
                           @{
                               @"name" : @"Jack",
                               @"icon" : @"lufy.png",
                               @"age" : @20,
                               @"height" : @"1.35",
                               @"money" : @60.9,
                               @"sex" : @(SexFemale)
                               },
                           @{
                               @"name" : @"Rose",
                               @"icon" : @"nami.png",
                               @"age" : @21,
                               @"height" : @"1.55",
                               @"money" : @100.9,
                               @"sex" : @(SexFemale)
                               }
                           ];
    
    NSDictionary* userdict = @{ @"user":dict,
                                
                               @"money":@"1111",
                                
                                @"userArr":userPersonArray
                               };
    
    /**
     
     字典转模型
     
    */
    
    UserInfoModel* model = [UserInfoModel mj_objectWithKeyValues:userdict];
    
    
    UserPerson* info = [UserPerson mj_objectWithKeyValues:dict];
    
    
    /**
     
     模型转为字典
    */
    
    NSDictionary *userDict = [info mj_keyValues];
    
    NSDictionary* userModelDic = [model mj_keyValues];
    
    /**
     
     数组转模型
     
    */
    
    NSArray *dictArray = @[
                           @{
                               @"name" : @"Jack",
                               @"icon" : @"lufy.png",
                               @"age" : @20,
                               @"height" : @"1.35",
                               @"money" : @60.9,
                               @"sex" : @(SexFemale)
                               },
                           @{
                               @"name" : @"Rose",
                               @"icon" : @"nami.png",
                               @"age" : @21,
                               @"height" : @"1.55",
                               @"money" : @100.9,
                               @"sex" : @(SexFemale)
                               }
                           ];
    
    NSArray* modelArr = [UserPerson mj_objectArrayWithKeyValuesArray:dictArray];
    for (UserPerson* person in modelArr) {
        NSLog(@"%@",[person yy_modelDescription]);
    }
}



#pragma mark --- TEST CODE
-(void)testCode
{
    
    kBlock block = ^(NSString* str){
        NSLog(@"+++%@++++++",str);
        return str;
    };
    
    NSString* str = block(@"TTTTT");
    
    NSLog(@"+++%@+++",str);
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *date1 = [dateformatter stringFromDate:[NSDate date]];
    NSLog(@"获取当前时间 = %@",date1);
    
    /*
     1个1个拿，正好拿完。
     2个2个拿，还剩1个。
     3个3个拿，正好拿完。
     4个4个拿，还剩1个。
     5个5个拿，还剩4个。
     6个6个拿，还剩3个。
     7个7个拿，正好拿完。
     8个8个拿，还剩1个。
     9个9个拿，正好拿完。
     问筐里有多少鸡蛋？(请手写代码并列出第一个值是多少)
     */
    for (int i = 0; i < 10000; i++) {
        if (i%2 == 1 && i%3 == 0 && i%4 == 1 && i%5 == 4 && i%6 == 3 && i%7 == 0 && i%8 == 1 && i%9 == 0 ) {
            NSLog(@"============%d",i);
        }
    }
    
    
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]*1000];
    
    NSLog(@"date2====%ld",(long)[[NSDate date] timeIntervalSince1970]);
    
    //NSAssert([num integerValue],@"num不能为空");
    NSString* testStr = @"";
    NSLog(@"%@",testStr);
    NSLog(@"%ld",testStr.length);
    if (testStr) {
        NSLog(@"======testStr======");
    }
    self.testStr = @"=======hehe========";
    NSLog(@"%@",self.testStr);
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    NSNumber* track = [NSNumber numberWithInteger:0];
//    NSNumber* track1 = nil;
//    if (track) {
//      NSLog(@"==track有==");
//    }
//    else NSLog(@"==track无==");
//    
//    if (track1) {
//        NSLog(@"==track1有==");
//    }
//    else NSLog(@"==track1无==");
//    
//    [[NSUserDefaults standardUserDefaults]setObject:track1 forKey:@"111"];
//    
//    NSLog(@"====%d",track.boolValue);
//    
//    NSNumber* track11 = [[NSUserDefaults standardUserDefaults] objectForKey:@"111"];
//    NSLog(@"track1===%d",track11.boolValue);
//}

#pragma mark --- view的点击时间
-(void)imgClick
{
    UIView* viee = [[UIView alloc] init];
    viee.backgroundColor = [UIColor redColor];
    [self.view addSubview:viee];
    
    
    [viee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view);
    }];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewCilck:)];
    viee.userInteractionEnabled = YES;
    [viee addGestureRecognizer:tap];
}

-(void)viewCilck:(UITapGestureRecognizer*)tap
{
    NSLog(@"=====viewCilck=====");
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //NSMutableArray* arr = [LHZDownLoadOperationManager manager].downLoadModels;

    //[[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"设备类型 %@",[self iphoneType]] message:[NSString stringWithFormat:@"网络类型 %@",[self networkType]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
    
}

- (NSString *)iphoneType {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    return @"iphone";
    
}

#pragma mark --- 获取当前网络类型
-(NSString*)networkType
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state =  @"2G";
                    break;
                case 2:
                    state =  @"3G";
                    break;
                case 3:
                    state =   @"4G";
                    break;
                case 5:
                {
                    state =  @"wifi";
                    break;
                default:
                    break;
                }
            }
            //根据状态选择
            return state;
        }
        
    }
    return @"无网络";
}

#pragma mark ---- TEST DOWNLOAD
-(void)testDownLoad
{
    LHZDownExampleModel* model = [[LHZDownExampleModel alloc] init];
    model.downloadURL = @"https://dzj-shared.oss-cn-shanghai.aliyuncs.com/video/%E5%A4%A7%E4%B8%93%E5%AE%B6.COM%E4%BB%8B%E7%BB%8D%E7%89%87118.mp4";
    
    LHZDownExampleModel* model1 = [[LHZDownExampleModel alloc] init];
    model1.downloadURL = @"https://dzj-shared.oss-cn-shanghai.aliyuncs.com/video/%E6%88%91%E6%98%AF%E5%8C%BB%E7%94%9F%E2%80%94%E2%80%94%E9%92%9F%E5%8D%97%E5%B1%B1%C2%B7%E5%8C%BB%E8%80%85%E4%BB%81%E5%BF%83.mp4";
    
    [LHZDownLoadOperationManager manager].downLoadModels = [NSMutableArray arrayWithArray:@[model,model1]];
    
    [LHZDownLoadStore saveModels:@[model,model1]];
   
}

#pragma mark --- 正则表达式
-(void)regularTest
{
    NSMutableString *url = [@"https://test-m.998pz.cn/view/index.html?ch=1&par=5&userId=10000000000@qq.com" mutableCopy];
    
    //NSLog(@"%@",[self lz_OriginUrl:url StringdeleteParameter:@"userId"]);
    
    NSError *error;
    // 创建NSRegularExpression对象并指定正则表达式
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"userId=[\\w@\\.]*&*"
                                  options:0
                                  error:&error];
    if (!error) { // 如果没有错误
        // 获取特特定字符串的范围
        NSTextCheckingResult *match = [regex firstMatchInString:url
                                                        options:0 range:NSMakeRange(0, [url length])];
        if (match) {
            // 截获特定的字符串
            NSString *result = [url substringWithRange:match.range];
            NSLog(@"result====%@",result);
            [url deleteCharactersInRange:match.range];
            NSLog(@"url=====%@",url);
        }
        
        
    }
}

#pragma mark --- 文件名获取
-(void)fileTest
{
    NSString *filePath = @"http://www.baidu.com/img/baidu_logo_fqj_10.gif";
    
    //从路径中获得完整的文件名（带后缀）
    NSString* exestr = [filePath lastPathComponent];
    NSLog(@"lastPathComponent:%@",exestr);
    
    //获得文件名（不带后缀）
    exestr = [exestr stringByDeletingPathExtension];
    NSLog(@"stringByDeletingPathExtension:%@",exestr);
    
    //获得文件的后缀名（不带'.'）
    exestr = [filePath pathExtension];
    NSLog(@"pathExtension:%@",exestr);
}

#pragma mark --- 初始化
-(NSArray *)titleArr{
    return @[@"Blcok",@"Runtime",@"MVVM",@"GCD测试",@"ASDisplay测试",@"展开收起",@"多级联动",@"图片选择",@"图表",@"VC跳转",@"socket长连接",@"计步器注入",@"崩溃日志分析",@"标题视图",@"CC",@"CollectionView",@"分页效果",@"动力行为",@"property属性",@"weak与strong",@"Mansory约束",@"coreData",@"下拉刷新",@"多线程",@"Core Animation",@"购物车",@"网络加载",@"UI细节处理+视图拖拽",@"键盘弹出动画",@"蓝牙连接",@"TabBar",@"标尺"];
}

-(NSArray *)pushVcArr
{
    return @[[BlockViewController class],
             [RunTimeVController class],
             [MVVMViewController class],
             [GCDViewController class],
             [ASDisplayVController class],
             [JZTOpenVController class],
             [MoreMoveController class],
             [JZTPickViewController class],
             [ChartViewController class],
             [LHZViewController class],
             [SocketViewController class],
             [StepViewController class],
             [CrashLogVC class],
             [TitleViewController class],
             [IMGShowViewControlle class],
             [CollectionViewController class],
             [PageAnnimaionVC class],
             [UIDynamicViewController class],
             [UITestViewController class],
             [WeakAndStrongViewController class],
             [MasonryViewController class],
             [CoreDataViewcontroller class],
             [TableRefreshViewController class],
             [MutilThreadVC class],
             [CoreAnimationVC class],
             [ShoppingViewController class],
             [NetWorkViewController class],
             [UITestViewController class],
             [KeyBoardShowVController class],
             [BlueViewController class],
             [JZTLHZTabBarVController class],
             [BiaoChiViewController class]];
}

#pragma mark ---  tableView
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, Screen_Height-STATUS_BAR_HEIGHT - 44 ) style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = YES;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}


#pragma mark --- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark ----UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString* str = self.titleArr[indexPath.row];
    
    if ([str isEqualToString:@"TabBar"]) {
        JZTLHZTabBarVController* vc = [[JZTLHZTabBarVController alloc] init];
        //[vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
          /* 动画 */
//        CATransition *animation = [CATransition animation];
//        animation.duration = 1.0;
//        animation.timingFunction = UIViewAnimationCurveEaseInOut;
//        animation.type = @"rippleEffect";
////        animation.type = kCATransitionMoveIn;
//        //animation.subtype = kCATransitionFromRight;
//        [self.view.window.layer addAnimation:animation forKey:nil];
//        [self presentViewController:vc animated:NO completion:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    MyBaseViewController* vc = [[self.pushVcArr[indexPath.row] alloc] init];
    
    vc.titleStr = self.titleArr[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark --- 等比压缩图片
+(UIImage *)compressImageWith:(UIImage *)image
{
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = 320;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)lz_OriginUrl:(NSString*)originUrl StringdeleteParameter:(NSString *)parameter;{
    NSString *finalStr = @"";
    NSMutableString * mutStr = originUrl.mutableCopy;
    NSArray *strArray = [mutStr componentsSeparatedByString:parameter];
    NSMutableString *firstStr = [strArray firstObject];
    NSMutableString *lastStr = [strArray lastObject];
    NSRange characterRange = [lastStr rangeOfString:@"&"];
    if (characterRange.location != NSNotFound) {
        NSArray *lastArray = [lastStr componentsSeparatedByString:@"&"];
        NSMutableArray *mutArray = lastArray.mutableCopy;
        [mutArray removeObjectAtIndex:0];
        NSString *modifiedStr = [mutArray componentsJoinedByString:@"&"];
        finalStr = [firstStr stringByAppendingString:modifiedStr];
    } else {
        //以'?'、'&'结尾
        finalStr = [firstStr substringToIndex:[firstStr length] -1];
    }
    return finalStr;
}

@end
