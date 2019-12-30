//
//  BreedViewController.m
//  likeBuy
//
//  Created by mac on 2019/10/22.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "BreedViewController.h"

#import "BreedIntoTableViewCell.h"

#import "CategoryModel.h"

#import "CategorySecondClassModel.h"

#import "GoodsListTableViewCell.h"

#import "ClassifyListViewController.h"
#import "DetailViewController.h"
#import "LoginViewController.h"

static NSString *const kBreedIntoTableViewCellIdentifier = @"BreedIntoTableViewCell";

static NSString *const kGoodsListTableViewCellIdentifier = @"GoodsListTableViewCell";

@interface BreedViewController ()<UITableViewDelegate, UITableViewDataSource, BreedIntoTableViewCellDelegate>

@property(nonatomic, strong)UITableView *tableView;

//推荐好物
@property(nonatomic, strong)NSMutableArray *goodsArray;

//当前页面
@property(nonatomic, strong)NSString *currentPage;

@property(nonatomic, copy)NSString *token;

@property(nonatomic, strong)CategoryModel *model;

@end

@implementation BreedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    [self.view addSubview:self.tableView];
}

#pragma mark - 加载更多数据
-(void)loadMoreData{
    NSInteger cp = [self.currentPage integerValue];
    cp++;
    self.currentPage = [NSString stringWithFormat:@"%ld",(long)cp];
//    NSDictionary *param = @{@"deviceOs":@"ios", @"pageNo":self.currentPage, @"pageSize":@"50", @"searchName":self.keyString,@"sort":@"total_sales_des",@"searchType":@"1", @"appToken":self.token, @"hasCoupon":[NSNumber numberWithBool:YES], @"cat":self.model.cat};
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setValue:@"ios" forKey:@"deviceOs"];
    [param setValue:self.currentPage forKey:@"pageNo"];
    [param setValue:@"50" forKey:@"pageSize"];
    [param setValue:[NSNumber numberWithBool:YES] forKey:@"hasCoupon"];
    [param setValue:self.keyString forKey:@"searchName"];
    [param setValue:@"total_sales_des" forKey:@"sort"];
    [param setValue:@"1" forKey:@"searchType"];
    [param setValue:self.token forKey:@"appToken"];
    if (self.model.cat != nil) {
        [param setValue:self.model.cat forKey:@"cat"];

    }
       
       [[DataManager shareInstance]getHomePageGoodsListParame:param callBack:^(NSArray *result) {
           [self.goodsArray addObjectsFromArray:result];
           [self.tableView reloadData];
           [self.tableView.mj_footer endRefreshing];
       }];
}

#pragma mark - 刷新
-(void)refreshData{
    
    self.currentPage = @"1";
       self.goodsArray = [NSMutableArray array];
//       NSDictionary *param = @{@"deviceOs":@"ios", @"pageNo":@"1", @"pageSize":@"50", @"searchName":self.keyString,@"sort":@"total_sales_des",@"searchType":@"1", @"appToken":self.token, @"hasCoupon":[NSNumber numberWithBool:YES], @"cat":self.model.cat};
//
    
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
       
       [param setValue:@"ios" forKey:@"deviceOs"];
       [param setValue:self.currentPage forKey:@"pageNo"];
       [param setValue:@"50" forKey:@"pageSize"];
       [param setValue:[NSNumber numberWithBool:YES] forKey:@"hasCoupon"];
       [param setValue:self.keyString forKey:@"searchName"];
       [param setValue:@"total_sales_des" forKey:@"sort"];
       [param setValue:@"1" forKey:@"searchType"];
       [param setValue:self.token forKey:@"appToken"];
       if (self.model.cat != nil) {
           [param setValue:self.model.cat forKey:@"cat"];

       }
    
    
          [[DataManager shareInstance]getHomePageGoodsListParame:param callBack:^(NSArray *result) {
              self.goodsArray = [NSMutableArray arrayWithArray:result];
              [self.tableView reloadData];
              [self.tableView.mj_header endRefreshing];
          }];
    
}

#pragma mark - 跳转商品详情
-(void)jumpGoodsDetail:(GoodsModel *)model{
    User * user = [[DataManager shareInstance] getUser];
    if (user == nil || user.loginState == NO) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        //跳转商品详情
        DetailViewController *detailVC = [[DetailViewController alloc]init];
        detailVC.model = model;
        detailVC.flgs = @"1";
        [detailVC setIsHomePage:YES];
        [self.navigationController pushViewController:detailVC animated:YES];
        [self.tabBarController.tabBar setHidden:YES];
    }
}

#pragma mark -  UITableViewDelegate & UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        return view;
    }else if (section == 1 || section == 2) {
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(21, 26, 72, 25)];
        [titleLabel setFont:[UIFont fontWithName:MediumFont size:18]];
        [titleLabel setTextColor:[UIColor blackColor]];
        
        NSString *str;
        if (section == 1) {
            str = @"猜你喜欢";
        }else{
            str = @"推荐好物";
        }
        [titleLabel setText:str];
        [view addSubview:titleLabel];
        return view;
    }
    
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
        // tag 首页
        return 0.01;
    }else if (section == 1) {
        return 64;
    }else{
        return 64;
    }
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
      return self.goodsArray.count;
    }
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tableViewH = 0.0;
    if (indexPath.section == 0) {
        tableViewH = 220;
    }else{
        tableViewH = 140;
    }
    
    return tableViewH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;// = [[UITableViewCell alloc]init];
    
    if (indexPath.section == 0) {
        BreedIntoTableViewCell *breedIntoCell = [tableView dequeueReusableCellWithIdentifier:kBreedIntoTableViewCellIdentifier forIndexPath:indexPath];
        
        CategoryModel *mdoel = self.classifyArray[self.index - 1];
//        NSArray *tem = mdoel.secondClassModels;
        NSMutableArray *tem = [NSMutableArray array];
        
        for(int i = 0; i < 5; i++){
            [tem addObject:mdoel.chiledList[i]];
        }
        
        CategorySecondClassModel *t = [[CategorySecondClassModel alloc]init];
        
        t.categoryName = @"查看更多";
        t.childImage = @"查看更多";
        
        [tem addObject:t];
        
        [breedIntoCell setDelegate:self];
        
        [breedIntoCell setDataArray:tem];
        
        cell = breedIntoCell;
    }else{
        GoodsListTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:kGoodsListTableViewCellIdentifier forIndexPath:indexPath];
        [goodsCell setModel:self.goodsArray[indexPath.row]];
        cell = goodsCell;
    }
          
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0) {
         [self jumpGoodsDetail:self.goodsArray[indexPath.row]];
    }
}


#pragma mark - BreedIntoTableViewCellDelegate
-(void)jumpClassify:(CategorySecondClassModel *)model{
    NSString *name = model.categoryName;
    if ([name isEqualToString:@"查看更多"] == YES) {
        [self.tabBarController setSelectedIndex:1];
    }else{
        ClassifyListViewController *categoryListVC = [[ClassifyListViewController alloc]init];
        
        categoryListVC.model = model;
        
        [self.navigationController pushViewController:categoryListVC animated:YES];
    }
}

#pragma mark - getter / setter
-(UITableView *)tableView{
    if (_tableView == nil) {
        CGFloat stateH = [[UIApplication sharedApplication] statusBarFrame].size.height;
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-stateH - 40) style:UITableViewStyleGrouped];
        [_tableView setBackgroundColor:[UIColor whiteColor]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        
        
         [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BreedIntoTableViewCell class]) bundle:nil] forCellReuseIdentifier:kBreedIntoTableViewCellIdentifier];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsListTableViewCell class]) bundle:nil] forCellReuseIdentifier:kGoodsListTableViewCellIdentifier];
    }
    return _tableView;
}


-(void)setClassifyArray:(NSArray *)classifyArray{
    _classifyArray = classifyArray;
    [self.tableView reloadData];
}

-(void)setKeyString:(NSString *)keyString{
    _keyString = keyString;
    self.currentPage = @"1";
    self.goodsArray = [NSMutableArray array];
    
    self.model = [self.classifyArray objectAtIndex:self.index-1];
    
    
//    NSDictionary *param = @{@"deviceOs":@"ios", @"pageNo":@"1", @"pageSize":@"50", @"searchName":keyString,@"sort":@"total_sales_des",@"searchType":@"1", @"appToken":self.token, @"hasCoupon":[NSNumber numberWithBool:YES], @"cat":self.model.cat};
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setValue:@"ios" forKey:@"deviceOs"];
    [param setValue:@"1" forKey:@"pageNo"];
    [param setValue:@"50" forKey:@"pageSize"];
    [param setValue:[NSNumber numberWithBool:YES] forKey:@"hasCoupon"];
    [param setValue:self.keyString forKey:@"searchName"];
    [param setValue:@"total_sales_des" forKey:@"sort"];
    [param setValue:@"1" forKey:@"searchType"];
    [param setValue:self.token forKey:@"appToken"];
    
    if (self.model.cat != nil) {
        [param setValue:self.model.cat forKey:@"cat"];

    }
    
       
       [[DataManager shareInstance]getHomePageGoodsListParame:param callBack:^(NSArray *result) {
           self.goodsArray = [NSMutableArray arrayWithArray:result];
           [self.tableView reloadData];
       }];
}


-(NSString *)token{
    User *user = [[DataManager shareInstance]getUser];
    if (user == nil) {
        return @"";
    }
    return user.appToken;
}


@end
