//
//  DestoonFinanceCashViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "DestoonFinanceCashViewController.h"
#import "CashView.h"
#import "NavigationView.h"
#import "CashSucceedViewController.h"

@interface DestoonFinanceCashViewController ()<NavigationViewDelegate, CashViewDelegate>

@property(nonatomic, strong)NavigationView *navigationView;

@property(nonatomic, strong)CashView *cashView;

@property(nonatomic, strong)User *user;


@end

@implementation DestoonFinanceCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"FAFAFA"]];
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.cashView];
    [self.navigationView setTitleStr:@"余额提现"];
    
    [self.cashView setUser:self.user];
}


#pragma mark - CashViewDelegate
-(void)tijiao:(NSDictionary *)dataDic{
    
    NSString *tixianNumber = dataDic[@"applyAmount"];
    
    float price = [tixianNumber floatValue];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提现" message:[NSString stringWithFormat:@"当前提现扣除手续费1元，实际到账 %.2f 元", (price - 1.0)] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self tixian:dataDic];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)tixian:(NSDictionary *)dataDic{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:dataDic];
    
    User *user = [[DataManager shareInstance]getUser];
    
    if (user != nil) {
        [dic setObject:user.appToken forKey:@"appToken"];
    }
    
    [[DataManager shareInstance]accountApplyToALiAccount:dic callBack:^(Message *message) {
        Message *model = message;
        
        NSString *code = [NSString stringWithFormat:@"%@", model.code];
        
        if ([code isEqualToString:@"0"] == YES) {
            
            CashSucceedViewController *cashSuceedVC = [[CashSucceedViewController alloc]init];
            [self.navigationController pushViewController:cashSuceedVC animated:YES];
            
        }else{
            [MBProgressHUD wj_showError:model.reason];
        }
    }];
}


#pragma mark - NavigationViewDelegate

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - getter / setter

-(CashView *)cashView{
    if (_cashView == nil) {
        _cashView = [[CashView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.navigationView.frame))];
        [_cashView setDelegate:self];
    }
    return _cashView;
}

-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_navigationView setDelegate:self];
    }
    return _navigationView;
}


-(User *)user{
    
    User *user = [[DataManager shareInstance]getUser];
    if (user != nil) {
        _user = user;
    }
    return _user;
}


@end
