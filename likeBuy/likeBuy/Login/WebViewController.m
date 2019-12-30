//
//  WebViewController.m
//  likeBuy
//
//  Created by mac on 2019/10/25.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "WebViewController.h"

#import "AlibcTradeBiz.h"
#import "AlibcWebViewServiceImpl.h"
#import "DBManager.h"


@interface WebViewController ()<UIWebViewDelegate>



@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    //    self.webView  = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    //       [self.webView setDelegate:self];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //    [self.view addSubview:self.webView];
    
    
    [self.view addSubview:self.webView];
    
    [[AlibcWebViewServiceImpl sharedInstance]bindWebviewService:self.webView sourceViewController:self];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://oauth.taobao.com/authorize?response_type=code&client_id=27636423&redirect_uri=http://dhw.5138fun.com/emPowerCode&state=0&view=wap"]];
    
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [self.webView loadRequest:request];
    
    
    
    
}

#pragma mark - UIWebViewDelegate

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    NSLog(@"urlStr : %@", urlStr);
    NSString *str;
    if ([urlStr rangeOfString:@"dhw.5138fun.com/"].length > 0){
        
        
        if ([urlStr containsString:@"?code="]) {
            NSLog(@"拦截成功");
            
            
            User *user = [[DataManager shareInstance]getUser];
            str = [NSString stringWithFormat:@"%@&appToken=%@&deviceOs=h5", urlStr, user.appToken];
            [[DataManager shareInstance]weixinTBwapoauth:str callBack:^(NSDictionary *result) {
                
                NSInteger code = [result[@"code"] integerValue];
                
                if (code == -1) {
                    [MBProgressHUD wj_showError:result[@"message"]];
                }
                [self dismissViewControllerAnimated:YES completion:^{
                    
                    if (self.vc != nil) {
                        [self.vc dismissViewControllerAnimated:YES completion:nil];
                    }
                    
                    if (user.pddPid == nil) {
                        [[DataManager shareInstance]getDDKPidGenerate:@{@"appToken":user.appToken, @"deviceOs":@"ios"} callback:^(Message *message) {
                            
                            [[DataManager shareInstance]getCustomerInfo:@{@"appToken":user.appToken} callBack:^(NSObject *object) {}];
                        }];
                    }
                    
                    if (user.jdlmPid == nil) {
                        [[DataManager shareInstance]getJDlmPidBind:@{@"appToken":user.appToken, @"deviceOs":@"ios", @"deviceType":@"2"} callback:^(Message *message) {
                            [[DataManager shareInstance]getCustomerInfo:@{@"appToken":user.appToken} callBack:^(NSObject *object) {}];
                        }];
                    }
                    
                    
                    [[DataManager shareInstance]getAccessToUserChannelsIDInfo:@{@"appToken":user.appToken, @"deviceOs":@"ios"} callBack:^(NSObject *object) {
                        [[DBManager shareInstance]setUserAccessModel:(UserAccessChannelsModel *)object];
                    }];
                    [[NSNotificationCenter defaultCenter] postNotificationName:LOGFINISH object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:RENOVATE object:nil];
                }];
                
            }];
            
            
            return NO;
        }
        
        
    }
    return YES;
}

#pragma mark - getter / setter

-(UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        [_webView setDelegate:self];
    }
    return _webView;
}

@end
