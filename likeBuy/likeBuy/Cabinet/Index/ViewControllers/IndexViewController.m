//
//  IndexViewController.m
//  likeBuy
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "IndexViewController.h"
#import "NavigationView.h"
#import "SearchBarView.h"
#import "BannerTableViewCell.h"
#import "EntranceTableViewCell.h"
#import "LargerEntranceTableViewCell.h"
#import "DeadlineTableViewCell.h"
#import "GoodsListTableViewCell.h"
#import "GuessLikeTableViewCell.h"
#import "ModelTool.h"
#import "LoginViewController.h"
#import "DetailViewController.h"
#import "FlashSnapperViewController.h"
#import "AllCategoriesViewController.h"
#import "CategorySecondClassModel.h"

#import "ClassifyListViewController.h"

#import "ImageAndGoodsTableViewCell.h"

#import "DBManager.h"
#import "UserAccessChannelsModel.h"
#import "AlibcTradeSDK/AlibcTradeSDK.h"
#import "AlibcTradeBiz/AlibcTradeShowParams.h"

#import "BannerModel.h"

#import "LaunchViewController.h"

#import "NewAddViewController.h"

#import "InstallmentWebViewController.h"
#import "ALPTBLinkPartnerSDK.h"

#import "PddGoodsOpt.h"
#import "PddIndexViewController.h"

#import "JDIndexViewController.h"
#import "JDCategoryModel.h"

#import "ZeroViewController.h"
#import "ImageTableViewCell.h"
#import "WebViewController.h"
#import "EnterModel.h"


static NSString *const kBannerTableViewCellIdentifier = @"BannerTableViewCell";
static NSString *const kImageTableViewCellIdentifier = @"ImageTableViewCell";

static NSString *const kGoodsListTableViewCellIdentifier = @"GoodsListTableViewCell";

static NSString *const kEntranceTableViewCellIdentifier = @"EntranceTableViewCell";

static NSString *const kLargerEntranceTableViewCellIdentifier = @"LargerEntranceTableViewCell";

static NSString *const kDeadlineTableViewCellIdentifier = @"DeadlineTableViewCell";

static NSString *const kGuessLikeTableViewCellIdentifier = @"GuessLikeTableViewCell";

static NSString *const kImageAndGoodsTableViewCellIdentifier = @"ImageAndGoodsTableViewCell";



@interface IndexViewController ()<UITableViewDelegate, UITableViewDataSource, EntranceTableViewCellDelegate, LargerEntranceTableViewCellDelegate, DeadlineTableViewCellDelegate, GuessLikeTableViewCellDelegate, SearchBarViewDelegate, ImageAndGoodsTableViewCellDelegate, BannerTableViewCellDelegate, GoodsListTableViewCellDelegate, ImageTableViewCellDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NavigationView *navigationView;

@property(nonatomic, strong)SearchBarView *searchBarView;

//banner
@property (nonatomic,strong)NSArray  *bannerArray;

//top100
@property(nonatomic, strong)NSArray *top100Array;

//白菜价
@property(nonatomic, strong)NSArray *baiCaiArray;

//限量秒杀
@property(nonatomic, strong)NSArray *setLimitArray;

//推荐好物
@property(nonatomic, strong)NSMutableArray *goodsArray;

//猜你喜欢
@property(nonatomic, strong)NSArray *guessYouArray;

//品牌清仓
@property(nonatomic, strong)NSArray *brandClearanceArray;

//实时热销
@property(nonatomic, strong)NSArray *hotSellingArray;

@property(nonatomic, strong)NSString *currentPage;

@property(nonatomic, copy)NSString *token;

@property(nonatomic, strong)NSArray *titles;

@property(nonatomic, assign)BOOL colorFlag;

@property(nonatomic, strong)NSArray *timeLimitTitles;


/***
 *拼多多分类数组
 *pddgoodsOpt 数据模型
 */
@property(nonatomic, strong)NSArray *pddClassifyArray;

/***
 *拼多多 存储分类name数组
 */
@property(nonatomic, strong)NSArray *pddClassifyTitleArray;


/***
 *京东类目数组
 *JDCategoryModel 数据模型
 */
@property(nonatomic, strong)NSArray *jdClassifyArray;

/***
 *京东 存储 类目name数组
 */
@property(nonatomic, strong)NSArray *jdClassifyTitleArray;

/**
 0元购 存储 数组
 */
@property(nonatomic, strong)NSArray *zeroPurchaseArray;

/**
 * 存储显示的字典
 */
@property(nonatomic, strong)NSDictionary *showConfigDic;


// 布局专用字典 (第一部分)
@property(nonatomic, strong)NSMutableArray *showConfigArray;

//是否是零元购
@property(nonatomic, assign)BOOL isZero;

/**
 *入口数组
 */
@property(nonatomic, strong)NSArray *enterArray;

@property(nonatomic, strong)UIView *bgView;


@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
    
    [self.tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColors:) name:NOTIFICATIONCHANGE object:nil];
       
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColorsEnd:) name:NOTIFICATIONCHANGEEND object:nil];
    
}

-(void)initUI{
//    [self.view setBackgroundColor:WHITE];
    [self.view setBackgroundColor:[UIColor clearColor]];

    [self.view addSubview:self.bgView];
    
    [self.view addSubview:self.tableView];
}

-(void)initData{
    
    self.showConfigArray = [NSMutableArray array];
    
    //ios显示配置设置
    [[DataManager shareInstance]getShowconfigCallBack:^(Message *message) {}];
    
    //强制更新
    [[DataManager shareInstance]forcedUpdate:@{@"deviceOs":@"ios"} callBack:^(Message *message) {
        if (message.isSuccess == YES) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更新" message:@"检查到有新的版本" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
                exit(0);
            }];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSString *urlStr = [NSString stringWithFormat:@"%@", [DBManager shareInstance].qinggengUrl];
                //打开链接地址
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES}  completionHandler:^(BOOL success) {
                }];
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
    
    [[DataManager shareInstance]getBannerConfigCallBack:^(NSDictionary *result) {
        
        self.showConfigDic = result;
        if(result[@"0"] != nil){
            //入口
            self.enterArray = [EnterModel mj_objectArrayWithKeyValuesArray:result[@"0"]];
            
            [self.tableView reloadData];
            [self.showConfigArray addObject:@"入口"];
        }
        
        if(result[@"1"] != nil){
            //top100
            NSDictionary *top100Dic = @{@"saleType":@"2", @"cid":@"0", @"pageNo":@"1", @"deviceOs":@"ios"};
            [[DataManager shareInstance]getTop100GoodsListParame:top100Dic callBack:^(Message *message) {
                self.top100Array = message.modelList;
                [self.tableView reloadData];
            }];
            
            [self.showConfigArray addObject:@"top100"];
        }
        
        if(result[@"2"] != nil){
            //白菜价
            NSDictionary *courier99Dic = @{@"sort":@"0", @"pageSize":@"10", @"pageNo":@"1", @"deviceOs":@"ios", @"cid":@"0", @"nav":@"1"};
            [[DataManager shareInstance]get99CourierGoodsListParame:courier99Dic callBack:^(Message *message) {
                self.baiCaiArray = message.modelList;
                [self.tableView reloadData];
            }];
            BOOL isbool = [self.showConfigArray containsObject: @"top100"];
            if (isbool == NO ) {
                [self.showConfigArray addObject:@"top100"];
            }
            
        }
        
        if(result[@"3"] != nil){
            //限量秒杀
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH"];
            //现在时间,你可以输出来看下是什么格式
            NSDate *datenow = [NSDate date];
            NSString *currentTimeString = [formatter stringFromDate:datenow];
            NSInteger hours = [currentTimeString integerValue];
            NSString *itemStr;
            if (hours < 10) {
                itemStr = @"6";
            }else if (hours >= 10 && hours <= 12){
                
                itemStr = @"7";
            }else if (hours >= 12 && hours <= 15){
                itemStr = @"8";
            }else if (hours >= 15 && hours <= 20){
                itemStr = @"9";
            }else{
                itemStr = @"10";
            }
            NSDictionary *dic = @{@"saleType":@"2", @"hourType":itemStr, @"pageNo":@"1", @"deviceOs":@"ios", @"appToken":self.token};
            
            [[DataManager shareInstance]flashParame:dic callBack:^(Message *message) {
                self.setLimitArray = message.modelList;
                [self.tableView reloadData];
            }];
            [self.showConfigArray addObject:@"限量秒杀"];
        }
        
        [self.showConfigArray addObject:@"image1"];
        
        if(result[@"4"] != nil){
            
            //品牌清仓
            NSDictionary *brandClearanceDic = @{@"materialId":@"13366",@"deviceOs":@"ios", @"appToken":self.token};
            [[DataManager shareInstance]brandClearanceParame:brandClearanceDic callBack:^(NSArray *result) {
                self.brandClearanceArray = result;
                [self.tableView reloadData];
            }];
            [self.showConfigArray addObject:@"品牌清仓"];
        }
        
        [self.showConfigArray addObject:@"image2"];
        
        if(result[@"5"] != nil){
            //实时热销
            
            //top100
            NSDictionary *hotSellingDic = @{@"saleType":@"1", @"cid":@"0", @"pageNo":@"1", @"deviceOs":@"ios"};
            [[DataManager shareInstance]getTop100GoodsListParame:hotSellingDic callBack:^(Message *message) {
                self.hotSellingArray = message.modelList;
                [self.tableView reloadData];
            }];
            [self.showConfigArray addObject:@"实时热销"];
        }
        
        if(result[@"6"] != nil){
            //猜你喜欢
            NSDictionary *guessYouDic = @{@"materialId":@"",@"deviceOs":@"ios", @"appToken":self.token};
            [[DataManager shareInstance]guessYouLikeParame:guessYouDic callBack:^(NSArray *result) {
                self.guessYouArray = result;
                [self.tableView reloadData];
            }];
        }
        
        if(result[@"7"] != nil){
           //淘礼金
            [[DataManager shareInstance]getTaoLiJinList:@{@"deviceOs":@"ios"} callBack:^(NSArray *result) {
                NSLog(@"result : %@", result);
                self.zeroPurchaseArray = result;
                [self.tableView reloadData];
            }];
            
            [self.showConfigArray addObject:@"0元嗨购"];
        }
        
        if(result[@"8"] != nil){
            //推荐好物
            self.currentPage = @"1";
            self.goodsArray = [NSMutableArray array];
            NSDictionary *param = @{@"deviceOs":@"ios", @"pageNo":@"1", @"pageSize":@"50", @"searchName":@"\"\"", @"appToken":self.token, @"hasCoupon":[NSNumber numberWithBool:YES], @"sort":@"total_sales_des",@"searchType":@"1"};
            
            [[DataManager shareInstance]getHomePageGoodsListParame:param callBack:^(NSArray *result) {
                self.goodsArray = [NSMutableArray arrayWithArray:result];
                [self.tableView reloadData];
            }];
        }
        
    }];
    
    //banner
    [[DataManager shareInstance]getHomePageFirstPartition:^(NSDictionary *result) {
        self.bannerArray = result[@"banner"];
        [self.tableView reloadData];
    }];
    
    //拼多多 查询商品目录列表
    [[DataManager shareInstance]getDDKGoodsOpt:@{@"parentId":@"0"} callback:^(NSArray *result) {
        self.pddClassifyArray = result;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (PddGoodsOpt *temp in self.pddClassifyArray) {
            [tempArray addObject:temp.optName];
        }
        self.pddClassifyTitleArray = [NSArray arrayWithArray:tempArray];
    }];
    
    //京东 查询商品类目
    [[DataManager shareInstance]getJDGoodsCategory:@{@"type":@"1"} callback:^(NSArray *result) {
        self.jdClassifyArray = result;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (JDCategoryModel *temp in self.jdClassifyArray) {
            [tempArray addObject:temp.categoryName];
        }
        self.jdClassifyTitleArray = [NSArray arrayWithArray:tempArray];
    }];
}

-(void)refreshData{
    
    [self.tableView.mj_header beginRefreshing];
    
    [self initData];
    
    [[DataManager shareInstance]getHomePageFirstPartition:^(NSDictionary *result) {
        self.bannerArray = result[@"banner"];
        [self.tableView reloadData];
    }];
    
    if(self.showConfigDic[@"10"] != nil){
        self.currentPage = @"1";
        self.goodsArray = [NSMutableArray array];
        
        NSDictionary *param = @{@"deviceOs":@"ios", @"pageNo":self.currentPage, @"pageSize":@"50", @"searchName":@"\"\"",@"sort":@"total_sales_des",@"searchType":@"1", @"appToken":self.token, @"hasCoupon":[NSNumber numberWithBool:YES]};
        
        [[DataManager shareInstance]getHomePageGoodsListParame:param callBack:^(NSArray *result) {
            self.goodsArray = [NSMutableArray arrayWithArray:result];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }];
    }else{
        [self.tableView.mj_header endRefreshing];
    }
    
}

-(void)loadMoreData{
    
    if(self.showConfigDic[@"10"] != nil){
        NSInteger cp = [self.currentPage integerValue];
        cp++;
        self.currentPage = [NSString stringWithFormat:@"%ld",(long)cp];
        
        NSDictionary *param = @{@"deviceOs":@"ios", @"pageNo":self.currentPage, @"pageSize":@"15", @"searchName":@"\"\"",@"sort":@"total_sales_des",@"searchType":@"1",@"hasCoupon":[NSNumber numberWithBool:YES]};
        
        [[DataManager shareInstance]getHomePageGoodsListParame:param callBack:^(NSArray *result) {
            [self.goodsArray addObjectsFromArray:result];
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        }];
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
}

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


-(void)changeColors:(NSNotification *)notification{
    
    NSDictionary *dic = notification.userInfo;
    UIColor *currColor = dic[@"bgColor"];
    [self.navigationView setBackgroundColor:currColor];
    [self.bgView setBackgroundColor:currColor];
}

-(void)changeColorsEnd:(NSNotification *)notification{
//    NSDictionary *dic = notification.userInfo;
    [self.bgView setBackgroundColor:WHITE];
    [self.navigationView setBackgroundColor:WHITE];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY >= 160) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATIONCHANGEEND object:nil userInfo:@{@"bgColor":[UIColor whiteColor]}];
        
        self.colorFlag = YES;
        
    }else{
        
        if (self.colorFlag == YES) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATIONCHANGEBEGIN object:nil userInfo:nil];
            self.colorFlag = NO;
        }
        
        
    }
}


#pragma mark - 跳转第三方 app
-(void)jumpThirdPartyApp:(JumpThirdPartyType)type{
    
    User * user = [[DataManager shareInstance] getUser];
    if (user == nil || user.loginState == NO) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        BOOL taobaoFlag = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tbopen://"]];
        
        UserAccessChannelsModel *model = [[DBManager shareInstance] userAccessModel];
        
        AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
        showParam.openType = AlibcOpenTypeNative;
        showParam.backUrl=@"tbopen28052033://";
        showParam.isNeedPush=YES;
        //    showParam.linkKey = @"tmall";//拉起天猫
        
        AlibcWebViewController* myView = [[AlibcWebViewController alloc] init];
        
        AlibcTradeTaokeParams *taoKeParams=[[AlibcTradeTaokeParams alloc] init];
        taoKeParams.pid = model.pId;
        taoKeParams.adzoneId = model.adzoneId;
        if (model != nil) {
            taoKeParams.extParams = @{@"taokeAppkey":model.appKey};
        }
        
        if (taobaoFlag == YES) {
            NSString *openUrl;
            DBManager *manager = [DBManager shareInstance];
            switch (type) {
                case JumpThirdPartyTypeTianMaoXinPin:
                    openUrl = manager.tianmaoXinpinUrl;
                    break;
                case JumpThirdPartyTypeFeiZhu:
                    openUrl = manager.feizuUrl;
                    break;
                case JumpThirdPartyTypeJinRiBaoKuan:
                    openUrl = manager.todayKaoKuanUrl;
                    break;
                case JumpThirdPartyTypeELeM:
                    openUrl = @"https://www.ele.me/home/";
                    break;
                case JumpThirdPartyTypeTianMaoGuoJi:
                    openUrl = manager.tianmaoGuoJiUrl;
                    break;
                case JumpThirdPartyTypeTianMaoChaoShi:
                    openUrl = @"https://chaoshi.tmall.com";
                    break;
                    
                default:
                    break;
            }
            
            
            [[AlibcTradeSDK sharedInstance].tradeService openByUrl:openUrl
                                                          identity:@"trade"
                                                           webView:myView.webView
                                                  parentController:self
                                                        showParams:showParam
                                                       taoKeParams:taoKeParams
                                                        trackParam:@{}
                                       tradeProcessSuccessCallback:nil
                                        tradeProcessFailedCallback:nil];
        }
    }
}

#pragma mark -  UITableViewDelegate & UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    NSInteger sectionsNumber = 1;
    
    if (self.guessYouArray.count > 0) {
        sectionsNumber ++;
    }
    
    if (self.goodsArray.count > 0 ) {
        sectionsNumber ++;
    }
    return sectionsNumber;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        // tag 首页
        //        UIView *nav = [[UIView alloc]init];
        //        [nav addSubview:self.navigationView];
        //        [nav addSubview:self.searchBarView];
        //        [self.searchBarView setFrame:CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), ScreenWidth, 34)];
        //        return nav;
    }else if (section == 1 || section == 2) {
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = WHITE;
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(21, 26, 72, 25)];
        [titleLabel setFont:[UIFont fontWithName:MediumFont size:16]];
        [titleLabel setTextColor:[UIColor blackColor]];
        
        NSString *str;
        if (section == 1) {
            str = @"猜你喜欢";
        }else{
            str = @"推荐好物";
        }
        [titleLabel setText:str];
        [view addSubview:titleLabel];
        view.backgroundColor = [UIColor purpleColor];

        return view;
    }
    
    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor clearColor];
    view.backgroundColor = [UIColor purpleColor];

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
    
    CGFloat sectionH = 0;
    
    if (section > 0) {
        if ((self.guessYouArray.count > 0) ||(self.goodsArray.count > 0) ) {
            sectionH = 64;
        }
    }
    return sectionH;
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor clearColor];
    view.backgroundColor = [UIColor purpleColor];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger rowNumber = 0;
    if (section == 0) {
        //banner 占 一行
        rowNumber = 3;
        
        if (self.enterArray.count > 0) {
            rowNumber ++;
        }
        
        if(self.top100Array.count > 0){
            rowNumber ++;
        }
        
        if (self.setLimitArray.count > 0) {
            rowNumber ++;
        }
        if (self.brandClearanceArray.count > 0) {
            rowNumber ++;
        }
        if (self.hotSellingArray.count > 0) {
            rowNumber ++;
        }
        if (self.zeroPurchaseArray.count > 0) {
            rowNumber ++;
        }
    }
    
    
    if(self.guessYouArray.count > 0 && self.goodsArray.count > 0){
        if (section == 1) {
            rowNumber = 1;
        }else if (section == 2){
            rowNumber = self.goodsArray.count;
        }
    }else{
        if (section > 0 && self.guessYouArray.count > 0) {
            rowNumber = 1;
        }
        
        if(section > 0 && self.goodsArray.count > 0){
            rowNumber = self.goodsArray.count;
        }
    }
    
    return rowNumber;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tableViewH = 0;

    if (indexPath.section == 0) {
        
        if(indexPath.row == 0){
            //banner
            tableViewH = 160;
        }else{
            if (self.showConfigArray.count > 0) {
                NSInteger index = indexPath.row - 1;
                
                NSString *str = self.showConfigArray[index];
                
                if ([str isEqualToString:@"入口"] == YES) {
                    tableViewH = 170;
                }else if ([str isEqualToString:@"top100"] == YES){
                    tableViewH = 155;
                }else if ([str isEqualToString:@"0元嗨购"] == YES){
                    tableViewH = 80;
                }else if ([str isEqualToString:@"image1"] == YES){
                    tableViewH = 120;
                }else if ([str isEqualToString:@"image2"] == YES){
                    tableViewH = 120;
                }else{
                    tableViewH = 242;
                }
            }
        }
    }else{
        if(self.guessYouArray.count > 0 && self.goodsArray.count > 0){
            if (indexPath.section == 1) {
                tableViewH = 162;
            }else{
                tableViewH = 140;
            }
        }else{
            if (indexPath.section > 0 && self.guessYouArray.count > 0) {
                tableViewH = 162;
            }
            
            if(indexPath.section > 0 && self.goodsArray.count > 0){
                tableViewH = 140;
            }
        }
    }
    
    return tableViewH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell= [[UITableViewCell alloc]init];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //banner
            BannerTableViewCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:kBannerTableViewCellIdentifier];
            bannerCell.dataSource = self.bannerArray;
            
            [bannerCell setDelegate:self];
            cell = bannerCell;
            return cell;
        }else{
            
            if (self.showConfigArray.count > 0) {
                
                NSInteger index = indexPath.row - 1;
                
                NSString *str = self.showConfigArray[index];
                
                if ([str isEqualToString:@"入口"] == YES) {
                    
                    //10个按钮 入口
                    EntranceTableViewCell *entranceCell = [tableView dequeueReusableCellWithIdentifier:kEntranceTableViewCellIdentifier];
                    [entranceCell setDelegate:self];
                    [entranceCell setDataArray:self.enterArray];
                    cell = entranceCell;
                    
                }else if ([str isEqualToString:@"top100"] == YES){
                    LargerEntranceTableViewCell *largerEntranceCell = [tableView dequeueReusableCellWithIdentifier:kLargerEntranceTableViewCellIdentifier ];
                    [largerEntranceCell setDelegate:self];
                    
                    largerEntranceCell.top100Array = self.top100Array;
                    largerEntranceCell.baiCaiArray = self.baiCaiArray;
                    cell = largerEntranceCell;
                }else if([str isEqualToString:@"限量秒杀"] == YES){
                    //限量秒杀
                    DeadlineTableViewCell *deadlineCell = [tableView dequeueReusableCellWithIdentifier:kDeadlineTableViewCellIdentifier ];
                    [deadlineCell setDataList:self.setLimitArray];
                    [deadlineCell setDelegate:self];
                    [deadlineCell setType:0];
                    [deadlineCell setTimeArray:self.timeLimitTitles];
                    cell = deadlineCell;
                }else if([str isEqualToString:@"品牌清仓"] == YES){
                    //品牌清仓
                    DeadlineTableViewCell *deadlineCell = [tableView dequeueReusableCellWithIdentifier:kDeadlineTableViewCellIdentifier ];
                    [deadlineCell setDataList:self.brandClearanceArray];
                    [deadlineCell setDelegate:self];
                    [deadlineCell setTitleStr:@"品牌清仓"];
                    [deadlineCell setAtMoreStr:@"更多"];
                    [deadlineCell setType:1];
                    cell = deadlineCell;
                }else if([str isEqualToString:@"实时热销"] == YES){
                    //实时热销
                    DeadlineTableViewCell *deadlineCell = [tableView dequeueReusableCellWithIdentifier:kDeadlineTableViewCellIdentifier];
                    [deadlineCell setDataList:self.hotSellingArray];
                    [deadlineCell setTitleStr:@"实时热销"];
                    [deadlineCell setDelegate:self];
                    [deadlineCell setAtMoreStr:@"更多"];
                    [deadlineCell setType:2];
                    cell = deadlineCell;
                }else if([str isEqualToString:@"0元嗨购"] == YES){
                    ImageTableViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:kImageTableViewCellIdentifier forIndexPath:indexPath];
                    
                    [imageCell setDelegate:self];
                    [imageCell setImageName:@"0YuanBanner"];
                                   
                    cell = imageCell;
                }else if([str isEqualToString:@"image1"] == YES){
                    ImageTableViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:kImageTableViewCellIdentifier forIndexPath:indexPath];
                    
                    [imageCell setDelegate:self];
                    [imageCell setImageName:@"shuiguo"];
                                   
                    cell = imageCell;
                }else if([str isEqualToString:@"image2"] == YES){
                    ImageTableViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:kImageTableViewCellIdentifier forIndexPath:indexPath];
                    
                    [imageCell setDelegate:self];
                    [imageCell setImageName:@"pinzhi"];
                                   
                    cell = imageCell;
                }
                
            }
        }
    }
    
    if(self.guessYouArray.count > 0 && self.goodsArray.count > 0){
        if (indexPath.section == 1){
            if (indexPath.row == 0) {
                
                GuessLikeTableViewCell *guessLikeCell = [tableView dequeueReusableCellWithIdentifier:kGuessLikeTableViewCellIdentifier forIndexPath:indexPath];
                guessLikeCell.dataList = self.guessYouArray;
                [guessLikeCell setDelegate:self];
                cell = guessLikeCell;
                
            }
        }else if (indexPath.section == 2){
            GoodsListTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:kGoodsListTableViewCellIdentifier];
            [goodsCell setModel:self.goodsArray[indexPath.row]];
            [goodsCell setDelegate:self];
            cell = goodsCell;
        }
    }else{
        if (indexPath.section > 0 && self.guessYouArray.count > 0) {
            if (indexPath.row == 0) {
                
                GuessLikeTableViewCell *guessLikeCell = [tableView dequeueReusableCellWithIdentifier:kGuessLikeTableViewCellIdentifier forIndexPath:indexPath];
                guessLikeCell.dataList = self.guessYouArray;
                [guessLikeCell setDelegate:self];
                cell = guessLikeCell;
                
            }
        }
        
        if(indexPath.section > 0 && self.goodsArray.count > 0){
            //            GoodsListTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:kGoodsListTableViewCellIdentifier forIndexPath:indexPath];
            GoodsListTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:kGoodsListTableViewCellIdentifier];
            [goodsCell setModel:self.goodsArray[indexPath.row]];
            [goodsCell setDelegate:self];
            cell = goodsCell;
        }
    }
    
    
    return cell;
}

#pragma mark - BannerTableViewCellDelegate

-(void)pushToOtherViewControllerwithHomeItem:(BannerModel *)item{
    NSString *url = item.toUrl;
    if (url.length > 0) {
        [self.tabBarController.tabBar setHidden:YES];
        LaunchViewController *controller =  [[LaunchViewController alloc]initWithUrl:url];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - EntranceTableViewCellDelegate
-(void)tableViewCell:(EntranceTableViewCell *)cell selectItem:(NSInteger)tag{
    
    JumpThirdPartyType jumptype = 0;
    
    switch (tag) {
        case 101:
        case 102:
        case 103:
        case 104:
        case 105:{
            NSString *str;
            NSString *title;
            NSString *icon;
            BOOL isJump = NO;
            switch (tag) {
                case EntrancePinddType:{
                    str = @"EntrancePinddType";
                    title = @"拼多多";
                    icon = @"0";
                }
                    break;
                case EntranceJingdongType:{
                    str = @"EntranceJingdongType";
                    title = @"京东";
                    icon = @"1";
                }
                    break;
                case EntranceChaoShiType:{
                    str = @"EntranceChaoShiType";
                    title = @"天猫超市";
                    icon = @"2";
                    jumptype = JumpThirdPartyTypeTianMaoChaoShi;
                    isJump = YES;
                }
                    break;
                case EntranceTaoBaoType:{
                    str = @"EntranceTaoBaoType";
                    title = @"淘宝";
                    icon = @"3";
                    jumptype = JumpThirdPartyTypeTianMaoGuoJi;
                    isJump = YES;
                }
                    break;
                case EntranceTianMaoType:{
                    str = @"EntranceTianMaoType";
                    title = @"天猫";
                    icon = @"4";
                    jumptype = JumpThirdPartyTypeTianMaoXinPin;
                    isJump = YES;
                }
                    break;
                default:
                    jumptype = 0;
                    break;
            }
            
            User * user = [[DataManager shareInstance] getUser];
            if(tag == EntrancePinddType){
                if (user != nil) {
                    if (user.pddPid == nil || user.pddPid.length == 0) {
                        [[DataManager shareInstance]getDDKPidGenerate:@{@"appToken":user.appToken, @"deviceOs":@"ios"} callback:^(Message *message) {
                            [[DataManager shareInstance]getCustomerInfo:@{@"appToken":user.appToken} callBack:^(NSObject *object) {}];
                        }];
                    }
                }
                
                PddIndexViewController *pddIndexVC = [[PddIndexViewController alloc]init];
                pddIndexVC.titles = self.pddClassifyTitleArray;
                pddIndexVC.titleStr = @"拼多多";
                pddIndexVC.optArray = self.pddClassifyArray;
                [self.navigationController pushViewController:pddIndexVC animated:YES];
                
            }else if (tag == EntranceJingdongType){
                
                if (user != nil) {
                 
                    if (user.jdlmPid == nil || user.jdlmPid.length == 0) {
                        [[DataManager shareInstance]getJDlmPidBind:@{@"appToken":user.appToken, @"deviceOs":@"ios", @"deviceType":@"2"} callback:^(Message *message) {
                            [[DataManager shareInstance]getCustomerInfo:@{@"appToken":user.appToken} callBack:^(NSObject *object) {}];
                        }];
                    }
                }
                
                JDIndexViewController *jdIndexVC = [[JDIndexViewController alloc]init];
                jdIndexVC.titles = self.jdClassifyTitleArray;
                jdIndexVC.titleStr = @"京东";
                jdIndexVC.categoryArray = self.jdClassifyArray;
                [self.navigationController pushViewController:jdIndexVC animated:YES];
                
            }else{
                BOOL taobaoFlag = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tbopen://"]];
                if (taobaoFlag == YES && isJump == YES) {
                    [self jumpThirdPartyApp:jumptype];
                    return;
                }
                
                
                CategorySecondClassModel *model = [[CategorySecondClassModel alloc]init];
                model.categoryName = title;
                ClassifyListViewController *categoryListVC = [[ClassifyListViewController alloc]init];
                categoryListVC.iconDic = @{@"type":icon, @"title":title};
                categoryListVC.isViewImage = YES;
                categoryListVC.model = model;
                [self.navigationController pushViewController:categoryListVC animated:YES];
            }
            
        }
            break;
        case 106:
        case 108:{
            
            
            if (tag == 106) {
                BOOL taobaoFlag = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tbopen://"]];
                if (taobaoFlag == YES) {
                    [self jumpThirdPartyApp:JumpThirdPartyTypeJinRiBaoKuan];
                    return;
                }
            }
            
            AllCategoriesViewController *allCategoriesVC = [[AllCategoriesViewController alloc]init];
            if (tag == 108) {
                allCategoriesVC.titleStr = @"9.9包邮";
                allCategoriesVC.vcType = ViewController99BaoYouType;
            }else if(tag == 106){
                allCategoriesVC.titleStr = @"今日爆款";
                allCategoriesVC.vcType = ViewControllerJuHuaSuanType;
            }
            allCategoriesVC.titles = self.titles;
            [self.navigationController pushViewController:allCategoriesVC animated:YES];
        }
            break;
            
        case 107:{
            FlashSnapperViewController *flashSnapperVC = [[FlashSnapperViewController alloc]init];
            flashSnapperVC.titleStr = @"限时秒杀";
            flashSnapperVC.vcType = ViewControllerXianShiType;
            [self.navigationController pushViewController:flashSnapperVC animated:YES];
        }
            break;
        case 109:{
            
            BOOL taobaoFlag = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tbopen://"]];
            if (taobaoFlag == YES) {
                [self jumpThirdPartyApp:JumpThirdPartyTypeFeiZhu];
                return;
            }
            
            CategorySecondClassModel *model = [[CategorySecondClassModel alloc]init];
            model.categoryName = @"自由行";
            ClassifyListViewController *categoryListVC = [[ClassifyListViewController alloc]init];
            categoryListVC.isViewImage = NO;
            categoryListVC.model = model;
            [self.navigationController pushViewController:categoryListVC animated:YES];
        }
            break;
        case 110:{
            BOOL taobaoFlag = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tbopen://"]];
            if (taobaoFlag == YES) {
                [self jumpThirdPartyApp:JumpThirdPartyTypeELeM];
                return;
            }
            
            CategorySecondClassModel *model = [[CategorySecondClassModel alloc]init];
            model.categoryName = @"自营";
            ClassifyListViewController *categoryListVC = [[ClassifyListViewController alloc]init];
            categoryListVC.isViewImage = NO;
            categoryListVC.model = model;
            [self.navigationController pushViewController:categoryListVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - LargerEntranceTableViewCellDelegate
-(void)tableViewCell:(LargerEntranceTableViewCell *)cell tapItem:(NSInteger)tag{
    
    AllCategoriesViewController *allCategoriesVC = [[AllCategoriesViewController alloc]init];
    if (tag == 111) {
        allCategoriesVC.titleStr = @"TOP100·爆款";
        allCategoriesVC.titles = self.titles;
        allCategoriesVC.vcType = ViewControllerTop100Type;
    }else if (tag == 112){
        allCategoriesVC.titleStr = @"白菜价必抢";
        allCategoriesVC.titles = @[@"9.9疯抢", @"19.9热销", @"39.9封顶"];
        allCategoriesVC.vcType = ViewControllerBaiCaiJiaType;
    }
    
    [self.navigationController pushViewController:allCategoriesVC animated:YES];
    
}

#pragma mark - DeadlineTableViewCellDelegate
-(void)deadlineTableCell:(DeadlineTableViewCell *)cell tapChange:(NSInteger)tap{
    if (tap == 0) {
        FlashSnapperViewController *flashSnapperVC = [[FlashSnapperViewController alloc]init];
        flashSnapperVC.titleStr = @"限时秒杀";
        flashSnapperVC.vcType = ViewControllerXianShiType;
        [self.navigationController pushViewController:flashSnapperVC animated:YES];
    }else if(tap == 1){
        NewAddViewController *newAddVC = [[NewAddViewController alloc]init];
        newAddVC.titles = @[@"按优惠券额排序",@"按佣金比率排序",@"品牌尖货"];
        newAddVC.titleStr = @"品牌清仓";
        newAddVC.vcType = ViewControllerPinPaiQinCangType;
        newAddVC.type = tap;
        [self.navigationController pushViewController:newAddVC animated:YES];
    }else if(tap == 2){
        NewAddViewController *newAddVC = [[NewAddViewController alloc]init];
        newAddVC.titles = self.titles;
        newAddVC.titleStr = @"实时热销";
        newAddVC.vcType = ViewControllerShiShiReXiaoType;
        newAddVC.type = tap;
        [self.navigationController pushViewController:newAddVC animated:YES];
    }
}

-(void)deadlineTableCell:(DeadlineTableViewCell *)cell tapGoodsItem:(GoodsModel *)model{
    [self jumpGoodsDetail:model];
}

#pragma mark - GuessLikeTableViewCellDelegate
-(void)guessLikeTableViewCell:(GuessLikeTableViewCell *)cell tapGoodsItem:(GoodsModel *)model{
    [self jumpGoodsDetail:model];
}

#pragma mark - ImageAndGoodsTableViewCellDelegate
-(void)imageAndGoodsTableViewCell:(ImageAndGoodsTableViewCell *)cell tapGoodsItem:(GoodsModel *)model{
    [self jumpGoodsDetail:model];
}

#pragma mark - GoodsListTableViewCellDelegate
-(void)tapGoodsListTableViewCell:(GoodsModel *)item{
    [self jumpGoodsDetail:item];
}

#pragma mark - ImageTableViewCellDelegate
-(void)tapImageTableViewCell{
    User * user = [[DataManager shareInstance] getUser];
    if (user == nil || user.loginState == NO) {
        LoginViewController *login = [[LoginViewController alloc]init];
        [login setIsPresent:YES];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
        
        [self presentViewController:nav animated:YES completion:nil];
        
    }else if(user.tbUserId.length == 0 || user.relationId.length == 0) {
        [[DataManager shareInstance]taobaobendiAuthorizationParentController:self callBack:^(NSObject *object) {
            
            if (object != nil) {
                WebViewController* webVC = [[WebViewController alloc] init];
                
                [self presentViewController:webVC animated:YES completion:nil];
            }
        }];
        
    }else{
        ZeroViewController *zeroVC = [[ZeroViewController alloc]init];
        [self.navigationController pushViewController:zeroVC animated:YES];
        
    }

}

-(void)jumpPage:(NSString *)str{
    if ([str isEqualToString:@"shuiguo"] == YES) {
        CategorySecondClassModel *model = [[CategorySecondClassModel alloc]init];
        model.categoryName = @"水果";
        ClassifyListViewController *categoryListVC = [[ClassifyListViewController alloc]init];
        categoryListVC.isViewImage = NO;
        categoryListVC.model = model;
        [self.navigationController pushViewController:categoryListVC animated:YES];
    }else  if ([str isEqualToString:@"pinzhi"] == YES){
        CategorySecondClassModel *model = [[CategorySecondClassModel alloc]init];
        model.categoryName = @"品质";
        ClassifyListViewController *categoryListVC = [[ClassifyListViewController alloc]init];
        categoryListVC.isViewImage = NO;
        categoryListVC.model = model;
        [self.navigationController pushViewController:categoryListVC animated:YES];
    }
}

#pragma mark -  SearchBarViewDelegate
-(void)jumpSearchView{
    NSLog(@"jumpSearchView");
    [self.tabBarController setSelectedIndex:2];
}

#pragma mark - getter /  setter

-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) type:NavigationDaXie];
        [_navigationView setDaxieTitleStr:@"首页"];
    }
    return _navigationView;
}

-(SearchBarView *)searchBarView{
    if (_searchBarView == nil) {
        _searchBarView = [[SearchBarView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 34)];
        [_searchBarView setDelegate:self];
    }
    return _searchBarView;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGFloat stateH = [[UIApplication sharedApplication] statusBarFrame].size.height;
        //        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, stateH, ScreenWidth, ScreenHeight - stateH) style:(UITableViewStyleGrouped)];
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - stateH) style:(UITableViewStyleGrouped)];
        
        
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView registerClass:[BannerTableViewCell class] forCellReuseIdentifier:kBannerTableViewCellIdentifier];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([EntranceTableViewCell class]) bundle:nil] forCellReuseIdentifier:kEntranceTableViewCellIdentifier];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LargerEntranceTableViewCell class]) bundle:nil] forCellReuseIdentifier:kLargerEntranceTableViewCellIdentifier];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DeadlineTableViewCell class]) bundle:nil] forCellReuseIdentifier:kDeadlineTableViewCellIdentifier];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GuessLikeTableViewCell class]) bundle:nil] forCellReuseIdentifier:kGuessLikeTableViewCellIdentifier];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsListTableViewCell class]) bundle:nil] forCellReuseIdentifier:kGoodsListTableViewCellIdentifier];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ImageAndGoodsTableViewCell class]) bundle:nil] forCellReuseIdentifier:kImageAndGoodsTableViewCellIdentifier];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ImageTableViewCell class]) bundle:nil] forCellReuseIdentifier:kImageTableViewCellIdentifier];
        
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setBackgroundColor:[UIColor clearColor]];
        
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

-(NSArray *)titles{
    
    return @[@"全部",@"女装",@"母婴",@"美妆", @"居家日用",@"鞋品",@"美食",@"文娱车品",@"数码家电",@"男装",@"内衣",@"箱包",@"配饰",@"户外运动",@"家装家纺"];
}

-(UIView *)bgView{
    
    if (_bgView == nil) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 160 - 34)];
    }
    return _bgView;
}




-(NSArray *)timeLimitTitles {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSInteger hours = [currentTimeString integerValue];
    
    if (hours < 10) {
        return @[@{@"title":@"00:00"},
                 @{@"title":@"10:00"},
                 @{@"title":@"12:00"},];
    }else if (hours >= 10 && hours < 12){
        return @[
                 @{@"title":@"10:00"},
                 @{@"title":@"12:00"},
                 @{@"title":@"15:00"},
                 ];
    }else if (hours >= 12 && hours < 15){
        return @[
                 @{@"title":@"12:00"},
                 @{@"title":@"15:00"},
                 @{@"title":@"20:00"},];
    }else if (hours >= 15 && hours < 20){
        return @[@{@"title":@"00:00"},
                 @{@"title":@"10:00"},
                 @{@"title":@"20:00"},];
    }else{
        return @[@{@"title":@"00:00"},
                 @{@"title":@"10:00"},
                 @{@"title":@"12:00"},
                ];
    }
    
    
    return @[@{@"title":@"00:00"},
             @{@"title":@"10:00"},
             @{@"title":@"12:00"},
             ];
}


@end
