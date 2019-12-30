//
//  InformationViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/11/2.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "InfoViewController.h"
#import "NavigationView.h"
#import "InfoTableViewCell.h"
#import "InfoDetailViewController.h"


static NSString *const kInfoTableViewCellIdentifier = @"InfoTableViewCell";

@interface InfoViewController ()<NavigationViewDelegate,UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)NavigationView *navigationView;




@property(nonatomic, copy)NSString *token;

//系统通知
@property(nonatomic, strong)NSMutableArray *systemArray;
//活动公告
@property(nonatomic, strong)NSMutableArray *activityArray;
//好物推荐
@property(nonatomic, strong)NSMutableArray *commodityArray;

@property(nonatomic, assign)BOOL isHasSystem;
@property(nonatomic, assign)BOOL isHasActivity;
@property(nonatomic, assign)BOOL isHasCommodity;

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATIONREDPOINT object:nil userInfo:@{@"isRedPoint":@"0"}];
    
    
    [self initUI];
    [self initData];
}

-(void)initUI{
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.tableView];
    
}

-(void)initData{
    
    User *user = [[DataManager shareInstance]getUser];
    NSString *appToken = user.appToken;
    
    self.systemArray = [NSMutableArray array];
    self.activityArray = [NSMutableArray array];
    self.commodityArray = [NSMutableArray array];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//
    [dic setValue:@"1" forKey:@"pageNo"];
    [dic setValue:@"8" forKey:@"pageSize"];
//
    [dic setValue:@"1" forKey:@"suType"];


    if (appToken.length > 0) {
        [dic setValue:appToken forKey:@"appToken"];
    }
    
    [[DataManager shareInstance]getRedPoint:dic callback:^(NSDictionary *result) {
        
        NSString *systemReadFlgs = [NSString stringWithFormat:@"%@",result[@"3"]];
        NSString *activityReadFlgs = [NSString stringWithFormat:@"%@",result[@"2"]];
        NSString *commodityReadFlgs = [NSString stringWithFormat:@"%@",result[@"1"]];

        self.isHasSystem = [systemReadFlgs boolValue];
        self.isHasActivity = [activityReadFlgs boolValue];
        self.isHasCommodity = [commodityReadFlgs boolValue];
        
        [self.tableView reloadData];
    }];
    

    [[DataManager shareInstance]getNotificationSystem:dic callback:^(NSArray *result) {

            [self.systemArray addObjectsFromArray:result];
            [self.tableView reloadData];
        
    }];
    
    [[DataManager shareInstance]getNotificationActivity:dic callback:^(NSArray *result) {
        [self.activityArray addObjectsFromArray:result];
        [self.tableView reloadData];
    }];
    
    [[DataManager shareInstance]getNotificationCommodity:dic callback:^(NSArray *result) {
        [self.commodityArray addObjectsFromArray:result];
        [self.tableView reloadData];
    }];
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
//    return 3;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tableViewH = 68;
    return tableViewH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    InfoTableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:kInfoTableViewCellIdentifier forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
        {
            [infoCell setTitle:@"系统通知"];
            [infoCell setIcon:@"xitong"];
            [infoCell setDataModel:self.systemArray];
            
            infoCell.isRedView = self.isHasSystem;
        }
            break;
            
        case 1:
        {
            [infoCell setTitle:@"好物推荐"];
            [infoCell setIcon:@"yaoqing"];
            [infoCell setDataModel:self.commodityArray];
            infoCell.isRedView = self.isHasCommodity;
        }
            break;
//
//        case 2:
//        {
//            [infoCell setTitle:@"活动公告"];
//            [infoCell setIcon:@"tongz"];
//            [infoCell setDataModel:self.activityArray];
//            infoCell.isRedView = self.isHasActivity;
//        }
//            break;
//
//        default:
//            break;
    }
    
    cell = infoCell;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.row) {
        case 0:
        {
            if (self.systemArray.count == 0) {
                
                [MBProgressHUD wj_showError:@"没有消息"];
                return;
            }
        }
            break;
            
        case 1:
        {
            if (self.commodityArray.count == 0) {
                [MBProgressHUD wj_showError:@"没有消息"];
                return;
            }

        }
            break;
//
//        case 2:
//        {
//            if (self.activityArray.count == 0) {
//
//                [MBProgressHUD wj_showError:@"没有消息"];
//                return;
//            }
//        }
//            break;
//
//        default:
//            break;
    }
    
    
    
    InfoDetailViewController *infoDetailVC = [[InfoDetailViewController alloc]init];
    infoDetailVC.type = indexPath.row ;
    [self.navigationController pushViewController:infoDetailVC animated:YES];
    
    
}


#pragma mark - NavigationViewDelegate

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter / setter

-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_navigationView setDelegate:self];
        [_navigationView setTitleStr:@"消息"];
    }
    return _navigationView;
}


-(UITableView *)tableView{
    if (_tableView == nil) {
        CGFloat navigationViewMaxY = CGRectGetMaxY(self.navigationView.frame);
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, navigationViewMaxY, ScreenWidth, ScreenHeight - navigationViewMaxY) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setBackgroundColor:WHITE];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([InfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:kInfoTableViewCellIdentifier];
    }
    return _tableView;
}


-(NSString *)token{
    User *user = [[DataManager shareInstance]getUser];
    if (user == nil) {
        return @"";
    }
    
    return user.appToken;
}



@end
