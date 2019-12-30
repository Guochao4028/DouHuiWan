//
//  SearchListViewController.m
//  likeBuy
//
//  Created by mac on 2019/9/25.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "SearchListViewController.h"

#import "GoodsListView.h"

#import "ScreeningView.h"

#import "PromptListView.h"

#import "TipMeunView.h"

#import "SearchTopView.h"

#import "ModelTool.h"

#import "DetailViewController.h"

#import "GoodsModel.h"
#import "PddGoodsListModel.h"
#import "LoginViewController.h"


@interface SearchListViewController ()<SearchTopViewDelegate, ScreeningViewDelegate, GoodsListViewDelegate, TipMeunViewDelegate, PromptListViewDelegate>

@property(nonatomic, strong)TipMeunView *meunView;

@property(nonatomic, strong)SearchTopView *searchTopView;
@property(nonatomic, strong)ScreeningView *screeningView;
@property(nonatomic, strong)PromptListView *promptListView;
@property(nonatomic, strong)GoodsListView *goodsListView;

@property(nonatomic, assign)MeunSelectType type;

@property(nonatomic, assign)ListType listType;

@property(nonatomic, assign)BOOL isTapSearchIcon;

@property(nonatomic, strong)NSString *currPage;

@property(nonatomic, copy)NSString *token;

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, assign)BOOL xialiangFlag;

@property(nonatomic, assign)BOOL jiageFlag;

@property(nonatomic, strong)NSMutableArray *searchList;

@property(nonatomic, assign)BOOL hasCoupon;

@end

@implementation SearchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    self.currPage = @"1";
}

-(void)initUI{
    [self.view addSubview:self.searchTopView];
    [self.view addSubview:self.screeningView];
    [self.view addSubview:self.promptListView];
    [self.view addSubview:self.goodsListView];
    
    [self.view addSubview:self.meunView];
}

-(void)initData{
    self.dataArray = [NSMutableArray array];
    
    self.hasCoupon = NO;
    
    NSString *searchName;
    //    if(self.tabString != nil){
    //       searchName = [NSString stringWithFormat:@"%@-%@",self.tabString, self.keyString];
    //    }else{
    searchName = self.keyString;
    //    }
    
    NSString *searchType;
    switch (self.meunType) {
        case MeunSelectPDDType:{
            searchType = @"2";
        }
            break;
        case MeunSelectJDType:{
            searchType = @"3";
        }
            break;
        default:
            searchType = @"1";
            break;
    }
    
    NSDictionary* dic = @{@"deviceOs":@"ios",@"pageNo":@"1",@"pageSize":@"50",@"searchName":searchName, @"searchType":searchType, @"sort":@"total_sales", @"isTmall":[NSNumber numberWithBool:NO], @"appToken":self.token, @"hasCoupon":[NSNumber numberWithBool:self.hasCoupon]};
    
    [[DataManager shareInstance]getSearchGoodsList:dic callBack:^(NSArray *result) {
        if (result.count == 1 && [[result firstObject] isKindOfClass:[NSString class]]) {
            NSString *message = [result firstObject];
            [MBProgressHUD wj_showError:message];
        }else{
            self.dataArray = [NSMutableArray arrayWithArray:result];
            self.goodsListView.isUpdata = YES;
            self.goodsListView.dataList = self.dataArray;
            self.screeningView.type = ListZongHeType;
            self.listType = ListZongHeType;
        }
    }];
    self.meunView.type = MeunSelectTAOBAOType;
    
}


-(void)update{
    
    if (self.meunType == MeunSelectTAOBAOType || self.type == MeunSelectTAOBAOType) {
        [self loadDataTaoBao:LoadTypeRefresh];
    }else if(self.meunType == MeunSelectJDType || self.type == MeunSelectJDType){
        [self loadDataJingDong:LoadTypeRefresh];
    }else if(self.meunType == MeunSelectPDDType || self.type == MeunSelectPDDType){
        [self loadDataPinDuoDuo:LoadTypeRefresh];
    }
}

-(void)loadDataTaoBao:(LoadType)type{
    
    NSString *searchType = @"1";
    
    NSString *sort;
    switch (self.listType) {
        case ListXiaoLiangShangType:
            sort = @"total_sales_asc";
            break;
        case ListXiaoLiangXiaType:
            sort = @"total_sales_des";
            break;
        case ListJiaGeXiaType:
            sort = @"price_des";
            break;
        case ListJiaGeShangType:
            sort = @"price_asc";
            break;
        default:
            sort = @"total_sales";
            break;
    }
    if (type != LoadTypeMoreData) {
        self.currPage = @"1";
        self.dataArray = [NSMutableArray array];
    }
    
    switch (type) {
        case LoadTypeMoreData:{
            NSInteger cp = [self.currPage integerValue];
            cp++;
            self.currPage = [NSString stringWithFormat:@"%ld",(long)cp];
        }
            break;
        case LoadTypeStart:{
            self.screeningView.type = ListZongHeType;
            self.listType = ListZongHeType;
        }
            break;
        default:
            break;
    }
    
    NSNumber *hasCoupon = [NSNumber numberWithBool:self.hasCoupon];
    NSNumber *isTmall;
    if (self.type == MeunSelectCHAOSHIType) {
        isTmall = [NSNumber numberWithBool:YES];
    }else{
        isTmall = [NSNumber numberWithBool:NO];
    }
    
    NSDictionary* dic = @{@"deviceOs":@"ios",@"pageNo":self.currPage,@"pageSize":@"50",@"searchName":self.keyString, @"searchType":searchType,@"sort":sort, @"isTmall": isTmall, @"appToken": self.token,@"hasCoupon":hasCoupon};
    
    [MBProgressHUD showActivityMessageInWindow:nil];
    [[DataManager shareInstance]getSearchGoodsList:dic callBack:^(NSArray *result) {
        [MBProgressHUD hideHUD];
        [self.goodsListView setViewType:@"nou"];
        if (result.count == 1 && [[result firstObject] isKindOfClass:[NSString class]]) {
            NSString *message = [result firstObject];
            [MBProgressHUD wj_showError:message];
        }else{
            
            if (type == LoadTypeRefresh || type == LoadTypeStart) {
                self.goodsListView.isUpdata = YES;
            }else{
                self.goodsListView.isUpdata = NO;
            }
            
            [self.dataArray addObjectsFromArray:result];
            self.goodsListView.dataList = self.dataArray;
            if (type == LoadTypeMoreData) {
                [self.goodsListView footerEndRefreshing];
            }else if (type == LoadTypeRefresh) {
                [self.goodsListView headerEndRefreshing];
            }
        }
    }];
    
    [self.searchTopView endInput];
}


-(void)loadDataPinDuoDuo:(LoadType)type{
    
    if (type != LoadTypeMoreData) {
        self.currPage = @"1";
        self.dataArray = [NSMutableArray array];
    }
    
    switch (type) {
        case LoadTypeMoreData:{
            NSInteger cp = [self.currPage integerValue];
            cp++;
            self.currPage = [NSString stringWithFormat:@"%ld",(long)cp];
        }
            break;
        case LoadTypeStart:{
            self.screeningView.type = ListZongHeType;
            self.listType = ListZongHeType;
        }
            break;
        default:
            break;
    }
    
    NSString *sort;
    switch (self.listType) {
        case ListXiaoLiangShangType:
            sort = @"5";
            break;
        case ListXiaoLiangXiaType:
            sort = @"6";
            break;
        case ListJiaGeXiaType:
            sort = @"4";
            break;
        case ListJiaGeShangType:
            sort = @"3";
            break;
        default:
            sort = @"0";
            break;
    }
    
    NSString *hasCoupon = self.hasCoupon == YES ? @"true" : @"false";
    
    NSDictionary *pddDic = @{@"appToken":self.token,
                             @"pageNo":self.currPage,
                             @"pageSize":@"50",
                             @"keyword":self.keyString,
                             @"sortType":sort,
                             @"withCoupon":hasCoupon
    };
    
    [[DataManager shareInstance]getGoodsSearchList:pddDic callback:^(NSArray *result) {
        
        [self.goodsListView setViewType:@"pdd"];
        if (type == LoadTypeRefresh || type == LoadTypeStart) {
            self.goodsListView.isUpdata = YES;
        }else{
            self.goodsListView.isUpdata = NO;
        }
        
        [self.dataArray addObjectsFromArray:result];
        self.goodsListView.dataList = self.dataArray;
        
        if (type == LoadTypeMoreData) {
            [self.goodsListView footerEndRefreshing];
        }else if (type == LoadTypeRefresh) {
            [self.goodsListView headerEndRefreshing];
        }
        
    }];
}

-(void)loadDataJingDong:(LoadType)type{
    
    if (type != LoadTypeMoreData) {
        self.currPage = @"1";
        self.dataArray = [NSMutableArray array];
    }
    switch (type) {
        case LoadTypeMoreData:{
            NSInteger cp = [self.currPage integerValue];
            cp++;
            self.currPage = [NSString stringWithFormat:@"%ld",(long)cp];
        }
            break;
        case LoadTypeStart:{
            self.screeningView.type = ListZongHeType;
            self.listType = ListZongHeType;
        }
            break;
        default:
            break;
    }
    
    NSString *sort;
    NSString *sortName;
    switch (self.listType) {
        case ListXiaoLiangShangType:
            sort = @"asc";
            sortName = @"inOrderCount30DaysSku";
            break;
        case ListXiaoLiangXiaType:
            sort = @"desc";
            sortName = @"inOrderCount30DaysSku";
            break;
        case ListJiaGeXiaType:
            sort = @"desc";
            sortName = @"price";
            break;
        case ListJiaGeShangType:
            sort = @"asc";
            sortName = @"price";
            break;
        default:
            sort = @"";
            sortName = @"";
            break;
    }
    
    NSString *hasCoupon = self.hasCoupon == YES ? @"1" : @"0";
    
    NSDictionary *jdDic = @{@"appToken":self.token,
                            @"pageNo":self.currPage,
                            @"pageSize":@"50",
                            @"keyword":self.keyString,
                            @"deviceOs":@"ios",
//                            @"isHot":@"1",
                            @"isCoupon":hasCoupon,
                            @"sortName":sortName,
                            @"sort":sort
    };
    
    
    
    [[DataManager shareInstance]getJDGoodsQuery:jdDic callback:^(NSArray *result) {
        if (type == LoadTypeStart) {
            [MBProgressHUD hideHUD];
        }
        
        [self.goodsListView setViewType:@"jd"];
        if (type == LoadTypeRefresh || type == LoadTypeStart) {
            self.goodsListView.isUpdata = YES;
        }else{
            self.goodsListView.isUpdata = NO;
        }
        
        [self.dataArray addObjectsFromArray:result];
        self.goodsListView.dataList = self.dataArray;
        
        if (type == LoadTypeMoreData) {
            [self.goodsListView footerEndRefreshing];
        }else if (type == LoadTypeRefresh) {
            [self.goodsListView headerEndRefreshing];
        }
    }];
}


#pragma mark - TipMeunViewDelegate
-(void)selectedMeunType:(MeunSelectType)type{
    [self.meunView setHidden:YES];
    self.type = type;
    self.meunType = type;
    [self.searchTopView setType:type];
    self.isTapSearchIcon = NO;
    CGFloat searchViewMaxY = CGRectGetMaxY(self.promptListView.frame);
    [UIView animateWithDuration:0.35 animations:^{
        self.goodsListView.mj_y = searchViewMaxY;
    }];
    
    [self update];
    
}

#pragma mark - ScreeningViewDelegate

-(void)tapZongHe:(ListType)type{
    self.screeningView.type = ListZongHeType;
    self.listType = ListZongHeType;
    [self update];
}

-(void)tapXiaoLiang:(ListType)type{
    
    if (self.xialiangFlag) {
        self.screeningView.type = ListXiaoLiangShangType;
        self.listType = ListXiaoLiangShangType;
    }else{
        self.screeningView.type = ListXiaoLiangXiaType;
        self.listType = ListXiaoLiangXiaType;
    }
    self.xialiangFlag = !self.xialiangFlag;
    
    [self update];
}

-(void)tapJiaGe:(ListType)type{
    if (self.jiageFlag) {
        self.screeningView.type = ListJiaGeShangType;
        self.listType = ListJiaGeShangType;
    }else{
        self.screeningView.type = ListJiaGeXiaType;
        self.listType = ListJiaGeXiaType;
    }
    self.jiageFlag = !self.jiageFlag;
    
    [self update];
}

#pragma mark - GoodsListViewDelegate

-(void)refresh:(UITableView *)tableView{
    self.tableView = tableView;
    [self update];
}

-(void)loadData:(UITableView *)tableView{
    if (self.meunType == MeunSelectTAOBAOType || self.type == MeunSelectTAOBAOType) {
        [self loadDataTaoBao:LoadTypeMoreData];
    }else if(self.meunType == MeunSelectJDType || self.type == MeunSelectJDType){
        [self loadDataJingDong:LoadTypeMoreData];
    }else if(self.meunType == MeunSelectPDDType || self.type == MeunSelectPDDType){
        [self loadDataPinDuoDuo:LoadTypeMoreData];
    }
}

-(void)tapGoods:(GoodsModel *)model{
    
    User * user = [[DataManager shareInstance] getUser];
    if (user == nil || user.loginState == NO) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        
        
        DetailViewController *detailVC = [[DetailViewController alloc]init];
        if(self.type == MeunSelectJDType){
            detailVC.viewType = @"jd";
        }
        detailVC.model = model;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

-(void)tapGoodsListModel:(PddGoodsListModel *)model{
    
    User * user = [[DataManager shareInstance] getUser];
    if (user == nil || user.loginState == NO) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        
        DetailViewController *detailVC = [[DetailViewController alloc]init];
        detailVC.viewType = @"pdd";
        GoodsModel *tem = [[GoodsModel alloc]init];
        tem.numIid = model.goodsId;
        
        detailVC.model = tem;
        detailVC.flgs = @"2";
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark - PromptListViewDelegate

-(void)selectSwitchChage:(BOOL)isOn{
    self.hasCoupon = isOn;
    [self update];
}


#pragma mark - SearchTopViewDelegate
-(void)searchTextField:(NSString *)word{
    
    if (word.length > 0) {
        
        if ([self.searchList containsObject:word]) {
            [self.searchList removeObject:word];
        }
        [self.searchList insertObject:word atIndex:0];
        [ModelTool saveSearchHistoryArrayToLocal:self.searchList];
        
        self.keyString = word;
    }else{
        [MBProgressHUD wj_showError:@"请输入关键字或宝贝标题"];
    }
    
}

-(void)selectMeunAction{
    
    [self.meunView setType:self.type];
    self.isTapSearchIcon = !self.isTapSearchIcon;
    if(self.isTapSearchIcon == YES){
        [self.meunView setHidden:NO];
        [UIView animateWithDuration:0.35 animations:^{
            self.goodsListView.mj_y = CGRectGetMaxY(self.meunView.frame);
        }];
    }else{
        [self.meunView setHidden:YES];
        CGFloat searchViewMaxY = CGRectGetMaxY(self.promptListView.frame);
        [UIView animateWithDuration:0.35 animations:^{
            self.goodsListView.mj_y = searchViewMaxY;
        }];
    }
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - setter / getter

-(SearchTopView *)searchTopView{
    if (_searchTopView == nil) {
        CGFloat stateH = [[UIApplication sharedApplication] statusBarFrame].size.height;
        _searchTopView = [[SearchTopView alloc]initWithFrame:CGRectMake(0, stateH, ScreenWidth, 64)];
        [_searchTopView setDelegate:self];
        [_searchTopView setIsViewBack:NO];
    }
    return _searchTopView;
}

-(TipMeunView *)meunView{
    if (_meunView == nil) {
        CGFloat searchViewMaxY = CGRectGetMaxY(self.searchTopView.frame);
        _meunView = [[TipMeunView alloc]initWithFrame:CGRectMake(0, searchViewMaxY, ScreenWidth, 104)];
        [_meunView setDelegate:self];
        [_meunView setHidden:YES];
    }
    return _meunView;
}

-(ScreeningView *)screeningView{
    if (_screeningView == nil) {
        
        CGFloat searchTopViewMaxY = CGRectGetMaxY(self.searchTopView.frame);
        
        _screeningView = [[ScreeningView alloc]initWithFrame:CGRectMake(0, searchTopViewMaxY, ScreenWidth, 34)];
        [_screeningView setDelegate:self];
        
    }
    return _screeningView;
}

-(PromptListView *)promptListView{
    if (_promptListView == nil) {
        CGFloat screeningViewMaxY = CGRectGetMaxY(self.screeningView.frame);
        
        _promptListView = [[PromptListView alloc]initWithFrame:CGRectMake(0, screeningViewMaxY, ScreenWidth, 34)];
        [_promptListView setDelegate:self];
        
    }
    return _promptListView;
}

-(GoodsListView *)goodsListView{
    if (_goodsListView == nil) {
        CGFloat promptListViewMaxY = CGRectGetMaxY(self.promptListView.frame);
        _goodsListView = [[GoodsListView alloc]initWithFrame:CGRectMake(0, promptListViewMaxY, ScreenWidth, ScreenHeight - promptListViewMaxY)];
        [_goodsListView setDelegate:self];
    }
    return _goodsListView;
}

-(NSString *)token{
    User *user = [[DataManager shareInstance]getUser];
    if (user == nil) {
        return @"";
    }
    return user.appToken;
}

-(void)setKeyString:(NSString *)keyString{
    _keyString = keyString;
    [self.searchTopView setInTextStr:keyString];
    
    if (self.meunType == MeunSelectTAOBAOType) {
        [self loadDataTaoBao:LoadTypeStart];
    }else if (self.meunType == MeunSelectJDType){
        [self loadDataJingDong:LoadTypeStart];
    }else if (self.meunType == MeunSelectPDDType){
        [self loadDataPinDuoDuo:LoadTypeStart];
    }
}

-(void)setMeunType:(MeunSelectType)meunType{
    self.type = (meunType);
    
    self.meunView.type = meunType;
    
    self.searchTopView.type = meunType;
    _meunType = meunType;
}

-(NSMutableArray *)searchList{
    
    if (_searchList == nil) {
        _searchList =[ModelTool getSearchHistoryArrayFromLocal];
    }
    
    
    return _searchList;
}

@end
