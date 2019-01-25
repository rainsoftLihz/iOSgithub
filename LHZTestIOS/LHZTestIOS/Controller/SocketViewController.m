//
//  SocketViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/11/1.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "SocketViewController.h"

#import <CocoaAsyncSocket/GCDAsyncSocket.h>

#import <CocoaAsyncSocket/GCDAsyncUdpSocket.h>


@interface SocketViewController ()<GCDAsyncSocketDelegate,GCDAsyncUdpSocketDelegate>

// 客户端socket
@property (strong, nonatomic) GCDAsyncSocket *clientSocket;

// 主机
@property (strong, nonatomic)  UITextField *addressTextF;
// 端口号
@property (strong, nonatomic)  UITextField *portTextF;
// 信息展示
@property (strong, nonatomic)  UITextField *messageTextF;
// 信息展示
@property (strong, nonatomic)  UITextView *showMessageTextV;
@property (nonatomic, assign) BOOL connected;

// 计时器
@property (nonatomic, strong) NSTimer *connectTimer;

@end

@implementation SocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configUI];
    
    
}

// 添加计时器
- (void)addTimer
{
    // 长连接定时器
    self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];
    // 把定时器添加到当前运行循环,并且调为通用模式
    [[NSRunLoop currentRunLoop] addTimer:self.connectTimer forMode:NSRunLoopCommonModes];
}


// 心跳连接
- (void)longConnectToSocket
{
    // 发送固定格式的数据,指令@"longConnect"
    float version = [[UIDevice currentDevice] systemVersion].floatValue;
    int arcNum = arc4random_uniform(2388238);
    NSString *longConnect = [NSString stringWithFormat:@"===%d:%f",arcNum,version];
    
    NSData  *data = [longConnect dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"重复执行%d",arcNum);
    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
}

/**
 连接主机对应端口号
 
 @param sock 客户端socket
 @param host 主机
 @param port 端口号
 */
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"链接成功");
    [self showMessageWithStr:@"链接成功"];
    [self showMessageWithStr:[NSString stringWithFormat:@"服务器IP: %@-------端口: %d", host,port]];
    
    // 连上马上发一条信息给服务器
    //    float version = [[UIDevice currentDevice] systemVersion].floatValue;
    //    NSString *firstMes = [NSString stringWithFormat:@"123%f",version];
    //    NSData  *data = [firstMes dataUsingEncoding:NSUTF8StringEncoding];
    //    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
    
    // 连接成功开启定时器
    [self addTimer];
    // 连接后,可读取服务器端的数据
    [self.clientSocket readDataWithTimeout:- 1 tag:0];
    self.connected = YES;
}

/**
 读取数据
 
 @param sock 客户端socket
 @param data 读取到的数据
 @param tag 当前读取的标记
 */
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [self showMessageWithStr:text];
    
    // 读取到服务器数据值后,能再次读取
    [self.clientSocket readDataWithTimeout:- 1 tag:0];
}


// 信息展示
- (void)showMessageWithStr:(NSString *)str
{
    self.showMessageTextV.text = [self.showMessageTextV.text stringByAppendingFormat:@"%@\n", str];
}

/**
 客户端socket断开
 
 @param sock 客户端socket
 @param err 错误描述
 */
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    //    NSLog(@"断开的sock:%@",sock);
    NSLog(@"断开的sock:%@",self.clientSocket);
    NSLog(@"断开原因:%@",[err localizedDescription]);
    [self showMessageWithStr:@"断开连接"];
    self.clientSocket.delegate = nil;
    //    [self.clientSocket disconnect];
    self.clientSocket = nil;
    self.connected = NO;
    [self.connectTimer invalidate];
}

-(void)configUI
{
    UILabel* addrLab = [self createLabWith:@"IP地址:"];
    self.addressTextF = [self createTextF];
    self.addressTextF.text = @"10.2.158.90";
    UILabel* portLab = [self createLabWith:@"端口号:"];
    self.portTextF = [self createTextF];
    self.portTextF.text = @"9090";
    UILabel* sendTextLab = [self createLabWith:@"发送消息:"];
    self.messageTextF = [self createTextF];
    UILabel* receivedTextLab = [self createLabWith:@"接受消息:"];
    self.showMessageTextV = [[UITextView alloc] init];
    self.showMessageTextV.textColor = [UIColor redColor];
    self.showMessageTextV.layer.borderWidth = 1.0;
    self.showMessageTextV.layer.borderColor = [UIColor blackColor].CGColor;
    self.showMessageTextV.layer.cornerRadius = 1.0;
    self.showMessageTextV.layer.masksToBounds = YES;
    self.showMessageTextV.editable = NO;
    
    [self.view addSubview:addrLab];
    [self.view addSubview:self.addressTextF];
    [self.view addSubview:portLab];
    [self.view addSubview:self.portTextF];
    [self.view addSubview:sendTextLab];
    [self.view addSubview:self.messageTextF];
    [self.view addSubview:receivedTextLab];
    [self.view addSubview:self.showMessageTextV];
    
    [addrLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(60);
    }];
    
    [self.addressTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addrLab.mas_right).offset(5.0);
        make.top.and.bottom.mas_equalTo(addrLab);
        make.right.mas_equalTo(self.view.mas_right).offset(-20.0);
    }];
    
    [portLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(addrLab.mas_bottom).offset(10.0);
        make.left.and.right.mas_equalTo(addrLab);
        make.height.mas_equalTo(addrLab);
    }];
    
    [self.portTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(portLab);
        make.right.mas_equalTo(self.view.mas_right).offset(-20.0);
        make.left.mas_equalTo(addrLab.mas_right).offset(5.0);
    }];
    
    [sendTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(portLab.mas_bottom).offset(20.0);
        make.left.and.right.mas_equalTo(addrLab);
        make.height.mas_equalTo(addrLab);
    }];
    
    [self.messageTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(portLab.mas_bottom).offset(20.0);
        make.right.mas_equalTo(self.view.mas_right).offset(-20.0);
        make.left.mas_equalTo(sendTextLab.mas_right).offset(5.0);
    }];
    
    [receivedTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sendTextLab.mas_bottom).offset(20.0);
        make.left.and.right.mas_equalTo(addrLab);
        make.height.mas_equalTo(addrLab);
    }];
    
    [self.showMessageTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sendTextLab.mas_bottom).offset(20.0);
        make.right.mas_equalTo(self.view.mas_right).offset(-20.0);
        make.left.mas_equalTo(sendTextLab.mas_right).offset(5.0);
        make.height.mas_equalTo(100);
    }];
    
    
    UIButton* sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn addTarget:self action:@selector(goToConnect) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    sendBtn.titleLabel.textColor = [UIColor redColor];
    sendBtn.backgroundColor = [UIColor yellowColor];
    [sendBtn setTitle:@"连接" forState:UIControlStateNormal];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.showMessageTextV.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.mas_equalTo(20);
    }];
    
}

-(void)goToConnect
{
    // 链接服务器
    if (!self.connected)
    {
        self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        NSLog(@"开始连接%@",self.clientSocket);
        
        NSError *error = nil;
        self.connected = [self.clientSocket connectToHost:self.addressTextF.text onPort:[self.portTextF.text integerValue] viaInterface:nil withTimeout:-1 error:&error];
        
        if(self.connected)
        {
            NSLog(@"====>客户端尝试连接");
            [self showMessageWithStr:@"客户端尝试连接"];
        }
        else
        {
            self.connected = NO;
            NSLog(@"====>客户端未创建连接");
            [self showMessageWithStr:@"客户端未创建连接"];
        }
    }
    else
    {
        NSLog(@"与服务器连接已建立");
        [self showMessageWithStr:@"与服务器连接已建立"];
    }
}


-(UITextField*)createTextF
{
    UITextField* textF = [[UITextField alloc] init];
    textF.font = [UIFont systemFontOfSize:12];
    textF.borderStyle = UITextBorderStyleRoundedRect;
    textF.textColor = [UIColor redColor];
    return textF;
}

-(UILabel*)createLabWith:(NSString*)text
{
    UILabel* lab = [[UILabel alloc] init];
    lab.text = text;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = UIColorFromRGB(0x343434);
    lab.font = [UIFont systemFontOfSize:12.0];
    return lab;
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
