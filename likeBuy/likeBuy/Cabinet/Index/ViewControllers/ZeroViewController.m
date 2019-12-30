//
//  ZeroViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "ZeroViewController.h"
#import "NavigationView.h"
//#import "GCHeader.h"

#import "ZeroTableViewCell.h"

#import "AlibcTradeSDK/AlibcTradeSDK.h"
#import "AlibcTradeBiz/AlibcTradeShowParams.h"
#import "DBManager.h"
#import "UserAccessChannelsModel.h"

#import "ZeroModel.h"


static NSString *const kZeroTableViewCellIdentifier = @"ZeroTableViewCell";

@interface ZeroViewController ()<NavigationViewDelegate, UITableViewDelegate, UITableViewDataSource>

//导航
@property(nonatomic, strong)NavigationView *navigationView;

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *dataArray;


@end

@implementation ZeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.tableView];
}

-(void)initData{
    
    self.dataArray = [NSMutableArray array];
    ///淘礼金
    [[DataManager shareInstance]getTaoLiJinList:@{@"deviceOs":@"ios"} callBack:^(NSArray *result) {
        [self.dataArray addObjectsFromArray:result];
        [self.tableView reloadData];
    }];
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
    if (section == 0) {
        return 0.01;
    }else{
        return 0.01;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 0.01;
    }
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tableViewH = 0;
    tableViewH = 140;
    
    
    return tableViewH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZeroTableViewCell *zeroCell = [tableView dequeueReusableCellWithIdentifier:kZeroTableViewCellIdentifier];
    
    [zeroCell setModel:[self.dataArray objectAtIndex:indexPath.row]];
    
    return zeroCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZeroModel *temModle = [self.dataArray objectAtIndex:indexPath.row];
    
    UserAccessChannelsModel *model = [[DBManager shareInstance] userAccessModel];
    BOOL taobaoFlag = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tbopen://"]];
    
    if (taobaoFlag == YES) {
        AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
        showParam.openType = AlibcOpenTypeNative;
        showParam.backUrl=@"tbopen28052033://";
        showParam.isNeedPush=YES;
        
        AlibcWebViewController* myView = [[AlibcWebViewController alloc] init];
        
        AlibcTradeTaokeParams *taoKeParams=[[AlibcTradeTaokeParams alloc] init];
        taoKeParams.pid = model.pId;
        taoKeParams.adzoneId = model.adzoneId;
        if(model.appKey != nil){
            taoKeParams.extParams = @{@"taokeAppkey":model.appKey};
        }
        
        
        [[AlibcTradeSDK sharedInstance].tradeService openByUrl:temModle.sendUrl
                                                      identity:@"trade"
                                                       webView:myView.webView
                                              parentController:self
                                                    showParams:showParam
                                                   taoKeParams:taoKeParams
                                                    trackParam:nil
                                   tradeProcessSuccessCallback:nil
                                    tradeProcessFailedCallback:nil];
    }
    
}

-(void)refresh{
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    self.dataArray = [NSMutableArray array];
    ///淘礼金
    [[DataManager shareInstance]getTaoLiJinList:@{@"deviceOs":@"ios"} callBack:^(NSArray *result) {
        [self.dataArray addObjectsFromArray:result];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
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
        [_navigationView setTitleStr:@"零元购"];
    }
    return _navigationView;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGFloat promptListViewMaxY = CGRectGetMaxY(self.navigationView.frame);
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, promptListViewMaxY, ScreenWidth, ScreenHeight - promptListViewMaxY)];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZeroTableViewCell class]) bundle:nil] forCellReuseIdentifier:kZeroTableViewCellIdentifier];
        [_tableView setBackgroundColor:WHITE];
        
        
        
    }
    return _tableView;
}

@end
