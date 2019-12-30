//
//  ParticularsViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "ParticularsViewController.h"
#import "NavigationView.h"
#import "FDSlideBar.h"
#import "FloatHeader.h"

#import "ParticularsTableViewCell.h"

#define kSliderHeight 49


static NSString *const kParticularsTableViewCellIdentifier = @"ParticularsTableViewCell";
@interface ParticularsViewController ()<NavigationViewDelegate,UIScrollViewDelegate, UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)NavigationView *navigationView;

@property (nonatomic,strong) FDSlideBar *sliderView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL objectCanScroll;
@property (nonatomic, assign) BOOL isSelectIndex;

@property (nonatomic, strong)UITableView *ingTabelView;
@property (nonatomic, strong)UITableView *finishTabelView;

@property(nonatomic, strong)NSMutableArray *ingArray;
@property(nonatomic, strong)NSMutableArray *finishArray;

@property(nonatomic, strong)NSString *currentPage;

@end

@implementation ParticularsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
    
   
}


-(void)initUI{
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"FAFAFA"]];
    [self.view addSubview:self.navigationView];
    [self.navigationView setTitleStr:@"提现明细"];
    [self.view addSubview:self.sliderView];
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.ingTabelView];
    
    [self.scrollView addSubview:self.finishTabelView];
    
}

-(void)initData{
    
    User *user = [[DataManager shareInstance]getUser];
    
    self.currentPage = @"1";
    
    NSDictionary *ingDic = @{@"appToken":user.appToken, @"pageNo": self.currentPage,@"pageSize":@"50", @"checkFlg":@"0,1,2", @"type":@"0"};
    
    [[DataManager shareInstance]getExtractList:ingDic callBack:^(NSArray *result) {
        
        self.ingArray = [NSMutableArray arrayWithArray:result];
        
        NSDictionary *finishDic = @{@"appToken":user.appToken, @"pageNo": self.currentPage,@"pageSize":@"50", @"checkFlg":@"3", @"type":@"1"};
        
        [[DataManager shareInstance]getExtractList:finishDic callBack:^(NSArray *result) {
            self.finishArray = [NSMutableArray arrayWithArray:result];
            
            [self.ingTabelView reloadData];
            [self.finishTabelView reloadData];
        }];
    }];
}

-(void)loadData{
    
    NSInteger cp = [self.currentPage integerValue];
    cp++;
    self.currentPage = [NSString stringWithFormat:@"%ld",(long)cp];
    
    User *user = [[DataManager shareInstance]getUser];
    
    NSDictionary *ingDic = @{@"appToken":user.appToken, @"pageNo": self.currentPage,@"pageSize":@"50", @"checkFlg":@"0,1,2", @"type":@"0"};
    
    [[DataManager shareInstance]getExtractList:ingDic callBack:^(NSArray *result) {
        
        [self.ingArray addObjectsFromArray:result];
        
        NSDictionary *finishDic = @{@"appToken":user.appToken, @"pageNo": self.currentPage,@"pageSize":@"50", @"checkFlg":@"3", @"type":@"1"};
        
        [[DataManager shareInstance]getExtractList:finishDic callBack:^(NSArray *result) {
            
            [self.finishArray addObjectsFromArray:result];
            
            [self.ingTabelView reloadData];
            [self.finishTabelView reloadData];
            
            [self.finishTabelView.mj_footer endRefreshing];
            
            [self.ingTabelView.mj_footer endRefreshing];
        }];
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
    if (tableView == self.ingTabelView) {
        return self.ingArray.count;
    }

    if (tableView == self.finishTabelView) {
        return self.finishArray.count;
    }
    
    return 10;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tableViewH = 0;
    
    tableViewH = 80;
    
    return tableViewH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ParticularsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kParticularsTableViewCellIdentifier];
    if (tableView == self.ingTabelView) {
        [cell setModel: [self.ingArray objectAtIndex:indexPath.row]];
    }

    if (tableView == self.finishTabelView) {

        [cell setModel: [self.finishArray objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark -

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



#pragma mark - NavigationViewDelegate

-(void)back{
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController popViewControllerAnimated:YES];
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
        NSArray *itemArr=@[@"全部",@"已到账"];
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


-(UITableView *)ingTabelView{
    if (_ingTabelView == nil) {
        _ingTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
        [_ingTabelView setDelegate:self];
        [_ingTabelView setDataSource:self];
        
        [_ingTabelView registerNib:[UINib nibWithNibName:NSStringFromClass([ParticularsTableViewCell class]) bundle:nil] forCellReuseIdentifier:kParticularsTableViewCellIdentifier];
        
        _ingTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_ingTabelView setBackgroundColor:[UIColor colorWithHexString:@"#FAFAFA"]];
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        _ingTabelView.mj_footer = footer;
    }
    
    return _ingTabelView;
}


-(UITableView *)finishTabelView{
    if (_finishTabelView == nil) {
        _finishTabelView = [[UITableView alloc]initWithFrame:CGRectMake(1 * ScreenWidth, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
        
        [_finishTabelView setDelegate:self];
        [_finishTabelView setDataSource:self];
        
     
        [_finishTabelView registerNib:[UINib nibWithNibName:NSStringFromClass([ParticularsTableViewCell class]) bundle:nil] forCellReuseIdentifier:kParticularsTableViewCellIdentifier];
        
        _finishTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_finishTabelView setBackgroundColor:[UIColor colorWithHexString:@"FAFAFA"]];
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        _finishTabelView.mj_footer = footer;
    }
    
    return _finishTabelView;
}


@end
