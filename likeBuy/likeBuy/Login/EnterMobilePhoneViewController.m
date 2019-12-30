//
//  EnterMobilePhoneViewController.m
//  likeBuy
//
//  Created by mac on 2019/9/9.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "EnterMobilePhoneViewController.h"
#import "NSString+Tool.h"
#import "InputCodeViewController.h"

@interface EnterMobilePhoneViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIView *promptView;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
- (IBAction)getCodeAction:(id)sender;
- (IBAction)backAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneNumberTop;

@end

@implementation EnterMobilePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

-(void)initUI{
    
    if (ScreenHeight < IPHONE6HEIGHT) {
        self.titleTop.constant = 30;
        self.phoneNumberTop .constant = 30;
    }
    
    [self.promptView setHidden:YES];
    
    UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 5)];
    self.phoneNumberTextField.leftView = emptyView;
    self.phoneNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.phoneNumberTextField setDelegate:self];
    

       self.phoneNumberTextField .attributedPlaceholder = [NSString attributedPlaceholder:@"请输入手机号" inView:self.phoneNumberTextField];
    
    [self.codeButton setUserInteractionEnabled:NO];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];

    NSInteger length = str.length;
    
    if (length > 0) {
        [self.codeButton setBackgroundColor:DARKRED];
        [self.codeButton setUserInteractionEnabled:YES];
        [self.codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [self.codeButton setBackgroundColor:LIGHTGREY];
        [self.codeButton setTitleColor:TEXTGREY forState:UIControlStateNormal];
        [self.codeButton setUserInteractionEnabled:NO];
        [self.promptView setHidden:YES];
    }
    return YES;
}

#pragma mark - action

- (IBAction)getCodeAction:(id)sender {
    
    NSString *phoneNumber = self.phoneNumberTextField.text;
    
    BOOL flag = [phoneNumber isRightPhoneNumber];
    
    if(flag == NO){
        [self.promptView setHidden:NO];
        return;
    }
    
    InputCodeViewController *inputCodeVC = [[InputCodeViewController alloc]init];
    inputCodeVC.phoneNumberStr = phoneNumber;
    inputCodeVC.code = self.code;
    [self.navigationController pushViewController:inputCodeVC animated:YES];
    
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
