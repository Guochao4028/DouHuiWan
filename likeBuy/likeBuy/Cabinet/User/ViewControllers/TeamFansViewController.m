//
//  TeamFansViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "TeamFansViewController.h"
#import "NavigationView.h"

#import "FDSlideBar.h"
#import "FloatHeader.h"
#import "FansModel.h"

#import "TeamTableViewCell.h"

#import "TeamDetailsView.h"

static NSString *const kTeamTableViewCellIdentifier = @"TeamTableViewCell";

#define kSliderHeight 49

@interface TeamFansViewController ()<NavigationViewDelegate,UIScrollViewDelegate, UITableViewDelegate,UITableViewDataSource, TeamDetailsViewDelegate>
//导航
@property(nonatomic, strong)NavigationView *navigationView;
@property (nonatomic,strong) FDSlideBar *sliderView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL objectCanScroll;
@property (nonatomic, assign) BOOL isSelectIndex;

@property (nonatomic, strong)UITableView *exclusiveTabelView;
@property (nonatomic, strong)UITableView *ordinaryTabelView;

@property (nonatomic, strong)TeamDetailsView *detailsView;

@property(nonatomic, copy)NSString *zhuanshuTitle;

@property(nonatomic, copy)NSString *putongTitle;

@property(nonatomic, strong)NSMutableArray *zhuanshuArray;
@property(nonatomic, strong)NSMutableArray *putongArray;

@property(nonatomic, copy)NSString *ordinaryCurr;
@property(nonatomic, copy)NSString *exclusiveCurr;

@property(nonatomic, copy)NSString *token;

@end


@implementation TeamFansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
    
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"FAFAFA"]];
    [self.view addSubview:self.navigationView];
    [self.navigationView setTitleStr:@"团队粉丝"];
    [self.view addSubview:self.sliderView];
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.exclusiveTabelView];
    [self.scrollView addSubview:self.ordinaryTabelView];
    
    [self.view addSubview:self.detailsView];
    [self.detailsView setHidden:YES];
}

-(void)initData{
    
    self.ordinaryCurr = @"1";
    self.exclusiveCurr = @"1";
    
    self.zhuanshuArray = [NSMutableArray array];
    
    self.putongArray = [NSMutableArray array];
    
    User *user = [[DataManager shareInstance]getUser];
    NSDictionary *dic = @{@"fansType":@"1", @"appToken":user.appToken, @"pageNo":self.ordinaryCurr, @"pageSize":@"8"};
    
    [[DataManager shareInstance]selectFans:dic callBack:^(NSArray *result) {
        [self.zhuanshuArray addObjectsFromArray:result];
        
        [self.exclusiveTabelView reloadData];
        
        NSDictionary *dic = @{@"fansType":@"2", @"appToken":user.appToken, @"pageNo":self.exclusiveCurr, @"pageSize":@"8"};
        
        [[DataManager shareInstance]selectFans:dic callBack:^(NSArray *result) {
            [self.putongArray addObjectsFromArray:result];
            [self.ordinaryTabelView reloadData];
            
            FansModel *zhuanshu = [self.zhuanshuArray lastObject];
            FansModel *putong = [self.putongArray lastObject];
            
            
            NSInteger zhuanshuNumber = [zhuanshu.numberStr integerValue];
            
            self.zhuanshuTitle = [NSString stringWithFormat:@"专属粉丝%ld", zhuanshuNumber];
            
            NSInteger putongNumber = [putong.numberStr integerValue];
            
            self.putongTitle = [NSString stringWithFormat:@"普通粉丝%ld", putongNumber];
            
            [self.sliderView setUpdataTitle:@[self.zhuanshuTitle, self.putongTitle]];
            
        }];
        
    } ];
}

-(void)loadingExclusiveData{
    
    NSInteger cp = [self.exclusiveCurr integerValue];
    cp++;
    self.exclusiveCurr = [NSString stringWithFormat:@"%ld",(long)cp];
    NSDictionary *dic = @{@"fansType":@"1", @"appToken":self.token, @"pageNo":self.exclusiveCurr, @"pageSize":@"8"};
    
    [[DataManager shareInstance]selectFans:dic callBack:^(NSArray *result) {
        [self.zhuanshuArray addObjectsFromArray:result];
        [self.exclusiveTabelView reloadData];
        [self.exclusiveTabelView.mj_footer endRefreshing];
    }];
}

-(void)loadingOrdinaryData{
    
    NSInteger cp = [self.ordinaryCurr integerValue];
    cp++;
    self.ordinaryCurr = [NSString stringWithFormat:@"%ld",(long)cp];
    NSDictionary *dic = @{@"fansType":@"2", @"appToken":self.token, @"pageNo":self.ordinaryCurr, @"pageSize":@"8"};
    
    [[DataManager shareInstance]selectFans:dic callBack:^(NSArray *result) {
        [self.putongArray addObjectsFromArray:result];
        [self.ordinaryTabelView reloadData];
        [self.ordinaryTabelView.mj_footer endRefreshing];
    }];
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
    if (tableView == self.ordinaryTabelView) {
        return self.putongArray.count;
    }
    
    if (tableView == self.exclusiveTabelView) {
        return self.zhuanshuArray.count;
    }
    return 10;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tableViewH = 0;
    
    tableViewH = 115;
    
    return tableViewH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTeamTableViewCellIdentifier];
    
    if (tableView == self.exclusiveTabelView) {
        
        User *user = [[DataManager shareInstance]getUser];
        [cell setName:user.shortName];
        [cell setModel: [self.zhuanshuArray objectAtIndex:indexPath.row]];
    }
    
    if (tableView == self.ordinaryTabelView) {
        
        [cell setModel: [self.putongArray objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FansModel *model;
    
    if (tableView == self.exclusiveTabelView) {
        model = [self.zhuanshuArray objectAtIndex:indexPath.row];
    }
    
    if (tableView == self.ordinaryTabelView) {
        
        model = [self.putongArray objectAtIndex:indexPath.row];
    }
    
    [self.detailsView setModel:model];
    
    [self.detailsView setHidden:NO];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isSelectIndex = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 为了横向滑动的时候，外层的tableView不动
    if (!self.isSelectIndex) {
        //        self.tableView.scrollEnabled = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        NSUInteger page = scrollView.contentOffset.x/ScreenWidth;
        [UIView animateWithDuration:0.5 animations:^{
            [self.sliderView selectSlideBarItemAtIndex:page];
        }];
        //        self.tableView.scrollEnabled = YES;
    }
}

#pragma mark - TeamDetailsViewDelegate

-(void)tapSelf{
    [self.detailsView setHidden:YES];
}

#pragma mark - NavigationViewDelegate

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - getter / setter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sliderView.frame), ScreenWidth, ScreenHeight-CGRectGetMaxY(self.sliderView.frame))];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 2, _scrollView.frame.size.height);
    }
    return _scrollView;
}

-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_navigationView setDelegate:self];
    }
    return _navigationView;
}

- (FDSlideBar *)sliderView{//滑块部分可任意替换
    if (!_sliderView) {
        NSArray *itemArr=@[self.zhuanshuTitle,self.putongTitle];
        _sliderView = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), ScreenWidth, kSliderHeight)];
        _sliderView.backgroundColor = [UIColor whiteColor];
        _sliderView.itemsWidth= ScreenWidth /itemArr.count;
        _sliderView.itemsTitle = itemArr;
        _sliderView.itemColor = [UIColor colorWithHexString:@"272829"];
        _sliderView.itemSelectedColor = [UIColor colorWithHexString:@"f2441c"];
        _sliderView.sliderColor = [UIColor colorWithHexString:@"f2441c"];
        [_sliderView slideBarItemSelectedCallback:^(NSUInteger idx) {
            [UIView animateWithDuration:0.5 animations:^{
            }];
            
            [self.scrollView setContentOffset:CGPointMake(idx*SCREEN_WIDTH, 0) animated:YES];
        }];
    }
    return _sliderView;
}

-(UITableView *)ordinaryTabelView{
    if (_ordinaryTabelView == nil) {
        _ordinaryTabelView = [[UITableView alloc]initWithFrame:CGRectMake(1 * ScreenWidth, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
        [_ordinaryTabelView setDelegate:self];
        [_ordinaryTabelView setDataSource:self];
        
        [_ordinaryTabelView registerNib:[UINib nibWithNibName:NSStringFromClass([TeamTableViewCell class]) bundle:nil] forCellReuseIdentifier:kTeamTableViewCellIdentifier];
        
        _ordinaryTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_ordinaryTabelView setBackgroundColor:[UIColor colorWithHexString:@"#FAFAFA"]];
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadingOrdinaryData)];
        _ordinaryTabelView.mj_footer = footer;
    }
    
    return _ordinaryTabelView;
}

-(UITableView *)exclusiveTabelView{
    if (_exclusiveTabelView == nil) {
        _exclusiveTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0 * ScreenWidth, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
        
        [_exclusiveTabelView setDelegate:self];
        [_exclusiveTabelView setDataSource:self];
        [_exclusiveTabelView registerNib:[UINib nibWithNibName:NSStringFromClass([TeamTableViewCell class]) bundle:nil] forCellReuseIdentifier:kTeamTableViewCellIdentifier];
        _exclusiveTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_exclusiveTabelView setBackgroundColor:[UIColor colorWithHexString:@"#FAFAFA"]];
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadingExclusiveData)];
        _exclusiveTabelView.mj_footer = footer;
    }
    
    return _exclusiveTabelView;
}

-(TeamDetailsView *)detailsView{
    if (_detailsView == nil) {
        _detailsView = [[TeamDetailsView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [_detailsView setDelegate:self];
    }
    return _detailsView;
}

-(void)setUser:(User *)user{
    
    if (user != nil) {
        [[DataManager shareInstance]getCustomerInfo:@{@"appToken":user.appToken} callBack:^(NSObject *object) {
        }];
    }
    
    _user = [[DataManager shareInstance]getUser];
    NSString *directFans = _user.directFans;
    NSString *otherFans = _user.otherFans;
    
    self.zhuanshuTitle = [NSString stringWithFormat:@"专属粉丝%@", directFans];
    self.putongTitle = [NSString stringWithFormat:@"普通粉丝%@", otherFans];
}

-(NSString *)token{
    User *user = [[DataManager shareInstance]getUser];
    if (user == nil) {
        return @"";
    }
    return user.appToken;
}

@end
