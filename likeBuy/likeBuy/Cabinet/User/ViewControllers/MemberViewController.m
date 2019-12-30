//
//  MemberViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "MemberViewController.h"
#import "UpgradeView.h"
#import "NavigationView.h"
#import <WebKit/WebKit.h>

#import "DBManager.h"


@interface MemberViewController ()<NavigationViewDelegate,WKUIDelegate, WKNavigationDelegate>
//导航
@property(nonatomic, strong)NavigationView *navigationView;

//@property(nonatomic, strong)UpgradeView *upgradeView;

@property(nonatomic, strong)WKWebView *webView;
@property(nonatomic, strong)UIProgressView *progressView;
@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.navigationView];
    
    [self.navigationView setTitleStr:@"会员升级"];
    
//    [self.view addSubview:self.upgradeView];

//    [self.upgradeView setIsLabel:NO];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.navigationView.frame))];
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

     NSString *url = [[DBManager shareInstance] promotionUrl];
       
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [self.webView loadRequest:request];
}

#pragma mark - NavigationViewDelegate
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
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


#pragma mark - getter / setter
-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_navigationView setDelegate:self];
    }
    return _navigationView;
}

//-(UpgradeView *)upgradeView{
//
//    if (_upgradeView == nil) {
//        _upgradeView = [[UpgradeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.navigationView.frame))];
//    }
//
//    return _upgradeView;
//}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}



@end
