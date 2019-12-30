//
//  InputCodeViewController.m
//  likeBuy
//
//  Created by mac on 2019/9/17.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "InputCodeViewController.h"
#import "NSString+Tool.h"
#import "PhoneLoginViewController.h"
#import "InstallmentWebViewController.h"
#import "WebViewController.h"
#import "DBManager.h"

@interface InputCodeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
- (IBAction)back:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UIView *promptView;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UILabel *sendMeageLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *codeViewTop;

@end

@implementation InputCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

#pragma mark - private
-(void)initUI{
    [self.phoneNumberLabel setText:[NSString formatPhoneNumber:self.phoneNumberStr delBlank:NO]];
    
    [self.inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    if (ScreenHeight < IPHONE6HEIGHT) {
        self.titleTop.constant = 30;
        self.codeViewTop.constant = 30;
    }
    
    [self.inputTextField becomeFirstResponder];
    
    for (int i = 101; i < 107; i++) {
        UILabel *label = [self.codeView viewWithTag:i];
        [label setBackgroundColor:BORDERCOLOR];
        label.layer.cornerRadius = 4;
        label.layer.masksToBounds = YES;
        label.layer.borderWidth = 1;
        label.layer.borderColor = [BORDERCOLOR CGColor];
        [label setText:@""];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clearStr)];
    [self.codeView addGestureRecognizer:tap];
    
    
    [self.promptView setHidden:YES];
    
    
//    [self countdown];
    
//    self.getCodeButton.userInteractionEnabled = YES;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:@" 发送验证码 "];
    
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 6)];
    
    [self.getCodeButton setAttributedTitle:attr forState:UIControlStateNormal];
    
    [self.getCodeButton setBackgroundColor:DARKRED];
    
    [self.getCodeButton addTarget:self action:@selector(getCodeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    [self.sendMeageLabel setText:@"验证码将发送至"];
    
}

-(void)clearStr{
    [self.inputTextField becomeFirstResponder];
    for (int i = 101; i < 107; i++) {
        UILabel *label = [self.codeView viewWithTag:i];
        label.text = @"";
    }
    self.inputTextField.text = @"";
}

//倒计时
-(void)countdown{
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        
        if(timeout <= 0){
            //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.getCodeButton.userInteractionEnabled = YES;
                
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:@" 重新发送? "];
                
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 6)];
                
                [self.getCodeButton setAttributedTitle:attr forState:UIControlStateNormal];
                
                [self.getCodeButton setBackgroundColor:DARKRED];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.getCodeButton.userInteractionEnabled = NO;
                self.getCodeButton.layer.borderWidth = 1;
                self.getCodeButton.layer.borderColor = [BORDERCOLOR CGColor];
                NSString *str = [NSString stringWithFormat:@" %ds后重新发送 ",timeout];
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
                
                NSString *tem = [NSString stringWithFormat:@"%d", timeout];
                
                [attr addAttribute:NSForegroundColorAttributeName value:DARKRED range:NSMakeRange(0, tem.length +2)];
                [attr addAttribute:NSForegroundColorAttributeName value:TEXTGREY range:NSMakeRange((tem.length +2), str.length-tem.length-2)];
                [self.getCodeButton setTitleColor:TEXTGREY forState:UIControlStateNormal];
                
                [self.getCodeButton setAttributedTitle:attr forState:UIControlStateNormal];
                self.getCodeButton.layer.cornerRadius = 4;
                self.getCodeButton.layer.borderWidth = 1;
                self.getCodeButton.layer.borderColor = [BORDERCOLOR CGColor];
                [self.getCodeButton setBackgroundColor:WHITE];
                
                
            });
            timeout--;
        }
        
    });
    dispatch_resume(timer);
}

#pragma mark - action

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidChange:(UITextField *)textField{
    
    NSString *text = textField.text;
    if(text.length == 0){
        for (int i = 101; i < 107; i++) {
            UILabel *label = [self.codeView viewWithTag:i];
            [label setBackgroundColor:BORDERCOLOR];
            label.layer.cornerRadius = 4;
            label.layer.masksToBounds = YES;
            label.layer.borderWidth = 1;
            label.layer.borderColor = [BORDERCOLOR CGColor];
            [label setText:@""];
        }
    }
    
    if (text.length > 6) {
        textField.text = [textField.text substringToIndex:6];
    }
    
    if (text.length == 6) {
        NSDictionary *dic;
        if (self.code != nil) {
            dic = @{@"telephone" : self.phoneNumberStr, @"smsCode" : text, @"deviceOs":@"ios", @"upResqCode": self.code};
        }else{
            dic = @{@"telephone" : self.phoneNumberStr, @"smsCode" : text, @"deviceOs":@"ios"};
        }
        
        
        [self registerPhone:dic];
    }
    
    NSLog(@"text : %@", text);
    
    if ((text.length + 100) >= 101 && (text.length + 100) < 107) {
        
        for (int i = 101; i < 107; i++) {
            UILabel *label = [self.codeView viewWithTag:i];
            [label setBackgroundColor:[UIColor clearColor]];
            label.layer.cornerRadius = 4;
            label.layer.masksToBounds = YES;
            label.layer.borderWidth = 1;
            label.layer.borderColor = [BORDERCOLOR CGColor];
        }
        
        
        UILabel *label = [self.codeView viewWithTag:(text.length +100)];
        [label setText:[text substringWithRange:NSMakeRange(label.tag - 100- 1, 1)]];
        
        //        NSLog(@"%lu",(text.length + 100)+1);
        
        for (NSInteger i = (text.length + 100)+1; i < 107; i++) {
            UILabel *label = [self.codeView viewWithTag:i];
            [label setText:@""];
        }
        
    }
}

-(void)registerPhone:(NSDictionary *)dic{
    
    [MBProgressHUD showActivityMessageInWindow:nil];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSDictionary *tem = [[DBManager shareInstance]weiXinDic];
    if(tem != nil){
        for (NSString *key in tem){
            [param setObject:tem[key] forKey:key];
        }
    }
    
    [[DataManager shareInstance]loginAndRegister:param callBack:^(NSDictionary *result) {
        [MBProgressHUD hideHUD];
        NSString *str = result[@"type"];
        if ([str isEqualToString:@"message"] == YES) {
            Message *model = result[@"model"];
            
            if ([model.code isEqualToString:@"1"] == YES) {
                PhoneLoginViewController *phoneLoginVC = [[PhoneLoginViewController alloc]init];
                phoneLoginVC.identifyingCode = dic[@"smsCode"];
                phoneLoginVC.phoneNumberStr = self.phoneNumberStr;
                [self.navigationController pushViewController:phoneLoginVC animated:YES];
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

#pragma mark - action

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)getCodeAction:(UIButton *)sender {
    [self.sendMeageLabel setText:@"验证码已发送至"];
    [self countdown];
    [[DataManager shareInstance]getSmsParame:@{@"telephone": self.phoneNumberStr, @"smsType":@"customerRegister"} callBack:^(Message *message) {
        if (message.isSuccess == YES) {
        }
    }];
    
    [self clearStr];
}

@end
