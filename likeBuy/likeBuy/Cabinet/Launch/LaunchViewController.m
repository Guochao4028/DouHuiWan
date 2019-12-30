//
//  LaunchViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/9/25.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "LaunchViewController.h"

#import <WebKit/WebKit.h>

#import "NavigationView.h"

@interface LaunchViewController ()<NavigationViewDelegate, WKUIDelegate, WKNavigationDelegate>

@property(nonatomic, strong)WKWebView *webView;

@property(nonatomic, strong)UIProgressView *progressView;

@property(nonatomic, strong)NavigationView *naviagetionView;

@property(nonatomic, strong)NSString *url;

@end

@implementation LaunchViewController

- (instancetype) initWithUrl:(NSString*)url{
    self = [super init];
    
     User *user = [[DataManager shareInstance]getUser];
       
       if ([url rangeOfString:@"?"].location == NSNotFound) {

           self.url = [NSString stringWithFormat:@"%@?apptoken=%@",url,user.appToken];

       } else {

           self.url = [NSString stringWithFormat:@"%@&apptoken=%@",url,user.appToken];

       }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.naviagetionView];
    
    [self.naviagetionView setTitleStr:@"推广"];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.naviagetionView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.naviagetionView.frame))];
    [self.view addSubview:self.webView];
    
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.UIDelegate = self;
    // 导航代理
    self.webView.navigationDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
    
    //添加监测网页加载进度的观察者
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:0
                      context:nil];
    
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.webView.frame), ScreenWidth, 2)];
    
    [self.view addSubview:self.progressView];
    
    //创建网页配置对象
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    // 创建设置对象
    WKPreferences *preference = [[WKPreferences alloc]init];
    
    config.preferences = preference;
    config.applicationNameForUserAgent = @"ChinaDailyForiPad";
    
    __weak typeof(self) weakSelf;
    
    [self.webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        NSString *userAgent = result;
        NSString *newUserAgent = [userAgent stringByAppendingString:@"Mozilla/5.0"];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [weakSelf.webView setCustomUserAgent:newUserAgent];
    }];
    
    
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [self.webView loadRequest:request];
    
    
    if(self.titleStr != nil){
        [self.naviagetionView setTitleStr:self.titleStr];
    }
    
}


#pragma mark - kvo
//kvo 监听进度 必须实现此方法
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == _webView) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (_webView.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.progress = 0;
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

#pragma mark - WKUIDelegate & WKNavigationDelegate
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
}

//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.progressView setProgress:0.0f animated:NO];
}

// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
}

// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转



#pragma mark - NavigationViewDelegate

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - getter / setter

-(NavigationView *)naviagetionView{
    if (_naviagetionView == nil) {
        _naviagetionView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_naviagetionView setDelegate:self];
    }
    return _naviagetionView;
}



- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView setNavigationDelegate:nil];
    [self.webView setUIDelegate:nil];
}



-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    [self.naviagetionView setTitleStr:titleStr];
}

@end
