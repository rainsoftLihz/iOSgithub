//
//  UITestViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/16.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "UITestViewController.h"

#import "UIView+Corner.h"

#import "PanView.h"

@interface UITestViewController ()<UITextViewDelegate>

@property (nonatomic,strong)PanView* panView;

@end

@implementation UITestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"1>>1===%d",1>>1);
    NSLog(@"1<<1===%d",1<<1);
    NSLog(@"2>>1===%d",2>>1);
    NSLog(@"2<<1===%d",2<<1);
    
//    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sy_jktt"]];
//    img.center = CGPointMake(180, 80);
//    [self.view addSubview:img];
//    
//    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
//    effe.frame = img.frame;
//    // 添加毛玻璃
//    [img addSubview:effe];
    
    
    /* 调整tableview cell 系统img大小 */
//    CGSize itemSize = CGSizeMake(40, 40);
//    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
//    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
////    [cell.imageView.image drawInRect:imageRect];
////    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();

//    self.panView = [[PanView alloc] initWithFrame:CGRectMake(80, 80, 100, 100)];
//    [self.view addSubview:self.panView];
    
//    [self cornerTest];
    
    [self uilabText];
}

-(void)uilabText
{
    UITextView* tlab = [[UITextView alloc] initWithFrame:CGRectMake(10, 88, 300, 100)];
    //tlab.numberOfLines = 0;
    tlab.font = [UIFont systemFontOfSize:13.0];
    NSString* str = @" 促销活动  等连接方式拉近了分局了解到了放假了就是氮磷钾肥接受对方吉林省地方上课江东父老结束了对肌肤来说地方上的粉丝雷锋精神了江东父老说";
    tlab.contentMode = UIViewContentModeCenter;
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:str];
    //修改字间距
    //[attriStr addAttribute:NSKernAttributeName value:@3 range:NSMakeRange(0, 5)];
    
    //修改指定区域文字颜色
    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 6)];
    
    //修改指定区域的背景色
    [attriStr addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 6)];
    
    //插入图片
    NSTextAttachment* attchImg = [[NSTextAttachment alloc] init];
    attchImg.image = [UIImage imageNamed:@"zp"];
    attchImg.bounds = CGRectMake(0, -2, 22, 12);
    
    NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:attchImg];
    //[attriStr insertAttributedString:attachmentAttrStr atIndex:0];
    
    //修改指定区域字体
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 5)];
    
    //添加下划线
    [attriStr addAttribute:NSUnderlineStyleAttributeName
                     value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                     range:NSMakeRange(8, 7)];
    
    //下划线颜色
    [attriStr addAttribute:NSUnderlineColorAttributeName value:[UIColor redColor] range:NSMakeRange(8, 7)];
    
    //设置链接属性
    NSURL* url = [NSURL URLWithString:@"www.baidu.com"];
    [attriStr addAttribute:NSLinkAttributeName
                     value:url
                     range:NSMakeRange(8, 7)];
    
    //设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;
    
    [attriStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    
    tlab.attributedText = attriStr;
    
    //
    tlab.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    [self.view addSubview:tlab];
    
    tlab.delegate = self;
    
    tlab.editable = NO;
    
    
    UITextView*  text2 =  [[UITextView alloc] initWithFrame:CGRectMake(10,260 , 300, 120)];
    
    [attriStr insertAttributedString:attachmentAttrStr atIndex:0];
    text2.font = [UIFont systemFontOfSize:13.0];
    text2.attributedText = attriStr;

    [self.view addSubview:text2];
    
    
}

//IOS 10
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    
    return YES;
}

//IOS 7~10
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //设置导航栏的背景颜色
//    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
//
//       [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsCompact];
    
    //有时候遇到一些特殊的要求，需要隐藏导航栏底部的线条。
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:[UIColor redColor]];

    
}

-(void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:YES];
////    
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:[UIColor grayColor]];

}


#pragma mark --- 切角
-(void)cornerTest
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel* tlab = [[UILabel alloc] initWithFrame:CGRectMake(5, 200, Screen_Width-10, 100)];
    tlab.text = @"我是一只小绵羊";
    tlab.textColor = [UIColor redColor];
    [self.view addSubview:tlab];
    
    //中划线 //下划线
    NSDictionary *attribtDic1 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:tlab.text attributes:attribtDic1];
    
    tlab.attributedText = attribtStr;
    
    
    
    
    UIView* view = [[UIView alloc] initWithFrame:tlab.frame];
    //实现背景色有透明度，当其他sub views不受影响给color 添加 alpha
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];;
    
    
    [self.view addSubview:view];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =  CGRectMake(115, 30, 210, 45);
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"这是一个按钮,只切上边角" forState:UIControlStateNormal];
    [view addSubview:btn];
    
    [btn cornerPartWith:5.0];
}

#pragma mark --- 透明度处理
-(void)alphaTest
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
