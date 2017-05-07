//
//  PageMainVC.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/4/26.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "PageMainVC.h"

#import <WebKit/WebKit.h>

#define kRefrashH 50.0

@interface PageMainVC ()<WKNavigationDelegate>

@property (nonatomic,strong) UIScrollView  *scrollerView;

/* 模拟内容视图 */
@property (nonatomic,strong) UIView*  contView;

@property (nonatomic,strong) WKWebView*  webView;

/* 模拟刷新视图 */
@property (nonatomic,strong) UILabel* refrashView;

@end

@implementation PageMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.scrollerView];
    
    [self.scrollerView addSubview:self.webView];
    
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.timetimetime.net"]]];
    
    [self.scrollerView addSubview:self.refrashView];
    
    self.scrollerView.contentSize = CGSizeMake(Screen_Width, self.refrashView.bottom);
    
}


-(UIScrollView *)scrollerView
{
    if (_scrollerView) {
        return _scrollerView;
    }
    
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64.0)];
    
    _scrollerView.delegate = self;
    
    _scrollerView.backgroundColor = [UIColor clearColor];
    
    return _scrollerView;
}


-(WKWebView *)webView
{
    if (_webView) {
        return _webView;
    }
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64.0)];
    _webView.navigationDelegate = self;
    return _webView;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSString *urlString = navigationAction.request.URL.absoluteString;
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {//拨打电话
        NSArray *tempArr = [navigationAction.request.URL.absoluteString componentsSeparatedByString:@":"];
        if ([tempArr.firstObject isEqualToString:@"tel"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",tempArr.lastObject]]];
            decisionHandler(WKNavigationActionPolicyCancel);
        }
    }
    if ([urlString containsString:@"healthtestsharing:&"]) {
        
    }
    
    //如果是跳转一个新页面  H5页面内跳转
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(UIView *)contView
{
    if (_contView) {
        return _contView;
    }
    
    _contView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height+100)];
    
    _contView.backgroundColor = [UIColor yellowColor];
    
    return _contView;
}

-(UILabel *)refrashView
{
    if (_refrashView) {
        return _refrashView;
    }
    
    _refrashView = [[UILabel alloc] initWithFrame:CGRectMake(0, self.webView.scrollView.bottom, Screen_Width, kRefrashH)];
    _refrashView.text = @"上拉刷新";
    _refrashView.textColor = [UIColor yellowColor];
    _refrashView.backgroundColor = [UIColor redColor];
    _refrashView.textAlignment = NSTextAlignmentCenter;
    return _refrashView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    CGFloat contentY = scrollView.contentOffset.y;
    
    CGFloat freashY = self.contView.height - kRefrashH - self.scrollerView.height;
    
    if (contentY > freashY) {
        if ([self.delegate respondsToSelector:@selector(refrashUpFinsh)]) {
            [self.delegate refrashUpFinsh];
        }
    }
}


#pragma mark --- 滑动到顶部
-(void)scrollTo:(CGFloat)contentY
{
    [self.webView.scrollView setContentOffset:CGPointMake(0, contentY)];
    [UIView animateWithDuration:0.1 animations:^{
        [self.scrollerView setContentOffset:CGPointMake(0, contentY)];
    }];
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
