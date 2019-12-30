//
//  PhoneLoginViewController.m
//  likeBuy
//
//  Created by mac on 2019/9/5.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "PhoneLoginViewController.h"

#import "NSString+Tool.h"

#import "EnterMobilePhoneViewController.h"

#import "WebViewController.h"

#import "DBManager.h"

@interface PhoneLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
- (IBAction)nextAction:(UIButton *)sender;
- (IBAction)backAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *codeTextFieldTop;

@end

@implementation PhoneLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

-(void)initUI{
    
    if (ScreenHeight < IPHONE6HEIGHT) {
        self.titleTop.constant = 30;
        self.codeTextFieldTop.constant = 30;
    }
    
    
    UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 5)];
    self.codeTextField.leftView = emptyView;
    self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.codeTextField setDelegate:self];
    
    
    self.codeTextField .attributedPlaceholder = [NSString attributedPlaceholder:@"请输入邀请码" inView:self.codeTextField];
    
    
    [self.nextButton setUserInteractionEnabled:NO];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger length = range.location;
    
    if (length > 0) {
        [self.nextButton setBackgroundColor:DARKRED];
        [self.nextButton setUserInteractionEnabled:YES];
        [self.nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [self.nextButton setBackgroundColor:LIGHTGREY];
        [self.nextButton setTitleColor:TEXTGREY forState:UIControlStateNormal];
        [self.nextButton setUserInteractionEnabled:NO];
    }
    return YES;
}

#pragma mark - action

- (IBAction)nextAction:(UIButton *)sender {
    
    if (self.identifyingCode != nil) {
        
        NSDictionary *dic = @{@"telephone" : self.phoneNumberStr, @"smsCode" : self.identifyingCode, @"deviceOs":@"ios", @"upResqCode": self.codeTextField.text};
        [self registerPhone:dic];
        
    }else{
        EnterMobilePhoneViewController *enterMobileVC = [[EnterMobilePhoneViewController alloc]init];
        
        enterMobileVC.code = self.codeTextField.text;
        
        [self.navigationController pushViewController:enterMobileVC animated:YES];
    }
}

-(void)registerPhone:(NSDictionary *)dic{
    
    [MBProgressHUD showActivityMessageInWindow:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [[DataManager shareInstance]loginAndRegister:param callBack:^(NSDictionary *result) {
        [MBProgressHUD hideHUD];
        NSString *str = result[@"type"];
        if ([str isEqualToString:@"message"] == YES) {
            Message *model = result[@"model"];
            
            if ([model.code isEqualToString:@"-1"] == YES) {
                EnterMobilePhoneViewController *enterMobileVC = [[EnterMobilePhoneViewController alloc]init];
                
                enterMobileVC.code = self.codeTextField.text;
                
                [self.navigationController pushViewController:enterMobileVC animated:YES];
            }else{
                [MBProgressHUD wj_showError:model.reason toView:self.view];
            }
            
        }else if([str isEqualToString:@"user"] == YES){
            User *model = result[@"model"];
            if (model.tbUserId.length == 0 || model.relationId.length == 0) {
                //                InstallmentWebViewController *webVC = [[InstallmentWebViewController alloc]init];
                //                [self.navigationController pushViewController:webVC animated:YES];
                
                [[DataManager shareInstance]taobaobendiAuthorizationParentController:self callBack:^(NSObject *object) {
                    
                    if (object != nil) {
                        WebViewController* webVC = [[WebViewController alloc] init];
                        webVC.vc = self;
                        [self presentViewController:webVC animated:YES completion:nil];
                    }
                }];
            }else{
                [self.tabBarController.tabBar setHidden:NO];
                
                
                
                
                [self dismissViewControllerAnimated:YES completion:^{
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
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:LOGFINISH object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:RENOVATE object:nil];
                    
                    User *user = [[DataManager shareInstance] getUser];
                    NSString *deviceTokenString = [[DBManager shareInstance]deviceToken];
                    if (user != nil && deviceTokenString != nil) {
                        NSDictionary *dic = @{@"type":@"1", @"did":deviceTokenString, @"appToken":user.appToken, @"deviceOs":@"ios"};
                        
                        [[DataManager shareInstance]bindDevice:dic callBack:^(Message *message) {
                        }];
                    }
                }];
            }
            
            
            User *user = [[DataManager shareInstance] getUser];
            NSString *deviceTokenString = [[DBManager shareInstance]deviceToken];
            if (user != nil && deviceTokenString != nil) {
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
            
        }else{
            [MBProgressHUD wj_showError:@"服务器连接失败"];
        }
    }];
}


- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)setIdentifyingCode:(NSString *)identifyingCode{
    _identifyingCode = identifyingCode;
    if (identifyingCode != nil) {
        
    }
}

@end
