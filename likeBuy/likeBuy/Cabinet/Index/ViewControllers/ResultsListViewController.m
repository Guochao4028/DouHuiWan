//
//  ResultsListViewController.m
//  likeBuy
//
//  Created by mac on 2019/10/8.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "ResultsListViewController.h"
#import "GoodsListView.h"
#import "CategoryModel.h"
#import "DetailViewController.h"

@interface ResultsListViewController ()<GoodsListViewDelegate>

@property(nonatomic, strong)GoodsListView *goodsListView;

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, copy)NSString *token;

@property(nonatomic, copy)NSString *currentPage;

@property(nonatomic, copy)NSString *keyString;

//@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSString *messageStr;

@end

@implementation ResultsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.goodsListView];
}

-(void)loadData99BaoYou:(LoadType)type{
    
    
    if (type != LoadTypeMoreData) {
        self.currentPage = @"1";
    }
    
    switch (type) {
        case LoadTypeMoreData:{
            self.currentPage = self.messageStr;
        }
            break;
        default:
            break;
    }
    
    if (type == LoadTypeStart) {
        [MBProgressHUD showActivityMessageInWindow:nil];
        self.dataArray = [NSMutableArray array];
    }
    
    if (type == LoadTypeRefresh) {
        [self.dataArray removeAllObjects];
        //        self.tableView.mj_footer.state = MJRefreshStateIdle;
        [self.goodsListView refreshingState:MJRefreshStateIdle];
    }
    
    NSDictionary *baoyou99Dic = @{@"nav":@"3", @"cid":[NSString stringWithFormat:@"%ld", (long)self.index], @"pageNo":self.currentPage,@"pageSize":@"20", @"sort":@"0",@"deviceOs":@"ios", @"appToken":self.token};

    [[DataManager shareInstance]get99CourierGoodsListParame:baoyou99Dic callBack:^(Message *message) {
        if (type == LoadTypeStart) {
            [MBProgressHUD hideHUD];
        }
        self.messageStr = message.reason;
        [self.dataArray addObjectsFromArray:message.modelList];
        self.goodsListView.dataList = self.dataArray;
        if (type == LoadTypeMoreData) {
            //            [self.tableView.mj_footer endRefreshing];
            [self.goodsListView footerEndRefreshing];
        }else if (type == LoadTypeRefresh) {
            //            [self.tableView.mj_header endRefreshing];
            [self.goodsListView headerEndRefreshing];
        }
        
        if (message.modelList == nil) {
            //            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [self.goodsListView endRefreshingWithNoMoreData];
        }
    }];
    
    
}

-(void)loadDataTop100:(LoadType)type{
    if (type != LoadTypeMoreData) {
        self.currentPage = @"1";
    }
    
    switch (type) {
        case LoadTypeMoreData:{
            self.currentPage = self.messageStr;
        }
            break;
        default:
            break;
    }
    
    if (type == LoadTypeStart) {
        [MBProgressHUD showActivityMessageInWindow:nil];
        self.dataArray = [NSMutableArray array];
    }
    
    if (type == LoadTypeRefresh) {
        [self.dataArray removeAllObjects];
        [self.goodsListView refreshingState:MJRefreshStateIdle];
    }
    
    NSDictionary *top100Dic = @{@"saleType":@"2", @"cid":[NSString stringWithFormat:@"%ld", (long)self.index], @"pageNo":self.currentPage, @"deviceOs":@"ios", @"appToken":self.token};
    
    [[DataManager shareInstance]getTop100GoodsListParame:top100Dic callBack:^(Message *message) {
        if (type == LoadTypeStart) {
            [MBProgressHUD hideHUD];
        }
        self.messageStr = message.reason;
        [self.dataArray addObjectsFromArray:message.modelList];
        self.goodsListView.dataList = self.dataArray;
        if (type == LoadTypeMoreData) {
            [self.goodsListView footerEndRefreshing];
        }else if (type == LoadTypeRefresh) {
            [self.goodsListView headerEndRefreshing];
        }
        
        if (message.modelList == nil) {
            [self.goodsListView endRefreshingWithNoMoreData];
        }
    }];
}

-(void)loadDataXianShi:(LoadType)type{
    
    if (type != LoadTypeMoreData) {
        self.currentPage = @"1";
    }
    
    switch (type) {
        case LoadTypeMoreData:{
            
            self.currentPage = self.messageStr;
        }
            break;
        default:
            break;
    }
    
    if (type == LoadTypeStart) {
        [MBProgressHUD showActivityMessageInWindow:nil];
        self.dataArray = [NSMutableArray array];
    }
    
    if (type == LoadTypeRefresh) {
        [self.dataArray removeAllObjects];
        //        self.tableView.mj_footer.state = MJRefreshStateIdle;
        [self.goodsListView refreshingState:MJRefreshStateIdle];
    }
    NSDictionary *dic = @{@"saleType":@"2", @"hourType":[NSString stringWithFormat:@"%ld", self.index+6], @"pageNo":self.currentPage, @"deviceOs":@"ios", @"appToken":self.token};
    
    [[DataManager shareInstance]flashParame:dic callBack:^(Message *message) {
        
        if (type == LoadTypeStart) {
            [MBProgressHUD hideHUD];
        }
        self.messageStr = message.reason;
        [self.dataArray addObjectsFromArray:message.modelList];
        
        self.goodsListView.dataList = self.dataArray;
        if (type == LoadTypeMoreData) {
            //            [self.tableView.mj_footer endRefreshing];
            [self.goodsListView footerEndRefreshing];
        }else if (type == LoadTypeRefresh) {
            //            [self.tableView.mj_header endRefreshing];
            [self.goodsListView headerEndRefreshing];
        }
        
        if (message.modelList == nil) {
            //            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [self.goodsListView endRefreshingWithNoMoreData];
        }
    }];
}

-(void)loadDataJuHuaSuan:(LoadType)type{
    
    if (type != LoadTypeMoreData) {
        self.currentPage = @"1";
    }
    
    switch (type) {
        case LoadTypeMoreData:{
            NSInteger cp = [self.currentPage integerValue];
            cp++;
            self.currentPage = [NSString stringWithFormat:@"%ld",(long)cp];
        }
            break;
        default:
            break;
    }
    
    if (type == LoadTypeStart) {
        [MBProgressHUD showActivityMessageInWindow:nil];
        self.dataArray = [NSMutableArray array];
    }
    
    if (type == LoadTypeRefresh) {
        [self.dataArray removeAllObjects];
    }
    
    self.keyString = self.titles[self.index];
    
    NSDictionary* dic =@{@"deviceOs":@"ios",@"pageNo":self.currentPage,@"pageSize":@"20",@"searchName":self.keyString, @"sort":@"total_sales_des", @"isTmall":[NSNumber numberWithBool:NO], @"appToken":self.token,@"hasCoupon":[NSNumber numberWithBool:YES]};
    
    
    
    [[DataManager shareInstance]getSearchGoodsList:dic callBack:^(NSArray *result) {
        if (type == LoadTypeStart) {
            [MBProgressHUD hideHUD];
        }
        
        if (result.count == 1 && [[result firstObject] isKindOfClass:[NSString class]]) {
            NSString *message = [result firstObject];
            [MBProgressHUD wj_showError:message];
        }else{
            [self.dataArray addObjectsFromArray:result];
            self.goodsListView.dataList = self.dataArray;
        }
        
        if (type == LoadTypeMoreData) {
            [self.goodsListView footerEndRefreshing];
        }else if (type == LoadTypeRefresh) {
            [self.goodsListView headerEndRefreshing];
        }
    }];
}

-(void)loadDataBaiCaiJia:(LoadType)type{
    
    if (type != LoadTypeMoreData) {
        self.currentPage = @"1";
    }
    
    
    switch (type) {
        case LoadTypeMoreData:{
            NSLog(@"LoadTypeMoreData");
            
            NSInteger cp = [self.currentPage integerValue];
            cp++;
            self.currentPage = [NSString stringWithFormat:@"%ld",(long)cp];
        }
            break;
        default:
            break;
    }
    
    if (type == LoadTypeStart) {
        [MBProgressHUD showActivityMessageInWindow:nil];
        self.dataArray = [NSMutableArray array];
    }
    
    if (type == LoadTypeRefresh) {
        [self.dataArray removeAllObjects];
    }
    
    self.keyString = @"\"\"";
    NSDictionary* dic;
    switch (self.index) {
        case 0:
        {
            dic =@{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":self.currentPage,@"pageSize":@"50",@"searchName":self.keyString,@"sort":@"total_sales",@"startPrice":@"0",@"endPrice":@"10",@"isTmall":[NSNumber numberWithBool:NO],@"hasCoupon":[NSNumber numberWithBool:YES]};
            
        }
            break;
        case 1:
        {
            dic =@{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":self.currentPage,@"pageSize":@"50",@"searchName":self.keyString,@"sort":@"total_sales",@"startPrice":@"10",@"endPrice":@"20",@"isTmall":[NSNumber numberWithBool:NO],@"hasCoupon":[NSNumber numberWithBool:YES]};
        }
            break;
        case 2:
        {
            dic =@{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":self.currentPage,@"pageSize":@"50",@"searchName":self.keyString,@"sort":@"total_sales",@"startPrice":@"20",@"endPrice":@"40",@"isTmall":[NSNumber numberWithBool:NO],@"hasCoupon":[NSNumber numberWithBool:YES]};
        }
            break;
        default:
            break;
    }
    
    [[DataManager shareInstance]getSearchGoodsList:dic callBack:^(NSArray *result) {
        if (type == LoadTypeStart) {
            [MBProgressHUD hideHUD];
        }
        
        if (result.count == 1 && [[result firstObject] isKindOfClass:[NSString class]]) {
            NSString *message = [result firstObject];
            [MBProgressHUD wj_showError:message];
        }else{
            [self.dataArray addObjectsFromArray:result];
            self.goodsListView.dataList = self.dataArray;
        }
        
        if (type == LoadTypeMoreData) {
            [self.goodsListView footerEndRefreshing];
        }else if (type == LoadTypeRefresh) {
            [self.goodsListView headerEndRefreshing];
        }
    }];
}

-(void)loadDataPinPaiQinCang:(LoadType)type{
    if (type != LoadTypeMoreData) {
        self.currentPage = @"1";
    }
    
    
    switch (type) {
        case LoadTypeMoreData:{
            NSLog(@"LoadTypeMoreData");
            
            NSInteger cp = [self.currentPage integerValue];
            cp++;
            self.currentPage = [NSString stringWithFormat:@"%ld",(long)cp];
        }
            break;
        default:
            break;
    }
    
    if (type == LoadTypeStart) {
        [MBProgressHUD showActivityMessageInWindow:nil];
        self.dataArray = [NSMutableArray array];
    }
    
    if (type == LoadTypeRefresh) {
        [self.dataArray removeAllObjects];
    }
    NSString *materialId;
    switch (self.index) {
        case 0:
        {
            materialId = @"9660";
        }
            break;
        case 1:
        {
            materialId = @"13366";
        }
            break;
        case 2:
        {
            materialId = @"3786";
        }
            break;
        default:
            break;
    }
    
    NSDictionary *brandClearanceDic = @{@"materialId":materialId,@"deviceOs":@"ios", @"appToken":self.token, @"pageSize":@"10", @"pageNo":self.currentPage};
    [[DataManager shareInstance]brandClearanceParame:brandClearanceDic callBack:^(NSArray *result) {
        if (type == LoadTypeStart) {
            [MBProgressHUD hideHUD];
        }
        
        [self.dataArray addObjectsFromArray:result];
        self.goodsListView.dataList = self.dataArray;
        
        if (type == LoadTypeMoreData) {
            //            [self.tableView.mj_footer endRefreshing];
            [self.goodsListView footerEndRefreshing];
        }else if (type == LoadTypeRefresh) {
            //            [self.tableView.mj_header endRefreshing];
            [self.goodsListView headerEndRefreshing];
        }
    }];
    
}

-(void)loadDataShiShiReXiao:(LoadType)type{
    if (type != LoadTypeMoreData) {
        self.currentPage = @"1";
    }
    
    switch (type) {
        case LoadTypeMoreData:{
            self.currentPage = self.messageStr;
        }
            break;
        default:
            break;
    }
    
    if (type == LoadTypeStart) {
        [MBProgressHUD showActivityMessageInWindow:nil];
        self.dataArray = [NSMutableArray array];
    }
    
    if (type == LoadTypeRefresh) {
        [self.dataArray removeAllObjects];
        [self.goodsListView refreshingState:MJRefreshStateIdle];
    }
    
    NSDictionary *top100Dic = @{@"saleType":@"1", @"cid":[NSString stringWithFormat:@"%ld", (long)self.index], @"pageNo":self.currentPage, @"deviceOs":@"ios", @"appToken":self.token};
    
    [[DataManager shareInstance]getTop100GoodsListParame:top100Dic callBack:^(Message *message) {
        if (type == LoadTypeStart) {
            [MBProgressHUD hideHUD];
        }
        self.messageStr = message.reason;
        [self.dataArray addObjectsFromArray:message.modelList];
        self.goodsListView.dataList = self.dataArray;
        if (type == LoadTypeMoreData) {
            //            [self.tableView.mj_footer endRefreshing];
            [self.goodsListView footerEndRefreshing];
        }else if (type == LoadTypeRefresh) {
            //            [self.tableView.mj_header endRefreshing];
            [self.goodsListView headerEndRefreshing];
        }
        
        if (message.modelList == nil) {
            //            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [self.goodsListView endRefreshingWithNoMoreData];
        }
    }];
}


#pragma mark - GoodsListViewDelegate

-(void)refresh:(UITableView *)tableView{
    //    self.tableView = tableView;
    switch (self.vcType) {
        case ViewController99BaoYouType:{
            [self loadData99BaoYou:LoadTypeRefresh];
        }
            break;
        case ViewControllerTop100Type:{
            [self loadDataTop100:LoadTypeRefresh];
        }
            break;
            
        case ViewControllerXianShiType:{
            [self loadDataXianShi:LoadTypeRefresh];
        }
            break;
        case ViewControllerJuHuaSuanType:{
            [self loadDataJuHuaSuan:LoadTypeRefresh];
        }
            break;
        case ViewControllerBaiCaiJiaType:{
            [self loadDataBaiCaiJia:LoadTypeRefresh];
        }
            break;
        case ViewControllerPinPaiQinCangType:{
            [self loadDataPinPaiQinCang:LoadTypeRefresh];
        }
            break;
            
        case ViewControllerShiShiReXiaoType:{
            [self loadDataShiShiReXiao:LoadTypeRefresh];
        }
            break;
            
        default:
            break;
    }
}

-(void)loadData:(UITableView *)tableView{
    //    self.tableView = tableView;
    
    switch (self.vcType) {
        case ViewController99BaoYouType:{
            [self loadData99BaoYou:LoadTypeMoreData];
        }
            break;
            
        case ViewControllerTop100Type:{
            [self loadDataTop100:LoadTypeMoreData];
        }
            break;
            
        case ViewControllerXianShiType:{
            [self loadDataXianShi:LoadTypeMoreData];
        }
            break;
        case ViewControllerJuHuaSuanType:{
            [self loadDataJuHuaSuan:LoadTypeMoreData];
        }
            break;
        case ViewControllerBaiCaiJiaType:{
            [self loadDataBaiCaiJia:LoadTypeMoreData];
        }
            break;
        case ViewControllerPinPaiQinCangType:{
            [self loadDataPinPaiQinCang:LoadTypeMoreData];
        }
            break;
            
        case ViewControllerShiShiReXiaoType:{
            [self loadDataShiShiReXiao:LoadTypeMoreData];
        }
            break;
        default:
            break;
    }
}

-(void)tapGoods:(GoodsModel *)model{
    
    
    if (self.vcType != ViewControllerXianShiType) {
        DetailViewController *detailVC = [[DetailViewController alloc]init];
        detailVC.model = model;
        detailVC.flgs = @"2";
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        if (self.isBuy == YES) {
            DetailViewController *detailVC = [[DetailViewController alloc]init];
            detailVC.model = model;
            detailVC.flgs = @"2";
            [self.navigationController pushViewController:detailVC animated:YES];
        }else{
            [MBProgressHUD showInfoMessage:@"宝贝还未开抢，请稍后再来哦"];
        }
    }
}

#pragma mark - getter / setter
-(GoodsListView *)goodsListView{
    if (_goodsListView == nil) {
        
        _goodsListView = [[GoodsListView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - (60+ NavigatorHeight))];
        
        [_goodsListView setDelegate:self];
    }
    return _goodsListView;
}

-(void)setIndex:(NSInteger)index{
    _index = index;
    self.currentPage = @"1";
    
    switch (self.vcType) {
        case ViewController99BaoYouType:{
            [self loadData99BaoYou:LoadTypeStart];
        }
            break;
        case ViewControllerTop100Type:{
            [self loadDataTop100:LoadTypeStart];
        }
            break;
            
        case ViewControllerXianShiType:{
            [self loadDataXianShi:LoadTypeStart];
        }
            break;
            
        case ViewControllerJuHuaSuanType:{
            [self loadDataJuHuaSuan:LoadTypeStart];
        }
            break;
        case ViewControllerBaiCaiJiaType:{
            [self loadDataBaiCaiJia:LoadTypeStart];
        }
            break;
        case ViewControllerPinPaiQinCangType:{
            
            CGFloat h = ScreenHeight -( 60 +132 + NavigatorHeight);
            self.goodsListView.mj_h = h;
            
            [self loadDataPinPaiQinCang:LoadTypeStart];
        }
            break;
        case ViewControllerShiShiReXiaoType:{
            
            CGFloat h = ScreenHeight -( 60 +132 + NavigatorHeight);
            self.goodsListView.mj_h = h;
            
            
            
            [self loadDataShiShiReXiao:LoadTypeStart];
        }
            break;
        default:
            break;
    }
    
}

-(NSString *)token{
    User *user = [[DataManager shareInstance]getUser];
    if (user == nil) {
        return @"";
    }
    return user.appToken;
    
}


@end
