//
//  ClassifyListViewController.m
//  likeBuy
//
//  Created by mac on 2019/9/25.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "ClassifyListViewController.h"

#import "GoodsListView.h"

#import "ScreeningView.h"

#import "PromptListView.h"

#import "NavigationView.h"

#import "CategorySecondClassModel.h"

#import "DetailViewController.h"

@interface ClassifyListViewController ()<NavigationViewDelegate, GoodsListViewDelegate, ScreeningViewDelegate>
@property(nonatomic, strong)NavigationView *navigationView;
@property(nonatomic, strong)ScreeningView *screeningView;
@property(nonatomic, strong)GoodsListView *goodsListView;

@property(nonatomic, copy)NSString *token;
@property(nonatomic, strong)NSString *currPage;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, assign)ListType type;

@property(nonatomic, assign)BOOL xialiangFlag;

@property(nonatomic, assign)BOOL jiageFlag;

@end

@implementation ClassifyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.screeningView];
    [self.view addSubview:self.goodsListView];
}

-(void)initData{
     self.goodsListView.isViewImage =  self.isViewImage;
    [self.goodsListView setIconDic:self.iconDic];
    
    self.dataArray = [NSMutableArray array];
    NSDictionary* dic;
    NSString *sort = @"total_sales_des";
    
    if (self.iconDic != nil) {
        NSString *icon = self.iconDic[@"type"];
        
        NSString *title = self.iconDic[@"title"];
        NSInteger number = [icon integerValue];
        
        if (number >= 0) {
            
            NSString *titleStr = title;
            if ([title isEqualToString:@"拼多多"]) {
                titleStr = @"便宜";
            }
            
            dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":@"1",@"pageSize":@"50",@"searchName":titleStr, @"searchType":@"1",@"isTmall":[NSNumber numberWithBool:NO],@"sort":sort};
        }
        
        if (number >= 2) {
            if (number == 3) {
                dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":@"1",@"pageSize":@"50",@"searchName":title, @"searchType":@"1",@"isTmall":[NSNumber numberWithBool:NO],@"sort":sort};
            }else{
                
                dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":@"1",@"pageSize":@"50",@"searchName":title, @"isTmall":[NSNumber numberWithBool:YES], @"searchType":@"1",@"sort":sort};
            }
        }
    }else{
        
//        @"searchName":self.model.categoryName
        
        if (self.model.cat != nil) {
            dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":@"1",@"pageSize":@"50",@"sort":sort, @"cat":self.model.cat};
        }else{
            dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":@"1",@"pageSize":@"50",@"sort":sort, @"searchName":self.model.categoryName};
        }
        
    }
    
    
    self.currPage = @"1";
    
    [[DataManager shareInstance]getSearchGoodsList:dic callBack:^(NSArray *result){
        
        if (result.count == 1 && [[result firstObject] isKindOfClass:[NSString class]]) {
            
            NSString *message = [result firstObject];
            
            [MBProgressHUD wj_showError:message];
            
        }else{
            
            self.dataArray = [NSMutableArray arrayWithArray:result];
            
            self.goodsListView.dataList = self.dataArray;
            
            self.screeningView.type = ListZongHeType;
            
            self.type = ListZongHeType;
        }
        
    }];
    
}

-(void)update{
    
    NSString *sort = @"total_sales_des";
    switch (self.type) {
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
//            sort = @"tk_total_commi";
            sort = @"total_sales_des";
            break;
    }
//    sort = @"total_sales_des";
    
    NSDictionary* dic;
    
    
    
    if (self.iconDic != nil) {
        NSString *icon = self.iconDic[@"type"];
        
        NSString *title = self.iconDic[@"title"];
        NSInteger number = [icon integerValue];
        if (number >= 0) {
            
            NSString *titleStr = title;
            if ([title isEqualToString:@"拼多多"]) {
                titleStr = @"便宜";
            }
            
            dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":@"1",@"pageSize":@"50",@"searchName":titleStr, @"searchType":@"1",@"isTmall":[NSNumber numberWithBool:NO],@"sort":sort};
        }
        
        if (number >= 2) {
            if (number == 3) {
                dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":@"1",@"pageSize":@"50",@"searchName":title, @"searchType":@"1",@"isTmall":[NSNumber numberWithBool:NO],@"sort":sort};
            }else{
                dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":@"1",@"pageSize":@"50",@"searchName":title, @"isTmall":[NSNumber numberWithBool:YES], @"searchType":@"1",@"sort":sort};
            }
        }
    }else{
//        ,@"searchName":self.model.categoryName
//        dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":@"1",@"pageSize":@"50", @"searchType":@"1",@"sort":sort, @"isTmall": [NSNumber numberWithBool:NO], @"cat":self.model.cat};
        
        if (self.model.cat != nil) {
            dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":@"1",@"pageSize":@"50",@"sort":sort, @"cat":self.model.cat,@"isTmall": [NSNumber numberWithBool:NO], @"searchType":@"1"};
        }else{
            dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":@"1",@"pageSize":@"50",@"sort":sort, @"searchName":self.model.categoryName,@"isTmall": [NSNumber numberWithBool:NO], @"searchType":@"1"};
        }
    }
    
    
    self.currPage = @"1";
    self.dataArray = [NSMutableArray array];
    
    [MBProgressHUD showActivityMessageInWindow:nil];
    
    [[DataManager shareInstance]getSearchGoodsList:dic callBack:^(NSArray *result) {
        
        [MBProgressHUD hideHUD];
        self.dataArray = [NSMutableArray arrayWithArray:result];
        
        self.goodsListView.isUpdata = YES;
        self.goodsListView.dataList = self.dataArray;
        
        [self.tableView.mj_header endRefreshing];
    }];
    
}

#pragma mark - GoodsListViewDelegate
-(void)refresh:(UITableView *)tableView{
    self.tableView = tableView;
    [self update];
}

-(void)loadData:(UITableView *)tableView{
    NSInteger cp = [self.currPage integerValue];
    cp++;
    self.currPage = [NSString stringWithFormat:@"%ld",(long)cp];
    NSString *sort;
    
    switch (self.type) {
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
//            sort = @"tk_total_commi";
            sort = @"total_sales_des";
            break;
    }
//    sort = @"total_sales_des";
    //    NSDictionary* dic = @{@"deviceOs":@"android",@"appToken":@"",@"pageNo":@"1",@"pageSize":@"50",@"searchName":self.model.name, @"searchType":@"1",@"hasCoupon":@"true",@"sort":sort, @"isTmall": @"false"};
    
    NSDictionary* dic;
    
    
    
    if (self.iconDic != nil) {
        NSString *icon = self.iconDic[@"type"];
        
        NSString *title = self.iconDic[@"title"];
        NSInteger number = [icon integerValue];
        if (number >= 0) {
            
            NSString *titleStr = title;
            if ([title isEqualToString:@"拼多多"]) {
                titleStr = @"便宜";
            }
            
            dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":self.currPage,@"pageSize":@"50",@"searchName":titleStr, @"searchType":@"1",@"isTmall":[NSNumber numberWithBool:NO],@"sort":sort};
        }
        
        if (number >= 2) {
            if (number == 3) {
                dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":self.currPage,@"pageSize":@"50",@"searchName":title, @"searchType":@"1",@"isTmall":[NSNumber numberWithBool:NO],@"sort":sort};
            }else{
                dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":self.currPage,@"pageSize":@"50",@"searchName":title, @"isTmall":[NSNumber numberWithBool:YES], @"searchType":@"1",@"sort":sort};
            }
        }
    }else{
//        @"searchName":self.model.categoryName,
//        dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":self.currPage,@"pageSize":@"50", @"searchType":@"1",@"sort":sort, @"isTmall": [NSNumber numberWithBool:NO], @"cat":self.model.cat};
        if (self.model.cat != nil) {
                   dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":self.currPage,@"pageSize":@"50",@"sort":sort, @"cat":self.model.cat,@"isTmall": [NSNumber numberWithBool:NO], @"searchType":@"1"};
               }else{
                   dic = @{@"deviceOs":@"ios",@"appToken":self.token,@"pageNo":self.currPage,@"pageSize":@"50",@"sort":sort, @"searchName":self.model.categoryName,@"isTmall": [NSNumber numberWithBool:NO], @"searchType":@"1"};
               }
        
    }
    
    [MBProgressHUD showActivityMessageInWindow:nil];
    
    
    [[DataManager shareInstance]getSearchGoodsList:dic callBack:^(NSArray *result) {
        [self.dataArray addObjectsFromArray:result];
        [MBProgressHUD hideHUD];
        
        self.goodsListView.isUpdata = NO;
        self.goodsListView.dataList = self.dataArray;
        
        [tableView.mj_footer endRefreshing];
    }];
}

-(void)tapGoods:(GoodsModel *)model{
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    detailVC.model = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - ScreeningViewDelegate

-(void)tapZongHe:(ListType)type{
    self.screeningView.type = ListZongHeType;
    self.type = ListZongHeType;
    [self update];
}

-(void)tapXiaoLiang:(ListType)type{
    
    if (self.xialiangFlag == NO ) {
        self.screeningView.type = ListXiaoLiangShangType;
        self.type = ListXiaoLiangShangType;
    }else{
        self.screeningView.type = ListXiaoLiangXiaType;
        self.type = ListXiaoLiangXiaType;
    }
    
    self.screeningView.type = self.type;
    self.xialiangFlag = !self.xialiangFlag;
    
    [self update];
}

-(void)tapJiaGe:(ListType)type{
    
    if (self.jiageFlag == NO) {
        self.screeningView.type = ListJiaGeShangType;
        self.type = ListJiaGeShangType;
    }else{
        self.screeningView.type = ListJiaGeXiaType;
        self.type = ListJiaGeXiaType;
    }
    
    self.screeningView.type = self.type;
    self.jiageFlag = !self.jiageFlag;
    
    [self update];
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
    }
    return _navigationView;
}

-(ScreeningView *)screeningView{
    if (_screeningView == nil) {
        
        CGFloat navigationViewMaxY = CGRectGetMaxY(self.navigationView.frame);
        
        _screeningView = [[ScreeningView alloc]initWithFrame:CGRectMake(0, navigationViewMaxY, ScreenWidth, 34)];
        [_screeningView setDelegate:self];
        
    }
    return _screeningView;
}

-(GoodsListView *)goodsListView{
    if (_goodsListView == nil) {
        
        CGFloat screeningViewMaxY = CGRectGetMaxY(self.screeningView.frame);
        
        _goodsListView = [[GoodsListView alloc]initWithFrame:CGRectMake(0, screeningViewMaxY, ScreenWidth, ScreenHeight - screeningViewMaxY)];
        [_goodsListView setDelegate:self];
        
    }
    return _goodsListView;
}

-(void)setModel:(CategorySecondClassModel *)model{
    _model = model;
    [self.navigationView setTitleStr:model.categoryName];
    [self initData];
}

-(NSString *)token{
    User *user = [[DataManager shareInstance]getUser];
    if (user == nil) {
        return @"";
    }
    
    return user.appToken;
}

@end
