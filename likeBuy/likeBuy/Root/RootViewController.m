//
//  RootViewController.m
//  likeBuy
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "RootViewController.h"

//分类
#import "ClassifyViewController.h"
//我的
#import "UserViewController.h"
//邀请
#import "InviteViewController.h"
//首页
//#import "IndexViewController.h"
#import "HomePageViewController.h"

//发现
#import "FindViewController.h"
//搜索
#import "SearchViewController.h"

#import "GoodsModel.h"

#import "DetailViewController.h"

#import "GoodsDetailModel.h"

#import "WantBuyView.h"

#import "WantBuyModel.h"

#import "DBManager.h"

#import "ModelTool.h"

#import "CategoryModel.h"

#import "AlibcTradeSDK/AlibcTradeSDK.h"

#import "AlibcTradeBiz/AlibcTradeShowParams.h"

#import "UserAccessChannelsModel.h"

#import "NSString+Tool.h"

#import "SearchCommandView.h"

#import "SearchListViewController.h"



static UINavigationController * searchNavController;
static UINavigationController * homeNavController;

static HomePageViewController * home;

@interface RootViewController ()<WantBuyViewDelegate, SearchCommandViewDelegate>
@property(nonatomic, strong)WantBuyView *buyView;
@property(nonatomic, strong)NSMutableArray *tites;
@property(nonatomic, strong)SearchCommandView *commandView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据
    [self initData];
    
    //初始化框架
    [self initNavigationControllers];
    //监听淘口令
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taobaoCommand) name:NOTIFICATIONCOPYTEXT object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginColor) name:NOTIFICATIONCHANGEBEGIN object:nil];
}


-(void)beginColor{
    [home beginColor];
}


-(void)initNavigationControllers{
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    //    IndexViewController *homeVC = [[IndexViewController alloc]init];
    //    UINavigationController * homeNav = [self createNavigationController:homeVC title:@"首页" imagePic:@"shouye" selecedImagePic:@"shouye2"];
    //    [viewControllers addObject:homeNav];
    //    homeNavController = homeNav;
    NSArray<CategoryModel *> *modelList;
    NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 要检查的文件目录
    NSString *filePath = [localPath  stringByAppendingPathComponent:@"categoryData.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
        NSArray *dataArray = dic[DATAS];
        modelList = [ModelTool processCategoricalData:dataArray];
        
    }
    
    HomePageViewController *homeVC = [[HomePageViewController alloc]init];
    homeVC.titles = self.tites;
    homeVC.classifyArray = modelList;
    home = homeVC;
    
    UINavigationController * homeNav = [self createNavigationController:homeVC title:@"首页" imagePic:@"shouye" selecedImagePic:@"shouye2"];
    [viewControllers addObject:homeNav];
    homeNavController = homeNav;
    
    
    ClassifyViewController *categoryVC = [[ClassifyViewController alloc]init];
    UINavigationController * categoryNav = [self createNavigationController:categoryVC title:@"分类" imagePic:@"fenlei" selecedImagePic:@"fenlei2"];
    [viewControllers addObject:categoryNav];
    
    
    //    InviteViewController *invityVC = [[InviteViewController alloc]init];
    //    UINavigationController * invityNav = [self createNavigationController:invityVC title:@"搜索" imagePic:@"yaoqing"selecedImagePic:@"yaoqing"];
    //    [viewControllers addObject:invityNav];
    
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    UINavigationController * searchNav = [self createNavigationController:searchVC title:@"搜索" imagePic:@"glass"selecedImagePic:@"glass1"];//searchfill
    searchNavController = searchNav;
    [viewControllers addObject:searchNav];
    
    
    FindViewController *discoverVC = [[FindViewController alloc]init];
    
    discoverVC.titles = @[@"精选单品", @"好货专场"];
    
    UINavigationController * discoverNav = [self createNavigationController:discoverVC title:@"发现" imagePic:@"faxian" selecedImagePic:@"faxian2"];
    [viewControllers addObject:discoverNav];
    
    UserViewController *userVC = [[UserViewController alloc]init];
    UINavigationController * userNav = [self createNavigationController:userVC title:@"我的" imagePic:@"wode" selecedImagePic:@"wode2"];
    [viewControllers addObject:userNav];
    
    self.viewControllers = viewControllers;
    
    [self taobaoCommand];
}

-(UINavigationController *)createNavigationController:(UIViewController *)controller title:(NSString *)title imagePic:(NSString *)pic selecedImagePic:(NSString *)selectPic{
    
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:controller];
    
    UIImage * picImage = [UIImage imageNamed:selectPic];
    
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:picImage selectedImage:[UIImage imageNamed:selectPic]];
    
    picImage = [picImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [nav.tabBarItem setSelectedImage:picImage];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:RGB(251, 87, 84) forKey:NSForegroundColorAttributeName];
    
    [nav.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    return nav;
}

#pragma mark - private

#pragma mark - methods

-(void)initData{
    User *user = [[DataManager shareInstance]getUser];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"qrcode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (user != nil) {
        //是否有新消息
        [[DataManager shareInstance]getNotificationRedPoint:@{@"appToken":user.appToken}];
        
        //更新用户信息
        [[DataManager shareInstance]getCustomerInfo:@{@"appToken":user.appToken} callBack:^(NSObject *object) {}];
        
        //更新二维码url
        NSDictionary *dic = @{@"appToken":user.appToken, @"deviceOs":@"ios"};
        [[DataManager shareInstance]getQrcode:dic callBack:^(NSObject *object) {
            if ([object isKindOfClass:[NSString class]] == YES) {
                NSString *tem = (NSString *)object;
                [[NSUserDefaults standardUserDefaults] setObject:tem forKey:@"qrcode"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }];
        
        //获取渠道id
        [[DataManager shareInstance]getAccessToUserChannelsIDInfo:@{@"appToken":user.appToken, @"deviceOs":@"ios"} callBack:^(NSObject *object) {
            [[DBManager shareInstance]setUserAccessModel:(UserAccessChannelsModel *)object];
        }];
        
        //绑定拼多多
        if (user.pddPid == nil) {
            [[DataManager shareInstance]getDDKPidGenerate:@{@"appToken":user.appToken, @"deviceOs":@"ios"} callback:^(Message *message) {
                [[DataManager shareInstance]getCustomerInfo:@{@"appToken":user.appToken} callBack:^(NSObject *object) {}];
            }];
        }
        
        //绑定京东
        if (user.jdlmPid == nil) {
            [[DataManager shareInstance]getJDlmPidBind:@{@"appToken":user.appToken, @"deviceOs":@"ios", @"deviceType":@"2"} callback:^(Message *message) {
                [[DataManager shareInstance]getCustomerInfo:@{@"appToken":user.appToken} callBack:^(NSObject *object) {}];
            }];
        }
        
    }
    
    //更新分类数据，确保每一次启动都是最新的分类数据
    [self updataCategoryData];
    
    //广告页
    [[DataManager shareInstance]adconfigCallBack:^(Message *message) {
        
    }];
    
    //应用是否是第一次打开
    if ([self isAppFirstRun]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:ZD_IS_APP_FIRSTRUN];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:ZD_IS_APP_FIRSTRUN];
    }
}

-(void)updataCategoryData{
    //利用mainBundle可以访问软件资源包中的任何资源
    NSBundle *bundle = [NSBundle mainBundle];

    //获得imageData.plist的全路径
    NSString *bundlePath = [bundle pathForResource:@"categoryData" ofType:@"plist"];

    NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:bundlePath];

    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"categoryData.plist"];  //获取路径
    //创建一个dic，写到plist文件里
    BOOL flag = [dataDic writeToFile:filename atomically:YES];
    if (flag == YES) {
        [[DataManager shareInstance]getAppCategoricalDataInfo:^(NSArray *result) {
        }];
    }
    
    //ios显示配置设置
    [[DataManager shareInstance]getShowconfigCallBack:^(Message *message) {}];
    
}

+(UINavigationController*) homeNavigationController{
    return homeNavController;
}

#pragma mark - 判断程序是否是更新后第一次启动
- (BOOL) isAppFirstRun{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastRunKey = [defaults objectForKey:ZD_LAST_RUN_VERSION];
    if (!lastRunKey) {
        //上次运行版本为空，说明程序第一次运行
        [defaults setObject:ZD_CURRENT_VERSION forKey:ZD_LAST_RUN_VERSION];
        return YES;
    }else if (![lastRunKey isEqualToString:ZD_CURRENT_VERSION]) {
        //有版本号，但是和当前版本号不同，说明程序刚更新了版本
        [defaults setObject:ZD_CURRENT_VERSION forKey:ZD_LAST_RUN_VERSION];
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - taobao
-(void)taobaoCommand{
    
  NSString *shareStr = [UIPasteboard generalPasteboard].string;

    if (shareStr != nil && shareStr.length > 0) {
        
        NSArray *list = [self filterString:shareStr];
        NSURL *tem = [NSURL URLWithString:shareStr];
        if (list.count > 0 && tem == nil) {
            [self analyzeTaobaoCommand:shareStr];
        }else{
            //剪切版上的文字 是纯文字
            BOOL isChinese = [shareStr isChinese];
            //剪切版上的文字 是否是纯URL
            BOOL isURL = [shareStr isURL];
            
            if (isChinese == YES || isURL == YES) {
                [homeNavController.view addSubview:self.commandView];
                [self.commandView setHidden:NO];
                [self.commandView setWordStr:shareStr];

          
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = @"";
                
            }
        }
    }
}


/// 解析淘口令
/// @param shareStr 剪切版文字
-(void)analyzeTaobaoCommand:(NSString *)shareStr{
    
    NSArray *list = [self filterString:shareStr];
           NSMutableArray *tempArray = [NSMutableArray array];
           for (int i = 0; i < list.count; i ++) {
               NSString *item = list[i];
               BOOL flag = [self isHasChineseChar:item];
               if (flag == NO) {
                   [tempArray addObject:item];
               }
           }
           
           if (tempArray.count > 0) {
               NSString *str = [tempArray lastObject];
               
               User *user = [[DataManager shareInstance]getUser];
               
               NSDictionary *dic = @{@"tkl":str, @"deviceOs":@"ios"};
               
               NSMutableDictionary *parm = [[NSMutableDictionary alloc]initWithDictionary:dic];
               if (user != nil) {
                   [parm setObject:user.appToken forKey:@"appToken"];
               }
               
               [[DataManager shareInstance]queryTKL:parm callBack:^(NSObject *object) {
                   if (object != nil) {
                       
                       GoodsDetailModel *model = (GoodsDetailModel *)object;
                       [self.buyView setModel:model];
                       
                       UIWindow * window=[UIApplication sharedApplication].keyWindow;
                       [window addSubview:self.buyView];
                       [self.buyView setHidden:NO];
                       UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                       pasteboard.string = @"";
                   }
               }];
           }
}


-(BOOL)isHasChineseChar:(NSString *)string{
    BOOL bool_value = NO;
    for (int i=0; i<[string length]; i++){
        int a = [string characterAtIndex:i];
        if (a < 0x9fff && a > 0x4e00){
            bool_value = YES;
        }
    }
    return bool_value;
}

-(NSArray *)filterString:(NSString *)str{
    NSString *pattern = @"[^\\d\\i%%u]([a-zA-Z0-9]{11})[^\\d\\i%%u]";
    
    NSRegularExpression * regular = [[NSRegularExpression alloc]initWithPattern:pattern options: NSRegularExpressionDotMatchesLineSeparators error:nil];
    NSArray *list = [regular matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    NSMutableArray *save = [NSMutableArray array];
    for (NSTextCheckingResult * match in list){
        NSString *tem = [str substringWithRange:match.range];
        if (tem.length >= 11) {
            [save addObject:tem];
        }
        
    }
    return save;
    
    /*
     设置整体匹配范围 和 匹配属性 包含所写的正则表达式字符串。
     (regular：当做一个被发现正则表达式）
     (htmlStr：当做一个检测文本)
     (NSMakeRange(0,htmlStr.length)：返回检测范围)
     简单的说就是匹配检测文本在指定范围里有多少个 符合正则表达式字符串 属性
     */
    /*
     接下来遍历一下
     NSTextCheckingResult 是一个类用来描述项目位于通过文本检查。每个对象代表了一个请求的文本内容,被发现在分析文本块。
     */
    /*
     下面才开始进行匹配
     substringWithRange: 返回一个字符串对象,其中包含的字符的接收器在一个给定的范围内
     range: 返回结果的范围,接收方代表。
     */
}

+(UINavigationController*) searchNavigationController{
    return searchNavController;
}

#pragma mark - WantBuyViewDelegate
-(void)jumpTaoBao:(GoodsDetailModel *)model{
    
    UserAccessChannelsModel *userAccess = [[DBManager shareInstance] userAccessModel];
    if (model.couponClickUrl.length > 0 && userAccess != nil) {
        BOOL taobaoFlag = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tbopen://"]];
        
        if (taobaoFlag == YES) {
            AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
            showParam.openType = AlibcOpenTypeNative;
            showParam.backUrl=@"tbopen28052033://";
            showParam.isNeedPush=YES;
            
            AlibcWebViewController* myView = [[AlibcWebViewController alloc] init];
            
            AlibcTradeTaokeParams *taoKeParams=[[AlibcTradeTaokeParams alloc] init];
            taoKeParams.pid = userAccess.pId;
            taoKeParams.adzoneId = userAccess.adzoneId;
            taoKeParams.extParams = @{@"taokeAppkey":userAccess.appKey};
            
            [[AlibcTradeSDK sharedInstance].tradeService openByUrl:model.couponClickUrl
                                                          identity:@"trade"
                                                           webView:myView.webView
                                                  parentController:self
                                                        showParams:showParam
                                                       taoKeParams:taoKeParams
                                                        trackParam:nil
                                       tradeProcessSuccessCallback:nil
                                        tradeProcessFailedCallback:nil];
        }
    }else{
        NSURL*taobaoUrl =   [NSURL URLWithString:[NSString stringWithFormat:@"tbopen://item.taobao.com/item.htm?id=%@",model.mid]];
        if ([[UIApplication sharedApplication]canOpenURL:taobaoUrl] == YES) {
            
            [[UIApplication sharedApplication] openURL:taobaoUrl options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES}  completionHandler:^(BOOL success) {
                if (success == NO) {
                    [MBProgressHUD wj_showError:@"请安装淘宝app"];
                }
            }];
        }
    }
    [self.buyView setHidden:YES];
    
}

-(void)jumpGoodsDetail:(GoodsDetailModel *)model{
    UINavigationController *nav = self.selectedViewController;
    
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    
    GoodsModel *goods = [[GoodsModel alloc]init];
    goods.numIid = model.mid;
    goods.sellerId = model.sellerId;
    
    goods.title = model.title;
    
    goods.pictUrl = model.picUrl;
    
    goods.rebateAmount = model.rebateAmount;
    
    detailVC.model = goods;
    detailVC.isHomePage = YES;
    
    detailVC.flgs = @"1";
    
    [nav pushViewController:detailVC animated:YES];
    
    [detailVC .tabBarController.tabBar setHidden:YES];
    
    [self.buyView setHidden:YES];
}

#pragma mark - SearchCommandViewDelegate
-(void)jumpSearch:(NSString *)word{
    SearchListViewController *searchListVC = [[SearchListViewController alloc]init];
    
    BOOL isJD = [word rangeOfString:@"jd.com"].location == NSNotFound ? NO : YES;
    BOOL isPdd = [word rangeOfString:@"mobile.yangkeduo.com"].location == NSNotFound ? NO : YES;

    if (isJD == YES){
        searchListVC.meunType = MeunSelectJDType;
        [searchListVC setKeyString:word];
    }
    
    if(isPdd == YES){
        NSDictionary *param = [ModelTool processingString:word];
        searchListVC.meunType = MeunSelectPDDType;
        [searchListVC setKeyString:param[@"goods_id"]];
    }
    
    if (isJD == NO && isPdd == NO) {
        searchListVC.meunType = MeunSelectTAOBAOType;
        [searchListVC setKeyString:word];
    }
    
    [homeNavController pushViewController:searchListVC animated:YES];
    
     [self.commandView setHidden:YES];
}

-(void)tapQuXiao{
    [self.commandView setHidden:YES];
}

#pragma mark - setter / getter

-(WantBuyView *)buyView{
    if (_buyView == nil) {
        _buyView = [[WantBuyView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        [_buyView setDelegate:self];
    }
    return _buyView;
}

-(SearchCommandView *)commandView{
    if (_commandView == nil) {
        _commandView = [[SearchCommandView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [_commandView setDelegate:self];
    }
    return _commandView;
}

-(NSMutableArray *)tites{
    NSMutableArray *tem = [NSMutableArray array];
    NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 要检查的文件目录
    NSString *filePath = [localPath  stringByAppendingPathComponent:@"categoryData.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
        NSArray *dataArray = dic[DATAS];
        NSArray<CategoryModel *> *modelList = [ModelTool processCategoricalData:dataArray];
        
        for (CategoryModel *item in modelList) {
            [tem addObject:item.categoryName];
        }
        
        [tem insertObject:@"首页" atIndex:0];
    }
    
    return tem;
}

@end
