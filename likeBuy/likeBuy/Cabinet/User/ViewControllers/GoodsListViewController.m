//
//  GoodsListViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "GoodsListViewController.h"
#import "NavigationView.h"
#import "GoodsDetailModel.h"
#import "GoodsListTableViewCell.h"
#import "DetailViewController.h"
#import "DBManager.h"
#import "GoodsModel.h"

static NSString *const kGoodsListTableViewCellIdentifier = @"GoodsListTableViewCell";


@interface GoodsListViewController ()<UITableViewDelegate, UITableViewDataSource,NavigationViewDelegate, DetailViewControllerDelegate>

//导航
@property(nonatomic, strong)NavigationView *navigationView;


@property(nonatomic, assign)BOOL isFav;

@property(nonatomic, copy)NSString *token;

@property(nonatomic, strong)NSString *currentPage;

@property(nonatomic, strong)NSMutableArray *favList;

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation GoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.tableView];
    
    self.favList = [NSMutableArray array];
}

-(void)loadData{
    if (self.isFav == YES) {
        [self loadFavoriteList:2];
    }else{
        [self loadFooterList:2];
    }
}

-(void)loadFooterList:(NSInteger)type{
    
    User *user = [[DataManager shareInstance]getUser];
    if (type == 1) {
        self.currentPage = @"1";
    }
    
    
    if (type == 2) {
        NSInteger cp = [self.currentPage integerValue];
        cp++;
        self.currentPage = [NSString stringWithFormat:@"%ld",(long)cp];
    }
    
    NSDictionary *dic = @{@"appToken":user.appToken, @"pageNo":self.currentPage, @"pageSize":@"10", @"deviceOs":@"ios"};
    
    [[DataManager shareInstance]getFootprintList:dic callBack:^(NSArray *result) {
        [self.favList addObjectsFromArray:result];
        [self.tableView reloadData];
        if (type == 2) {
            [self.tableView.mj_footer endRefreshing];
        }
        if (result.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
    [self.tableView reloadData];
    
    
    
}

-(void)loadFavoriteList:(NSInteger)type{
    
    User *user = [[DataManager shareInstance]getUser];
    
    
    if (type == 1) {
        self.currentPage = @"1";
    }
    
    if (type == 2) {
        NSInteger cp = [self.currentPage integerValue];
        cp++;
        self.currentPage = [NSString stringWithFormat:@"%ld",(long)cp];
    }
    
    NSDictionary *dic = @{@"appToken":user.appToken, @"pageNo":self.currentPage, @"pageSize":@"10", @"deviceOs":@"ios"};
    
    [[DataManager shareInstance]getFavoriteList:dic callBack:^(NSArray *result) {
        //            [MBProgressHUD hideHUD];
        [self.favList addObjectsFromArray:result];
        [self.tableView reloadData];
        if (type == 2) {
            [self.tableView.mj_footer endRefreshing];
        }
        if (result.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}

#pragma mark - NavigationViewDelegate
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark -  UITableViewDelegate & UITableViewDataSource

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
        return 14;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 14;
    }
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    if (self.isFav == YES) {
    return self.favList.count;
    //    }else{
    //        return self.dataList.count;
    //    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tableViewH = 0;
    
    tableViewH = 140;
    
    return tableViewH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;// = [[UITableViewCell alloc]init];
    
    GoodsListTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:kGoodsListTableViewCellIdentifier];
    
    //    if (self.isFav == NO) {
    //        GoodsDetailModel *model =  self.dataList[indexPath.row];
    //        [goodsCell setModel:model.goodsModel];
    //    }else{
    [goodsCell setModel:self.favList[indexPath.row]];
    //    }
    
    cell = goodsCell;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //跳转商品详情
    //    if (self.isFav == NO) {
    //        DetailViewController *detailVC = [[DetailViewController alloc]init];
    //        GoodsDetailModel *model =  self.dataList[indexPath.row];
    //        [detailVC setModel:model.goodsModel];
    //        [self.navigationController pushViewController:detailVC animated:YES];
    //    }else{
    
    GoodsModel *model = self.favList[indexPath.row];
    
    NSInteger userType = [model.userType integerValue];
    
    
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    
    if (userType == 3) {
        detailVC.viewType=@"pdd";
    }else if (userType == 4){
        detailVC.viewType=@"jd";
    }
    
    [detailVC setModel:model];
    [detailVC setDelegate:self];
    [self.navigationController pushViewController:detailVC animated:YES];
    //    }
}

#pragma mark - DetailViewControllerDelegate
-(void)detailViewController:(DetailViewController *)vc cancelCollection:(GoodsModel *)model{
    //    NSMutableArray *tem = [NSMutableArray arrayWithArray:self.dataList];
    if (self.isFav == YES) {
        [self.favList removeObject:model];
        [self.tableView reloadData];
    }
    
}

#pragma mark - getter / setter
-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_navigationView setDelegate:self];
    }
    return _navigationView;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, NavigatorHeight,ScreenWidth, ScreenHeight - NavigatorHeight) style:UITableViewStyleGrouped];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setBackgroundColor:[UIColor whiteColor]];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsListTableViewCell class]) bundle:nil] forCellReuseIdentifier:kGoodsListTableViewCellIdentifier];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        self.tableView.mj_footer = footer;
        
    }
    return _tableView;
}

-(void)setViewControllerTitle:(NSString *)viewControllerTitle{
    _viewControllerTitle = viewControllerTitle;
    [self.navigationView setTitleStr:viewControllerTitle];
    
    if ([viewControllerTitle isEqualToString:@"我的足迹"]) {
        self.isFav = NO;
        
        [self loadFooterList:1];
    }
    
    if ([viewControllerTitle isEqualToString:@"我的收藏"]) {
        //        self.dataList = [[DBManager shareInstance]readData];
        
        self.isFav = YES;
        
        [self loadFavoriteList:1];
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
