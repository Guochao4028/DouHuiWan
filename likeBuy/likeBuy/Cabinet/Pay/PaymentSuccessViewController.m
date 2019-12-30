//
//  PaySuccessViewController.m
//  likeBuy
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "PaymentSuccessViewController.h"
#import "PaySuccessView.h"
@interface PaymentSuccessViewController ()<PaySuccessViewDelegate>

@property(nonatomic, strong)PaySuccessView *successView;

@end

@implementation PaymentSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.successView];
    
    [self.successView setFunName:self.payName];
    
    [self.successView setModel:self.model];
}

#pragma mark -  PaySuccessViewDelegate
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(PaySuccessView *)successView{
    if (_successView == nil) {
        _successView = [[PaySuccessView alloc]initWithFrame:self.view.bounds];
        [_successView setDelegate:self];
    }
    return _successView;
}

@end
