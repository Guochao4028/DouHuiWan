//
//  WalletViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "WalletViewController.h"

#import "NavigationView.h"

#import "MyWalletView.h"

#import "DestoonFinanceCashViewController.h"

#import "ParticularsViewController.h"

@interface WalletViewController ()<NavigationViewDelegate, MyWalletViewDelegate>

//导航
@property(nonatomic, strong)NavigationView *navigationView;

@property(nonatomic, strong)MyWalletView *myWalletView;


@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self initUI];
}

-(void)initUI{
    [self.view addSubview:self.navigationView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationView setTitleStr:@"我的钱包"];
    
    [self.view addSubview:self.myWalletView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
//    [button setImageEdgeInsets:UIEdgeInsetsMake(-14, 0, 0, 0)];
    
    [button setFrame:CGRectMake((ScreenWidth - 15-50), self.myWalletView.mj_y -50, 50, 50)];
    [button setImage:[UIImage imageNamed:@"activity"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(jumpPageAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

-(void)jumpPageAction{
    
    ParticularsViewController *particularsVC = [[ParticularsViewController alloc]init];
    
    [self.navigationController pushViewController:particularsVC animated:YES];
    
}

#pragma mark - NavigationViewDelegate
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - MyWalletViewDelegate
-(void)jumpPage{
    DestoonFinanceCashViewController *cashVC = [[DestoonFinanceCashViewController alloc]init];
    [self.navigationController pushViewController:cashVC animated:YES];
}

#pragma mark - getter / setter
-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_navigationView setDelegate:self];
    }
    return _navigationView;
}


-(MyWalletView *)myWalletView{
    
    if (_myWalletView == nil) {
        _myWalletView = [[MyWalletView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.navigationView.frame))];
        [_myWalletView setDelegate:self];
    }
    
    return _myWalletView;
}

-(void)setUser:(User *)user{
    [self.myWalletView setUser:user];
}

@end
