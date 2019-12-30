//
//  ModifyPhoneViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/23.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "ModifyPhoneViewController.h"

#import "NavigationView.h"

#import "ChangeNumberView.h"

@interface ModifyPhoneViewController ()<NavigationViewDelegate, ChangeNumberViewDelegate>
//导航
@property(nonatomic, strong)NavigationView *navigationView;

@property(nonatomic, strong)ChangeNumberView *numberView;

@end

@implementation ModifyPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initData];
}

-(void)initUI{
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.navigationView];
    if (self.isUnbundling == YES) {
        [self.navigationView setTitleStr:@"解绑淘宝授权"];
    }else{
        [self.navigationView setTitleStr:@"修改手机号"];
    }
    
    
    [self.view addSubview:self.numberView];
    
    self.numberView.isUnbundling = self.isUnbundling;
    
    
}

-(void)initData{
    
}

#pragma mark - NavigationViewDelegate
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ChangeNumberViewDelegate

-(void)finish{
    [self back];
}

#pragma mark - getter / setter
-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_navigationView setDelegate:self];
    }
    return _navigationView;
}

-(ChangeNumberView *)numberView{
    if (_numberView == nil) {
        _numberView = [[ChangeNumberView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.navigationView.frame))];
        [_numberView setDelegate:self];
    }
    return _numberView;
}

-(void)setIsUnbundling:(BOOL)isUnbundling{
    _isUnbundling = isUnbundling;
}


@end
