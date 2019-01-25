//
//  GCDViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2019/1/14.
//  Copyright © 2019年 dazhuanjia. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self test4];
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/search?id=1"];
    
    NSLog(@"scheme:%@", [url scheme]); //协议 http
  
    NSLog(@"absoluteString:%@", [url absoluteString]); //完整的url字符串 http://www.baidu.com:8080/search?id=1
   
    
    
    GCDViewController* vv = [[GCDViewController alloc] init];
    Method m1 = class_getInstanceMethod(vv.class, @selector(test1));
    //class_getClassMethod(vv.class, @selector(test1));
    
    NSString *strName = [NSString  stringWithCString:sel_getName(method_getName(m1)) encoding:NSUTF8StringEncoding];
    NSLog(@"m1====%@", strName);
    
    if ([strName isEqualToString:@""]) {
        
    }
}

+(void)abc{
    
}

+(void)abd{
    
}



#pragma mark  --- 串行队列+同步执行 ---》死锁
-(void)test1{
    //串行队列
    dispatch_queue_t queue = dispatch_queue_create(0,DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    //异步执行
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_sync(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

#pragma mark --- 不安全，资源被多个线程抢占
-(void)test3{
    __block int a = 0;
//    while (a < 5) {
//        //栏栅函数  保证线程安全  保证代码顺序
//        dispatch_barrier_async(dispatch_get_global_queue(0, 0), ^{
//            NSLog(@"a=%d, 线程=%@",a,[NSThread currentThread]);
//            a++;
//        });
//    }
    
    dispatch_barrier_async(dispatch_get_global_queue(0, 0), ^{
        while (a < 5) {
            NSLog(@"a=%d, 线程=%@",a,[NSThread currentThread]);
            a++;
            
        }
    });
    
    NSLog(@"a=====%d",a);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"a=====%d",a);
    });
}


#pragma mark --- dispatch_semaphore 线程锁 安全
-(void)test4{
    [self initTicketStatusSave];
}
//卖票
- (void)initTicketStatusSave{

    // queue1 北京
    dispatch_queue_t queue1 = dispatch_queue_create("net.beijing.testQueue1",
                                                    DISPATCH_QUEUE_SERIAL);
    // queue2 上海
    dispatch_queue_t queue2 = dispatch_queue_create("net.shanghai.testQueue2",
                                                    DISPATCH_QUEUE_SERIAL);
    
    __weak typeof(self)weakSelf = self;
    dispatch_async(queue1, ^{
        [weakSelf saleTicket];
    });
    
    dispatch_async(queue2, ^{
        //[weakSelf saleTicket];
    });
}

-(void)saleTicket{
    //总票数
    NSInteger tipCount = 50;
    //线程锁
    //dispatch_semaphore_t lock = dispatch_semaphore_create(1);
    
    while (1) {
        //相当于加锁
        //dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
        
        if (tipCount > 0) {
            tipCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数%ld 线程%@", tipCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        }else {
            NSLog(@"没票了～～～");
            // 解锁
            //dispatch_semaphore_signal(lock);
            break;
        }
        // 解锁
        //dispatch_semaphore_signal(lock);
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
