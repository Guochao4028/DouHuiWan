//
//  CashSucceedViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "CashSucceedViewController.h"
#import "NavigationView.h"
#import "CashSucceedView.h"
#import "RootViewController.h"

@interface CashSucceedViewController ()<NavigationViewDelegate, CashSucceedViewDelegate>

@property(nonatomic, strong)NavigationView *navigationView;

@property(nonatomic, strong)CashSucceedView *cashSucceedView;

@end

@implementation CashSucceedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.cashSucceedView];
    [self.navigationView setTitleStr:@"余额提现"];
    
    
}

#pragma mark - NavigationViewDelegate

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - CashSucceedViewDelegate

-(void)jumpHomePage{
    [self.tabBarController.tabBar setHidden:NO];
    RootViewController *vc = (RootViewController *)[[UIApplication sharedApplication].keyWindow rootViewController];
    vc.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - getter / setter

-(CashSucceedView *)cashSucceedView{
    if (_cashSucceedView == nil) {
        _cashSucceedView = [[CashSucceedView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.navigationView.frame))];
        [_cashSucceedView setDelegate:self];
    }
    return _cashSucceedView;
}

-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_navigationView setDelegate:self];
    }
    return _navigationView;
}


@end
