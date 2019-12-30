//
//  ChangeNumberView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/23.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "ChangeNumberView.h"
#import "NSString+Tool.h"


@interface ChangeNumberView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *codePromprLabel;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
- (IBAction)getCodeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phoneNubmerTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
- (IBAction)sendCodeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@end

@implementation ChangeNumberView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"ChangeNumberView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    
    [self addSubview:self.contentView];
    
    [self.contentView  setFrame:self.bounds];
    
    [self.phoneNubmerTextField setAttributedPlaceholder:[NSString attributedPlaceholder:@"请输入手机号" inView:self.phoneNubmerTextField]];
    
     [self.codeTextField setAttributedPlaceholder:[NSString attributedPlaceholder:@"请输入验证码" inView:self.codeTextField]];
    
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
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
                [self.codePromprLabel setText:@"获取验证码"];
                [self.codePromprLabel setTextColor:[UIColor lightGrayColor]];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.getCodeButton.userInteractionEnabled = NO;
                [self.codePromprLabel setText:[NSString stringWithFormat:@"获取(%ds)",timeout]];
                [self.codePromprLabel setTextColor:[UIColor lightGrayColor]];
            });
            timeout--;
        }
        
    });
    dispatch_resume(timer);
}

- (IBAction)getCodeAction:(id)sender {
    NSString *str = self.phoneNubmerTextField.text;
    
    if (str.length == 0) {
        
        
        [MBProgressHUD wj_showError:@"手机号不可为空"];
        return;
    }else if (![str isRightPhoneNumber]){
        [MBProgressHUD wj_showError:@"手机号格式不正确"];
        return;
    }
    [[DataManager shareInstance]getSmsParame:@{@"telephone": str, @"smsType":@"customerRegister"} callBack:^(Message *message) {
        
        if (message.isSuccess == YES) {
        }
    }];
    
    [self countdown];
}

- (IBAction)sendCodeAction:(id)sender {
    if (self.isUnbundling == YES) {
        [self removeBinding];
    }else{
        [self bindPhoneNumber];
    }
}

-(void)removeBinding{
    NSString *phone = self.phoneNubmerTextField.text;
    NSString *code = self.codeTextField.text;
    
    if (phone.length == 0) {
        
        
        [MBProgressHUD wj_showError:@"手机号不可为空"];
        return;
    }
    if (![phone isRightPhoneNumber]){
        [MBProgressHUD wj_showError:@"手机号格式不正确"];
        return;
    }
    
    if (code.length == 0) {
        [MBProgressHUD wj_showError:@"验证码不能为空"];
        return;
    }
    
    User *user = [[DataManager shareInstance]getUser];
    
    NSDictionary *dic = @{@"smsCode" : code, @"deviceOs":@"ios", @"appToken":user.appToken};
    [MBProgressHUD showActivityMessageInWindow:nil];
    
    [[DataManager shareInstance]unbindTaoBao:dic callBack:^(Message *message) {
        
        NSInteger code = [message.code integerValue];
        [MBProgressHUD hideHUD];
        if (code == 0) {
            [MBProgressHUD showActivityMessageInWindow:nil];
            [[DataManager shareInstance]getCustomerInfo:@{@"appToken":user.appToken} callBack:^(NSObject *object) {
                [MBProgressHUD hideHUD];
                if([self.delegate respondsToSelector:@selector(finish)]){   
                    [self.delegate finish];
                }
            }];
        }else{
            [MBProgressHUD wj_showError:message.reason];
        }
    }];
}

//绑定手机号
-(void)bindPhoneNumber{
    NSString *phone = self.phoneNubmerTextField.text;
    NSString *code = self.codeTextField.text;
    
    if (phone.length == 0) {
        
        [MBProgressHUD wj_showError:@"手机号不可为空"];
        return;
    }
    if (![phone isRightPhoneNumber]){
        
        [MBProgressHUD wj_showError:@"手机号格式不正确"];
        return;
    }
    
    if (code.length == 0) {
        
        [MBProgressHUD wj_showError:@"验证码不能为空"];
        return;
    }
    
    User *user = [[DataManager shareInstance]getUser];
    
    NSDictionary *dic = @{@"telephone" : user.telephone, @"smsCode" : code, @"deviceOs":@"ios", @"newTelephone":phone, @"wxPubOpenId":user.wxPubOpenId};
    
    
    [MBProgressHUD showActivityMessageInWindow:nil];
    [[DataManager shareInstance]modifyCustomerPhone:dic callBack:^(Message *message) {
        
        NSInteger code = [message.code integerValue];
        [MBProgressHUD hideHUD];
        if (code == 0) {
            [MBProgressHUD showActivityMessageInWindow:nil];
            [[DataManager shareInstance]getCustomerInfo:@{@"appToken":user.appToken} callBack:^(NSObject *object) {
                [MBProgressHUD hideHUD];
                if([self.delegate respondsToSelector:@selector(finish)]){
                    
                    
                    [self.delegate finish];
                }
                
            }];
        }else{
            
            [MBProgressHUD wj_showError:message.reason];
        }
        
    }];
}

-(void)setIsUnbundling:(BOOL)isUnbundling{
    _isUnbundling = isUnbundling;
    
    if (isUnbundling == YES) {
        [self.commitButton setTitle:@"解除绑定" forState:UIControlStateNormal];
        
        User *user = [[DataManager shareInstance]getUser];
        
        [self.phoneNubmerTextField setText:user.telephone];
        [self.phoneNubmerTextField setEnabled:NO];
    }
    
}

@end
