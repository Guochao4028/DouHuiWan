//
//  InfoDetailViewController.m
//  likeBuy
//
//  Created by mac on 2019/10/27.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "InfoDetailViewController.h"
#import "NavigationView.h"
#import "InfoModel.h"
#import "ModelTool.h"
#import "InfoDetailTableViewCell.h"
#import "InfoGoodsDetailTableViewCell.h"
#import "GoodsModel.h"
#import "DetailViewController.h"


static NSString *const kInfoDetailTableViewCellIdentifier = @"InfoDetailTableViewCell";
static NSString *const kInfoGoodsDetailTableViewCellIdentifier = @"InfoGoodsDetailTableViewCell";

@interface InfoDetailViewController ()<NavigationViewDelegate,UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)NavigationView *navigationView;

//@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, copy)NSString *token;

@property(nonatomic, strong)NSMutableArray *dataArray;

//系统通知
@property(nonatomic, strong)NSMutableArray *systemArray;
//活动公告
@property(nonatomic, strong)NSMutableArray *activityArray;
//好物推荐
@property(nonatomic, strong)NSMutableArray *commodityArray;

@property(nonatomic, strong)NSString *currPage;

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation InfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initUI{
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.tableView];
}

-(void)initData{
    
    self.currPage = @"1";
    
    self.systemArray = [NSMutableArray array];
    self.activityArray = [NSMutableArray array];
    self.commodityArray = [NSMutableArray array];
    
    self.dataArray = [NSMutableArray array];;
    
}

-(void)loadSystemData:(LoadType)loadType{
    
    if (loadType != LoadTypeMoreData) {
        self.currPage = @"1";
    }
    
    if (loadType == LoadTypeStart) {
        [MBProgressHUD showActivityMessageInWindow:nil];
    }
    
    if (loadType == LoadTypeRefresh) {
        [self.dataArray removeAllObjects];
        [self.systemArray removeAllObjects];
    }
    
    switch (loadType) {
        case LoadTypeMoreData:{
            NSLog(@"LoadTypeMoreData");
            
            NSInteger cp = [self.currPage integerValue];
            cp++;
            self.currPage = [NSString stringWithFormat:@"%ld",(long)cp];
        }
            break;
        default:
            break;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:self.currPage forKey:@"pageNo"];
    [dic setValue:@"8" forKey:@"pageSize"];
    [dic setValue:@"1" forKey:@"suType"];
    [dic setValue:self.token forKey:@"appToken"];
    
    [[DataManager shareInstance]getNotificationSystem:dic callback:^(NSArray *result) {
        if (loadType == LoadTypeStart) {
            
            [MBProgressHUD hideHUD];
        }
        
        NSDictionary *dic = [result firstObject];
        
        NSArray *keys = [dic allKeys];
        
        NSString *key = [keys firstObject];
        
        NSDictionary *temDic = [self.activityArray lastObject];
        
        if(temDic == nil){
            [self.systemArray addObjectsFromArray:result];
            self.dataArray = self.systemArray;
        }else{
            NSArray *temDateList = [temDic objectForKey:key];
            if(temDateList == nil){
                [self.systemArray addObjectsFromArray:result];
                self.dataArray = self.systemArray;
            }else{
                NSArray * temList = dic[key];
                
                NSMutableDictionary *temD = [NSMutableDictionary dictionaryWithDictionary:temDic];
                
                NSMutableArray *tem1 = [NSMutableArray arrayWithArray:temDateList];
                [tem1 addObjectsFromArray:temList];
                
                [temD setObject:tem1 forKey:key];
                
                [self.systemArray removeLastObject];
                
                [self.systemArray addObject:temD];
                
                if (result.count > 0) {
                    for (int i = 1; i < result.count ; i++) {
                        [self.activityArray addObject:result[i]];
                    }
                }
                
                self.dataArray = self.systemArray;
            }
        }
        
        
        [self.tableView reloadData];
        
        if (loadType == LoadTypeMoreData) {
            [self.tableView.mj_footer endRefreshing];
        }else if (loadType == LoadTypeRefresh) {
            [self.tableView.mj_header endRefreshing];
        }
    }];
}

-(void)loadActivityData:(LoadType)loadType{
    
    if (loadType == LoadTypeRefresh) {
        [self.dataArray removeAllObjects];
        [self.activityArray removeAllObjects];
    }
    
    if (loadType != LoadTypeMoreData) {
        self.currPage = @"1";
    }
    switch (loadType) {
        case LoadTypeMoreData:{
            NSLog(@"LoadTypeMoreData");
            
            NSInteger cp = [self.currPage integerValue];
            cp++;
            self.currPage = [NSString stringWithFormat:@"%ld",(long)cp];
        }
            break;
        default:
            break;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:self.currPage forKey:@"pageNo"];
    [dic setValue:@"8" forKey:@"pageSize"];
    [dic setValue:self.token forKey:@"appToken"];
    
    [[DataManager shareInstance]getNotificationActivity:dic callback:^(NSArray *result) {
        NSDictionary *dic = [result firstObject];
        
        NSArray *keys = [dic allKeys];
        
        NSString *key = [keys firstObject];
        
        NSDictionary *temDic = [self.activityArray lastObject];
        
        if(temDic == nil){
            [self.activityArray addObjectsFromArray:result];
            self.dataArray = self.activityArray;
        }else{
            NSArray *temDateList = [temDic objectForKey:key];
            if(temDateList == nil){
                [self.activityArray addObjectsFromArray:result];
                self.dataArray = self.activityArray;
            }else{
                NSArray * temList = dic[key];
                
                NSMutableDictionary *temD = [NSMutableDictionary dictionaryWithDictionary:temDic];
                
                NSMutableArray *tem1 = [NSMutableArray arrayWithArray:temDateList];
                [tem1 addObjectsFromArray:temList];
                
                [temD setObject:tem1 forKey:key];
                
                [self.activityArray removeLastObject];
                
                [self.activityArray addObject:temD];
                
                if (result.count > 0) {
                    for (int i = 1; i < result.count ; i++) {
                        [self.activityArray addObject:result[i]];
                    }
                }
                
                self.dataArray = self.activityArray;
            }
        }
        
        [self.tableView reloadData];
        
        if (loadType == LoadTypeMoreData) {
            [self.tableView.mj_footer endRefreshing];
        }else if (loadType == LoadTypeRefresh) {
            [self.tableView.mj_header endRefreshing];
        }
    }];
    
}

-(void)loadCommodityData:(LoadType)loadType{
    
    if (loadType != LoadTypeMoreData) {
        self.currPage = @"1";
    }
    
    if (loadType == LoadTypeRefresh) {
        [self.dataArray removeAllObjects];
        [self.commodityArray removeAllObjects];
    }
    
    switch (loadType) {
        case LoadTypeMoreData:{
            NSLog(@"LoadTypeMoreData");
            
            NSInteger cp = [self.currPage integerValue];
            cp++;
            self.currPage = [NSString stringWithFormat:@"%ld",(long)cp];
        }
            break;
        default:
            break;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.currPage forKey:@"pageNo"];
    [dic setValue:@"8" forKey:@"pageSize"];
    [dic setValue:self.token forKey:@"appToken"];
    [[DataManager shareInstance]getNotificationCommodity:dic callback:^(NSArray *result) {
        NSDictionary *dic = [result firstObject];
        
        NSArray *keys = [dic allKeys];
        
        NSString *key = [keys firstObject];
        
        NSDictionary *temDic = [self.commodityArray lastObject];
        
        if(temDic == nil){
            [self.commodityArray addObjectsFromArray:result];
            self.dataArray = self.commodityArray;
        }else{
            NSArray *temDateList = [temDic objectForKey:key];
            if(temDateList == nil){
                [self.commodityArray addObjectsFromArray:result];
                self.dataArray = self.commodityArray;
            }else{
                NSArray * temList = dic[key];
                
                NSMutableDictionary *temD = [NSMutableDictionary dictionaryWithDictionary:temDic];
                
                NSMutableArray *tem1 = [NSMutableArray arrayWithArray:temDateList];
                [tem1 addObjectsFromArray:temList];
                
                [temD setObject:tem1 forKey:key];
                
                [self.commodityArray removeLastObject];
                
                [self.commodityArray addObject:temD];
                
                if (result.count > 0) {
                    for (int i = 1; i < result.count ; i++) {
                        [self.commodityArray addObject:result[i]];
                    }
                }
                
                self.dataArray = self.commodityArray;
            }
        }
        
        
        
        
        [self.tableView reloadData];
        if (loadType == LoadTypeMoreData) {
            [self.tableView.mj_footer endRefreshing];
        }else if (loadType == LoadTypeRefresh) {
            [self.tableView.mj_header endRefreshing];
        }
        
        
    }];
}

-(void)refreshData{
    switch (self.type) {
        case 0:{
            [self loadSystemData:LoadTypeRefresh];
        }
            break;
        case 1:{
            [self loadCommodityData:LoadTypeRefresh];
        }
            break;
        case 2:{
            [self loadActivityData:LoadTypeRefresh];
        }
            break;
        default:
            break;
    }
}

-(void)loadMoreData{
    switch (self.type) {
        case 0:{
            [self loadSystemData:LoadTypeMoreData];
        }
            break;
        case 1:{
            [self loadCommodityData:LoadTypeMoreData];
        }
            break;
        case 2:{
            [self loadActivityData:LoadTypeMoreData];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGB(247,247,247);
    
    NSDictionary *dic = self.dataArray[section];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, 30)];
    [titleLabel setFont:[UIFont fontWithName:MediumFont size:16]];
    [titleLabel setTextColor:[UIColor blackColor]];
    
    NSString *key = [[dic allKeys] firstObject];
    
    
    [titleLabel setText:key];
    
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [view addSubview:titleLabel];
    
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSDictionary *dic = self.dataArray[section];
    NSString *key = [[dic allKeys] firstObject];
    NSArray *list = dic[key];
    
    return list.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tableViewH = 154;
    if (self.type == 1) {
        tableViewH = 185;
    }
    return tableViewH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;// = [[UITableViewCell alloc]init];
    
    
    if (self.type == 0) {
        InfoDetailTableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:kInfoDetailTableViewCellIdentifier forIndexPath:indexPath];
        
        
        NSDictionary *dic = self.dataArray[indexPath.section];
        NSString *key = [[dic allKeys] firstObject];
        NSArray *list = dic[key];
        [infoCell setDataModel:list[indexPath.row]];
        
        cell = infoCell;
    }else if(self.type == 1){
        InfoGoodsDetailTableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:kInfoGoodsDetailTableViewCellIdentifier forIndexPath:indexPath];
        
        
        NSDictionary *dic = self.dataArray[indexPath.section];
        NSString *key = [[dic allKeys] firstObject];
        NSArray *list = dic[key];
        [infoCell setDataModel:list[indexPath.row]];
        
        cell = infoCell;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type == 1) {
        NSDictionary *dic = self.dataArray[indexPath.section];
        NSString *key = [[dic allKeys] firstObject];
        NSArray *list = dic[key];
        InfoModel *model = list[indexPath.row];
        DetailViewController *detailVC = [[DetailViewController alloc]init];
        GoodsModel *goods = [[GoodsModel alloc]init];
        goods.numIid = model.mid;
        detailVC.model = goods;
        detailVC.flgs = @"1";
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
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
        [_tableView setBackgroundColor:RGB(247,247,247)];
        
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"松手刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
        _tableView.mj_header = header;
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
        
        _tableView.mj_footer = footer;
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([InfoDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:kInfoDetailTableViewCellIdentifier];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([InfoGoodsDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:kInfoGoodsDetailTableViewCellIdentifier];
        
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

-(void)setType:(NSInteger)type{
    _type = type;
    
    switch (type) {
        case 0:{
            [[DataManager shareInstance]readMessage:@{@"appToken":self.token, @"type":@"3"}];
            [self loadSystemData:LoadTypeStart];
        }
            break;
        case 1:{
            [[DataManager shareInstance]readMessage:@{@"appToken":self.token, @"type":@"2"}];
            [self loadCommodityData:LoadTypeStart];
        }
            break;
        case 2:{
            [[DataManager shareInstance]readMessage:@{@"appToken":self.token, @"type":@"1"}];
            [self loadActivityData:LoadTypeStart];
        }
            break;
        default:
            break;
    }
}

@end
