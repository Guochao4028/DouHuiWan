//
//  PddResultsListViewController.m
//  likeBuy
//
//  Created by mac on 2019/11/10.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "PddResultsListViewController.h"

#import "DetailViewController.h"

#import "PddGoodsOpt.h"

#import "GoodsListView.h"

#import "PddGoodsListModel.h"

#import "GoodsModel.h"

#import "LoginViewController.h"

@interface PddResultsListViewController ()<GoodsListViewDelegate>

@property(nonatomic, strong)GoodsListView *goodsListView;

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, copy)NSString *token;

@property(nonatomic, copy)NSString *currentPage;

@end

@implementation PddResultsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.goodsListView];
}

#pragma mark - 加载数据
-(void)loadDataPddGoodsList:(LoadType)type{
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
        [self.goodsListView refreshingState:MJRefreshStateIdle];
    }
    
    PddGoodsOpt *model = self.model;
    
    NSDictionary *pddDic = @{@"appToken":self.token,
                             @"pageNo":self.currentPage,
                             @"pageSize":@"50",
                             @"optId":model.optId,
                             @"sortType":@"0",
                             @"withCoupon":@"true"
    };
    
    
    
    [[DataManager shareInstance]getGoodsSearchList:pddDic callback:^(NSArray *result) {
        if (type == LoadTypeStart) {
            [MBProgressHUD hideHUD];
        }
        
        [self.dataArray addObjectsFromArray:result];
        self.goodsListView.dataList = self.dataArray;
        if (type == LoadTypeMoreData) {
            [self.goodsListView footerEndRefreshing];
        }else if (type == LoadTypeRefresh) {
            [self.goodsListView headerEndRefreshing];
        }
        
        if (result.count == 0) {
            [self.goodsListView endRefreshingWithNoMoreData];
        }
    }];
}

#pragma mark - GoodsListViewDelegate

-(void)refresh:(UITableView *)tableView{
    [self loadDataPddGoodsList:LoadTypeRefresh];
}

-(void)loadData:(UITableView *)tableView{
   [self loadDataPddGoodsList:LoadTypeMoreData];
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


#pragma mark - getter / setter

-(GoodsListView *)goodsListView{
    if (_goodsListView == nil) {
        
        _goodsListView = [[GoodsListView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - (60+ NavigatorHeight))];
        CGFloat h = ScreenHeight -( 60 +132 + NavigatorHeight);
        _goodsListView.mj_h = h;
        
        [_goodsListView setDelegate:self];
        
        [_goodsListView setViewType:@"pdd"];
    }
    return _goodsListView;
}

-(void)setIndex:(NSInteger)index{
    _index = index;
    self.currentPage = @"1";
    [self loadDataPddGoodsList:LoadTypeStart];
}

-(NSString *)token{
    User *user = [[DataManager shareInstance]getUser];
    if (user == nil) {
        return @"";
    }
    return user.appToken;
    
}

@end
