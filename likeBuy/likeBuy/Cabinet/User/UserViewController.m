//
//  UserViewController.m
//  likeBuy
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "UserViewController.h"
#import "NavigationView.h"
#import "LoginViewController.h"
#import "UserInfoTableViewCell.h"
#import "ControlPanelTableViewCell.h"
#import "BaseViewController.h"
#import "DestoonFinanceCashViewController.h"
#import "SetupViewController.h"
#import "OrdersViewController.h"
#import "InviteViewController.h"
#import "GoodsListViewController.h"
#import "MemberViewController.h"
#import "TeamFansViewController.h"
#import "WalletViewController.h"
#import "StatementHomeViewController.h"

#import "FrequentlyQuestionsViewController.h"
#import "BusinessCooperationViewController.h"
#import "InfoViewController.h"
#import "QuestionModel.h"

#import "AboutUsViewController.h"

#import "LaunchViewController.h"

#import "OrdersRetrieveViewController.h"
#import "DBManager.h"

static NSString *const kUserInfoTableViewCellIdentifier = @"UserInfoTableViewCell";
static NSString *const kControlPanelTableViewCellIdentifier = @"ControlPanelTableViewCell";

@interface UserViewController ()<UITableViewDelegate, UITableViewDataSource, UserInfoTableViewCellDelegate, ControlPanelTableViewCellDelegate, NavigationViewDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NavigationView *navigationView;

@property(nonatomic, strong)NSMutableArray *questionTitleArray;
@property(nonatomic, strong)NSArray *questionDataArray;


@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFinish) name:LOGFINISH object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self initData];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

-(void)initData{
    
    self.questionTitleArray = [NSMutableArray array];
    
    [[DataManager shareInstance]searchDirc:@{@"group":@"problem_plateform"} callback:^(NSArray *result) {
        
        [self.questionTitleArray removeAllObjects];
        
        for (QuestionModel *item in result) {
            [self.questionTitleArray addObject:item.title];
        }
        
        self.questionDataArray = result;
    }];
    
    
    User *user = [[DataManager shareInstance]getUser];
    if (user != nil) {
        [[DataManager shareInstance]getCustomerInfo:@{@"appToken":user.appToken} callBack:^(NSObject *object) {
            [self.tableView reloadData];
        }];
    }
    [self.tableView reloadData];
}


-(void)initUI{
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"FBFBFD"]];
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.tableView];
}

-(void)jumpPage:(NSInteger)type{
    User * user = [[DataManager shareInstance] getUser];
    if (user == nil || user.loginState == NO) {
        //        [self.tabBarController.tabBar setHidden:YES];
        
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        
        BaseViewController *viewController;
        
        switch (type) {
            case 0:
            {
                //我的订单
                OrdersViewController *vc = [[OrdersViewController alloc]init];
                vc.orderType = @"1";
                vc.titles = @[@"全部", @"已付款", @"已结算", @"已失效"];
                viewController = vc;
            }
                break;
            case 1:
            {
                //我的钱包
                WalletViewController *vc = [[WalletViewController alloc]init];
                vc.user = [[DataManager shareInstance]getUser];
                viewController = vc;
                
            }
                break;
            case 2:
            {
                //收益报表
                StatementHomeViewController *memberVC = [[StatementHomeViewController alloc]init];
                memberVC.titles = @[@"淘宝", @"拼多多", @"京东"];
                viewController = memberVC;
                
            }
                break;
            case 3:
            {
                //团队粉丝
                TeamFansViewController *fansVC = [[TeamFansViewController alloc]init];
                User *user = [[DataManager shareInstance]getUser];
                [fansVC setUser:user];
                viewController = fansVC;
                
            }
                break;
            case 4:
            {
                //粉丝订单
                OrdersViewController *vc = [[OrdersViewController alloc]init];
                vc.orderType = @"2";
                vc.titles = @[@"全部", @"已付款", @"已结算", @"已失效"];
                viewController = vc;
            }
                break;
            case 5:
            {
                //邀请
                InviteViewController *inviteVC = [[InviteViewController alloc]init];
                [inviteVC setIsPush:YES];
                viewController = inviteVC;
                
            }
                break;
            case 6:
            {
                //我的收藏
                GoodsListViewController *goodsListVC = [[GoodsListViewController alloc]init];
                goodsListVC.viewControllerTitle = @"我的收藏";
                viewController = goodsListVC;
            }
                
                break;
            case 7:
            {
                //我的足迹
                GoodsListViewController *goodsListVC = [[GoodsListViewController alloc]init];
                goodsListVC.viewControllerTitle = @"我的足迹";
                viewController = goodsListVC;
            }
                break;
            case 8:
            {
                //会员升级
                MemberViewController *memberVC = [[MemberViewController alloc]init];
                viewController = memberVC;
            }
                break;
            case 9:
            {
                //常见问题
                FrequentlyQuestionsViewController *questionsVC = [[FrequentlyQuestionsViewController alloc]init];
//                questionsVC.titles = @[@"豆会玩", @"自营订单", @"客服"];
                questionsVC.titles = self.questionTitleArray;
                questionsVC.dataList = self.questionDataArray;
                viewController = questionsVC;
            }
                break;
            case 10:
            {
                //推广原则
                
                NSString *url = @"http://dhw.5138fun.com/#/principle?deviceOs=ios";
                LaunchViewController *vc = [[LaunchViewController alloc]initWithUrl:url];
                [vc setTitleStr:@"推广原则"];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 11:
            {
                
            }
                break;
            case 12:
            {
                //新手指引
                NSString *url = @"http://dhw.5138fun.com/#/novice?deviceOs=ios";
                LaunchViewController *vc = [[LaunchViewController alloc]initWithUrl:url];
                [vc setTitleStr:@"新手指引"];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 13:
            {
                BusinessCooperationViewController *businessCooperationVC = [[BusinessCooperationViewController alloc]init];
                viewController = businessCooperationVC;
            }
                break;
            case 14:
            {
                AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc]init];
                viewController = aboutUsVC;
            }
                break;
            case 15:
            {
                
            }
                break;
            case 16:
            {
                
            }
                break;
            case 17:
            {
                OrdersRetrieveViewController *ordersRetrieveVC = [[OrdersRetrieveViewController alloc]init];
                
                viewController = ordersRetrieveVC;
            }
                break;
           
            default:
                break;
        }
        [self.navigationController pushViewController:viewController animated:YES];
        [self.tabBarController.tabBar setHidden:YES];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tableViewH = 0;
    if (indexPath.row == 0) {
        User *tem = [[DataManager shareInstance]getUser];
        if (tem != nil) {
            tableViewH = 80;
        }else{
            tableViewH = 136;
        }
        BOOL isShowconfig =  [DBManager shareInstance].isShowconfig;
        if (isShowconfig == NO) {
            tableViewH += 94;
        }
        
    }else if (indexPath.row == 1) {
        tableViewH = 644;//322;//367+300;
    }
    return tableViewH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;//= [[UITableViewCell alloc]init];
    
    if (indexPath.row == 0) {
        UserInfoTableViewCell *userInfoCell = [tableView dequeueReusableCellWithIdentifier:kUserInfoTableViewCellIdentifier forIndexPath:indexPath];
        [userInfoCell setDelegate:self];
        [userInfoCell refreshData];
        cell = userInfoCell;
        
    }else if(indexPath.row == 1){
        ControlPanelTableViewCell *controlPanelCell = [tableView dequeueReusableCellWithIdentifier:kControlPanelTableViewCellIdentifier];
        [controlPanelCell setDelegate:self];
        cell = controlPanelCell;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UserInfoTableViewCellDelegate

-(void)tapLogin{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)tapTixian{
    DestoonFinanceCashViewController *cashVC = [[DestoonFinanceCashViewController alloc]init];
    [self.navigationController pushViewController:cashVC animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)tapSetup{
    SetupViewController *setupVC = [[SetupViewController alloc]init];
    [self.navigationController pushViewController:setupVC animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)loginFinish{
    [self initData];
    [self.tableView reloadData];
}

#pragma mark - ControlPanelTableViewCellDelegate
-(void)tapItem:(UserSelectItemType)type{
    switch (type) {
        case UserSelectItemWodeDingDanType:{
            [self jumpPage:0];
        }
            break;
            
        case UserSelectItemWodeQianBaoType:{
            [self jumpPage:1];
        }
            break;
            
        case UserSelectItemShouyiBaoBiaoType:{
            [self jumpPage:2];
        }
            break;
        case UserSelectItemTuDuiType:{
            
            [self jumpPage:3];
        }
            break;
        case UserSelectItemFensiType:{
            [self jumpPage:4];
            
        }
            break;
        case UserSelectItemYaoQingType:{
            [self jumpPage:5];
        }
            break;
        case UserSelectItemShouCangType:{
            [self jumpPage:6];
        }
            break;
        case UserSelectItemZuJiType:{
            [self jumpPage:7];
            
        }
            break;
        case UserSelectItemHuiYuanType:{
            [self jumpPage:8];
        }
            break;
        case UserSelectItemChangJianType:{
            [self jumpPage:9];
        }
            break;
            
        case UserSelectItemTuiGuangType:{
            [self jumpPage:10];
        }
            break;
        case UserSelectItemWuLiaoType:{
            [self jumpPage:11];
        }
            break;
        case UserSelectItemXinShouType:{
            [self jumpPage:12];
        }
            break;
        case UserSelectItemShangWuType:{
            [self jumpPage:13];
        }
            break;
        case UserSelectItemGuanYuType:{
            [self jumpPage:14];
        }
            break;
        case UserSelectItemDiZhiType:{
            [self jumpPage:15];
        }
            break;
        case UserSelectItemLianXiRenType:{
            [self jumpPage:16];
        }
            break;
        case UserSelectItemZhaoHuiDingDanType:{
            [self jumpPage:17];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - NavigationViewDelegate

-(void)jumpMessageView{
    
    User * user = [[DataManager shareInstance] getUser];
       if (user == nil || user.loginState == NO) {
           LoginViewController *loginVC = [[LoginViewController alloc]init];
           UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
           [self presentViewController:nav animated:YES completion:nil];
       }else{
           InfoViewController *infoVC = [[InfoViewController alloc]init];
           [self.navigationController pushViewController:infoVC animated:YES];
       }
    
}


#pragma mark - getter / setter

-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        
        CGFloat y = [[UIApplication sharedApplication] statusBarFrame].size.height;
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, y, ScreenWidth, 50) type:NavigationDaXie];
        [_navigationView setIsClearColor:YES];
        [_navigationView setDelegate:self];
    }
    return _navigationView;
}

-(UITableView *)tableView{
    if(_tableView == nil){
        CGFloat y = CGRectGetMaxY(self.navigationView.frame);
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, y, ScreenWidth, ScreenHeight - y)];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UserInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:kUserInfoTableViewCellIdentifier];
        [_tableView registerClass:[ControlPanelTableViewCell class] forCellReuseIdentifier:kControlPanelTableViewCellIdentifier];
        
    }
    return _tableView;
}

@end
