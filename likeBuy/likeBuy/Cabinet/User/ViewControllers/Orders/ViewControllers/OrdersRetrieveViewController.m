//
//  OrdersRetrieveViewController.m
//  likeBuy
//
//  Created by mac on 2019/12/12.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "OrdersRetrieveViewController.h"
#import "NavigationView.h"
#import "RetrieveView.h"
@interface OrdersRetrieveViewController ()<NavigationViewDelegate, RetrieveViewDelegate>

@property(nonatomic, strong)NavigationView *navigationView;

@property(nonatomic, strong)RetrieveView *contentView;

@end

@implementation OrdersRetrieveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)initUI{
    [self.view addSubview:self.navigationView];
    
    [self.view addSubview:self.contentView];
}

#pragma mark - NavigationViewDelegate

-(void)back{
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - RetrieveViewDelegate
-(void)tapSearch:(NSString *)text{
    
    User *user = [[DataManager shareInstance]getUser];
    
    [[DataManager shareInstance]findOrder:@{@"appToken":user.appToken, @"deviceOs":@"ios", @"orderId":text} callback:^(NSDictionary *result) {
        
        NSString *code = [NSString stringWithFormat:@"%@",result[@"code"]];
        if ([code isEqualToString:@"0"] == YES) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSString *message = result[@"message"];
            [MBProgressHUD wj_showError:message];
        }
    }];
}

#pragma mark - getter / setter

-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_navigationView setDelegate:self];
        [_navigationView setTitleStr:@"订单找回"];
    }
    return _navigationView;
}

-(RetrieveView *)contentView{
    if (_contentView == nil) {
        
        CGFloat y = CGRectGetMaxY(self.navigationView.frame);
        
        _contentView = [[RetrieveView alloc]initWithFrame:CGRectMake(0, y, ScreenWidth, ScreenHeight - y)];
        [_contentView setDelegate:self];
    }
    return _contentView;
}

@end
