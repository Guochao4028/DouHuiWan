//
//  CashView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "CashView.h"

#import "NSString+Tool.h"

@interface CashView()

@property (strong, nonatomic) IBOutlet UIView *contentView;
- (IBAction)tixianAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *zhanghaoTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *tixianTextField;


@end

@implementation CashView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CashView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
    
    [self.zhanghaoTextField setAttributedPlaceholder:[NSString attributedPlaceholder:@"请输入手机/邮箱格式账号" inView:self.zhanghaoTextField]];
    
     [self.nameTextField setAttributedPlaceholder:[NSString attributedPlaceholder:@"请输入简体汉字" inView:self.nameTextField]];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}

- (IBAction)tixianAction:(id)sender {
    
    
    
    NSString *zhanghao = self.zhanghaoTextField.text;
    NSString *name = self.nameTextField.text;
    name = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *tixian = self.tixianTextField.text;
    
    if (zhanghao == nil || zhanghao.length == 0) {
        
        [MBProgressHUD wj_showError:@"支付宝账号不能为空"];
        return;
    }
    
    if (name == nil || name.length == 0 ) {
        
        [MBProgressHUD wj_showError:@"名字不能为空"];
        return;
    }
    
    if (tixian == nil || tixian.length == 0) {
        
        [MBProgressHUD wj_showError:@"提现不能为空"];
        return;
    }
    
    if ([tixian floatValue] < 5.0) {
        
        [MBProgressHUD wj_showError:@"提现不能小于5元"];
        return;
    }
    
    BOOL isTrue = YES;
    
    if ([self isValidateEmail:zhanghao] == NO) {
        isTrue = NO;
        if ([self validateMobile:zhanghao] == NO) {
            isTrue = NO;
        }else{
            isTrue = YES;
        }
    }else{
        isTrue =YES;
    }
    
    if (isTrue  == NO) {
        
        [MBProgressHUD wj_showError:@"请输入正确支付宝账号"];
        return;
    }
    
    
    NSString *phoneRegex = @"^[\\u4e00-\\u9fa5]+$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    BOOL flag = [phoneTest evaluateWithObject:name];
    
    if (flag == NO) {
        
        [MBProgressHUD wj_showError:@"请输入简体汉字"];
        return;
    }
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:tixian forKey:@"applyAmount"];
    [dic setObject:name forKey:@"trueName"];
    [dic setObject:zhanghao forKey:@"aliAccount"];
    
    if([self.delegate respondsToSelector:@selector(tijiao:)]){
        [self.delegate tijiao:dic];
    }
    
}


-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}
//手机号码验证
/*
 130~139  145,147 15[012356789] 180~189
 */
-(BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

-(void)setUser:(User *)user{
    NSString *aliAccount = user.aliAccount;
    
    if (aliAccount.length > 0 && aliAccount != nil) {
        [self.zhanghaoTextField setText:aliAccount];
    }
    
    NSString *str = [NSString stringWithFormat:@"可提现¥%@",user.extractableRebate];
    self.tixianTextField.attributedPlaceholder = [NSString attributedPlaceholder:str inView:self.tixianTextField];
}

@end
