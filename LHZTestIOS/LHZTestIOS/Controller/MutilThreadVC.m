//
//  MutilThreadVC.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/1/3.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "MutilThreadVC.h"
#import "JZTHealthTestView.h"
@interface MutilThreadVC ()
{
    NSInteger _count;
}
@property (nonatomic, strong)dispatch_source_t timer;

@property (nonatomic,strong)NSMutableArray* modelArr;

@end

@implementation MutilThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    JZTHealthTestView* tview = [[JZTHealthTestView alloc] init];
    tview.frame = CGRectMake(0, 0, Screen_Width, tview.viewHeight);
    [self.view addSubview:tview];
    
    /* 异步 并发队列 */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        /* 异步请求数据 */
        NSLog(@"异步请求数据");
        
        /* 主线程更新UI */
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"主线程更新UI");
        });
    });
    
    /* 延时执行 */
    [self delayMel];
    
    /* 定时器 */
    [self GCDTimer];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    dispatch_cancel(self.timer);
}

-(void)delayMel
{
    //1.performSelector方法
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
    
    //2.定时器:NSTimer
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(delayMethod) userInfo:nil repeats:NO];
    
    //3.GCD
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.4 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"GCD延时执行......");
    });
}

-(void)GCDTimer
{
    _count = 60;
    
    NSTimeInterval period = 1.0;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, period * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        
        [self timerRun];
        
    });
    dispatch_resume(timer);
    self.timer = timer;
}

-(void)timerRun
{
    _count--;
    NSLog(@"count:%ld",_count);
    
    if (_count == 0) {
        NSLog(@"记时结束");
        dispatch_cancel(self.timer);
    }
}

-(void)delayMethod
{
    NSLog(@"延时执行......");
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
