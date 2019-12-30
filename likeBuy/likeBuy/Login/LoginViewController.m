//
//  LoginViewController.m
//  likeBuy
//
//  Created by mac on 2019/9/5.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "LoginViewController.h"

#import "PhoneLoginViewController.h"

#import "EnterMobilePhoneViewController.h"

#import "InstallmentWebViewController.h"

#import "WebViewController.h"

#import "DBManager.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *weixinLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneLoginButton;
- (IBAction)backAction:(UIButton *)sender;
- (IBAction)wxAction:(UIButton *)sender;
- (IBAction)phoneAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weixinLoginButtonH;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishLogin:) name:NOTIFICATIONLOGIN object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}


-(void)initUI{
    [self.weixinLoginButton.layer setCornerRadius:4];
    [self.phoneLoginButton.layer setCornerRadius:4];
    [self.phoneLoginButton.layer setBorderWidth:1];
    [self.phoneLoginButton.layer setBorderColor:[UIColor colorWithHexString:@"DEDEE0"].CGColor];
    
    NSString *code = [[NSUserDefaults standardUserDefaults]objectForKey:SHOWCONFIG];
    BOOL codeBool = [code boolValue];
    
    if ([WXApi isWXAppInstalled] == YES && codeBool == NO) {
        self.weixinLoginButtonH.constant = 44;
        [self.weixinLoginButton setHidden:NO];
    }else{
        self.weixinLoginButtonH.constant = 0;
        [self.weixinLoginButton setHidden:YES];
    }
//    [self.weixinLoginButton setHidden: ![WXApi isWXAppInstalled]];
    
}


- (IBAction)backAction:(UIButton *)sender {
    
    //    [[NSNotificationCenter defaultCenter] postNotificationName:RENOVATE object:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)phoneAction:(UIButton *)sender {
    //todo 手机登录
    //    PhoneLoginViewController *phoneLoginVC = [[PhoneLoginViewController alloc]init];
    //    [self.navigationController pushViewController:phoneLoginVC animated:YES];
    [[DBManager shareInstance]setWeiXinDic:@{}];
    EnterMobilePhoneViewController *enterMobilePhoneVC = [[EnterMobilePhoneViewController alloc]init];
    [self.navigationController pushViewController:enterMobilePhoneVC animated:YES];
    
}

- (IBAction)wxAction:(UIButton *)sender{
    //微信登录
    if ([WXApi isWXAppInstalled] == YES) {
        SendAuthReq* req =[[SendAuthReq alloc ] init];
        req.scope = @"snsapi_userinfo" ;
        req.state = @"123" ;
        [WXApi sendReq:req];
    }else{
        [MBProgressHUD wj_showError:@"没有检查到微信，请安装微信或手机登录"];
    }
    
    
}

#pragma mark - 通知

-(void)finishLogin:(NSNotification *) notification{
    NSDictionary *dic = notification.userInfo;
    
    [[DBManager shareInstance]setWeiXinDic:dic];
    
    [[DataManager shareInstance]weixinAuthorization:dic callBack:^(NSDictionary *result) {
        NSString *str = result[@"type"];
        
        if ([str isEqualToString:@"message"] == YES) {
            Message *model = result[@"model"];
            
            if ([model.code isEqualToString:@"1"] == YES) {
                PhoneLoginViewController *phoneLoginVC = [[PhoneLoginViewController alloc]init];
                [self.navigationController pushViewController:phoneLoginVC animated:YES];
            }else{
                [MBProgressHUD wj_showError:model.reason toView:self.view];
            }
            if(model.code != nil){
                NSLog(@"todo");
            }
        }else if([str isEqualToString:@"user"] == YES){
            User *model = result[@"model"];
            if (model.tbUserId.length == 0 || model.relationId.length == 0) {
                //                InstallmentWebViewController *webVC = [[InstallmentWebViewController alloc]init];
                //                [self.navigationController pushViewController:webVC animated:YES];
                
                
                [[DataManager shareInstance]taobaobendiAuthorizationParentController:self callBack:^(NSObject *object) {
                    
                    if (object != nil) {
                        WebViewController* webVC = [[WebViewController alloc] init];
                        
                        [self presentViewController:webVC animated:YES completion:nil];
                    }
                }];
                
            }else{
                [self.tabBarController.tabBar setHidden:NO];
                [[NSNotificationCenter defaultCenter] postNotificationName:LOGFINISH object:nil];
                
                [self dismissViewControllerAnimated:YES completion:^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:RENOVATE object:nil];
                }];
            }
            
            User *user = [[DataManager shareInstance] getUser];
            NSString *deviceTokenString = [[DBManager shareInstance]deviceToken];
            if (user != nil) {
                
                if (deviceTokenString != nil) {
                    NSDictionary *dic = @{@"type":@"1", @"did":deviceTokenString, @"appToken":user.appToken, @"deviceOs":@"ios"};
                                   
                                   [[DataManager shareInstance]bindDevice:dic callBack:^(Message *message) {
                                   }];
                }
                
             if (model.pddPid == nil) {
                  [[DataManager shareInstance]getDDKPidGenerate:@{@"appToken":model.appToken, @"deviceOs":@"ios"} callback:^(Message *message) {
                      [[DataManager shareInstance]getCustomerInfo:@{@"appToken":model.appToken} callBack:^(NSObject *object) {}];
                  }];
              }
              
              if (model.jdlmPid == nil) {
                  [[DataManager shareInstance]getJDlmPidBind:@{@"appToken":model.appToken, @"deviceOs":@"ios", @"deviceType":@"2"} callback:^(Message *message) {
                      [[DataManager shareInstance]getCustomerInfo:@{@"appToken":model.appToken} callBack:^(NSObject *object) {}];
                  }];
              }
                
            }
            
        }else{
            [MBProgressHUD wj_showError:@"服务器连接失败"];
        }
    }];
    
}

- (void)dealloc {
    //移除所有观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
