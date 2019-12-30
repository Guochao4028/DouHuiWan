//
//  DetailViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "DetailViewController.h"
#import "GoodsDetailView.h"
#import "GoodsModel.h"
#import "GoodsDetailModel.h"
#import "GoodsDetailBottomView.h"
#import "RootViewController.h"
#import "PassWordToBuyView.h"
#import "CreateShareViewController.h"
#import "DBManager.h"
#import "InstallmentWebViewController.h"
#import "LoginViewController.h"

#import "AlibcTradeSDK/AlibcTradeSDK.h"
#import "AlibcTradeBiz/AlibcTradeShowParams.h"
#import "DBManager.h"
#import "UserAccessChannelsModel.h"

#import "PayPageViewController.h"

#import "WebViewController.h"

@interface DetailViewController ()<GoodsDetailBottomViewDelegate, GoodsDetailViewDelegate>

@property(nonatomic, strong)GoodsDetailView *detailView;

@property(nonatomic, strong)GoodsDetailBottomView *detailBottomView;

@property(nonatomic, strong)GoodsDetailModel *detailModel;

@property(nonatomic, strong)PassWordToBuyView *passwordBuyView;

@property(nonatomic, strong)UIView *backView;

@property(nonatomic, copy)NSString *shareString;

@property(nonatomic, assign)BOOL isfavorite;

@property(nonatomic, assign)BOOL isIosStatue;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFinish) name:LOGFINISH object:nil];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    if ([self.viewType isEqualToString:@"pdd"] == YES) {
        [self initPddData];
    }else if([self.viewType isEqualToString:@"jd"] == YES){
        [self initJDData];
    } else{
        [self initData];
    }
    
    
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    if (self.detailModel != nil) {
        [self addFootprint];
    }
    [super viewWillDisappear:animated];
}



-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.detailView];
    [self.view addSubview:self.detailBottomView];
    [self.view addSubview:self.passwordBuyView];
    [self.view addSubview:self.backView];
    [self.passwordBuyView setHidden:YES];
}

/**
 *普通的商品详情
 */
-(void)initData{
    
    User *user = [[DataManager shareInstance]getUser];
    NSString *appToken = user.appToken;
    
    if(self.model != nil){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:self.model.numIid forKey:@"mid"];
        
        [dic setObject:@"ios" forKey:@"deviceOs"];
        
        if (appToken != nil) {
            [dic setObject:appToken forKey:@"appToken"];
        }
        
        if(self.model.rebateAmount != nil){
            [dic setObject:self.model.rebateAmount forKey:@"rebateAmount"];
        }
        
        //        [dic setObject:@"v1.0" forKey:@"version"];
        
        if (self.flgs != nil) {
            [dic setObject:self.flgs forKey:@"flgs"];
        }
        
        [MBProgressHUD showActivityMessageInWindow:nil];
        
        [[DataManager shareInstance]getGoodsDetailsParame:dic callBack:^(NSObject *object) {
            [MBProgressHUD hideHUD];
            
            if (object != nil) {
                if ([object isKindOfClass:[Message class]] == YES) {
                    NSLog(@"Message");
                    Message *model = (Message *)object;
                    NSInteger code = [model.code integerValue];
                    
                    if (code == 1) {
                        
                        
                        [[DataManager shareInstance]taobaobendiAuthorizationParentController:self callBack:^(NSObject *object) {
                            
                            if (object != nil) {
                                WebViewController* webVC = [[WebViewController alloc] init];
                                
                                [self presentViewController:webVC animated:YES completion:nil];
                            }
                        }];
                        
                        //                        InstallmentWebViewController *webVC = [[InstallmentWebViewController alloc]init];
                        //                        webVC.viewController = self;
                        
                    }else if(code == -1){
                        [MBProgressHUD wj_showError:model.reason];
                        [self backAction];
                        
                    }else{
                        
                        LoginViewController *login = [[LoginViewController alloc]init];
                        [login setIsPresent:YES];
                        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
                        
                        [self presentViewController:nav animated:YES completion:nil];
                    }
                }else{
                    self.detailModel = (GoodsDetailModel *)object;
                    self.detailModel.itemDescription = self.model.itemDescription;
                    self.detailModel.sellerId = self.model.sellerId;
                    if (self.model.title != nil) {
                        self.detailModel.title = self.model.title;
                    }
                    
                    self.detailModel.rebateAmount = self.model.rebateAmount;
                    self.detailModel.numIid = self.model.numIid;
                    self.detailModel.pictUrl = self.model.pictUrl;
                    self.detailModel.goodsModel = self.model;
                    
                    
                    if (self.detailModel.shopTitle.length == 0) {
                        self.detailModel.shopTitle = self.model.shopTitle;
                    }
                    
                    if (self.detailModel.smallImages == nil) {
                        self.detailModel.smallImages = self.model.smallImages;
                    }
                    
                    if (self.detailModel.userType.length == 0) {
                        self.detailModel.userType = self.model.userType;
                    }
                    
                    if (self.detailModel.volume.length == 0) {
                        self.detailModel.volume = self.model.volume;
                    }
                    
                    if (self.detailModel.nick.length == 0) {
                        self.detailModel.nick = self.model.nick;
                    }
                    
                    if(self.model.pictUrl.length == 0){
                        self.model.pictUrl = self.detailModel.smallImages[0];
                    }
                    
                    if ([NSString stringWithFormat:@"%@",self.model.volume].length == 0) {
                        self.model.volume = self.detailModel.volume;
                    }
                    
                    if (self.model.commissionRate.length == 0) {
                        self.model.commissionRate = self.detailModel.commissionRate;
                    }
                    
                    if (self.model.couponInfo.length == 0) {
                        self.model.couponInfo = self.detailModel.couponInfo;
                    }
                    
                    if (self.model.couponInfo.length == 0) {
                        self.model.couponInfo = self.detailModel.couponInfo;
                    }
                    
                    if (self.model.couponAfterPrice.length == 0) {
                        self.model.couponAfterPrice = self.detailModel.couponAfterPrice;
                    }
                    
                    if (self.model.zkFinalPrice.length == 0) {
                        self.model.zkFinalPrice = self.detailModel.zkFinalPrice;
                    }
                    
                    if(self.model.commissionRate.length > 0){
                        self.detailModel.commissionRate = self.model.commissionRate;
                    }
                    
                    
                    [self.detailView setModel:self.detailModel];
                    
                    //                    NSString *iosStatue = self.detailModel.iosStatue;
                    //
                    //                    [self setIsIosStatue:[iosStatue boolValue]];
                    
                    
                    
                    if (self.detailModel != nil && (self.detailModel.shopTitle == nil || self.detailModel.shopTitle.length == 0)) {
                        NSDictionary *shopDic = @{@"appToken":appToken, @"mid":self.detailModel.numIid, @"model": self.detailModel};
                        
                        [[DataManager shareInstance]getGoodsShopDetail:shopDic callBack:^(NSObject *object) {
                            self.detailModel = (GoodsDetailModel *)object;
                            
                            [self.detailView setModel:self.detailModel];
                        }];
                    }
                    
                    [[DBManager shareInstance]writeData:self.detailModel];
                    
                    NSDictionary *dic = @{@"appToken":appToken, @"mid":self.detailModel.numIid, @"deviceOs":@"ios",@"userType":self.detailModel.userType};
                    [[DataManager shareInstance]goodsIsFavorite:dic callBack:^(Message *message) {
                        if (message.isSuccess == YES) {
                            self.isfavorite = YES;
                        }else{
                            self.isfavorite = NO;
                        }
                    }];
                    
                    [[DataManager shareInstance]getQrcode:dic callBack:^(NSObject *object) {
                        if ([object isKindOfClass:[NSString class]] == YES) {
                            NSString *tem = (NSString *)object;
                            self.detailModel.qrcodeUrl = tem;
                        }
                    }];
                    
                   
                    NSString *code = [[NSUserDefaults standardUserDefaults]objectForKey:SHOWCONFIG];
                    BOOL codeBool = [code boolValue];
                    [self setIsIosStatue:codeBool];
                    
                    [self.detailBottomView setModel:self.detailModel];
                    //                    [self addFootprint];
                }
            }else{
                [self backAction];
            }
        }];
    }
}

/**
 *拼多多的商品详情
 */
-(void)initPddData{
    User *user = [[DataManager shareInstance]getUser];
    NSString *appToken = user.appToken;
    
    if(self.model != nil){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@[self.model.numIid] forKey:@"goodsIdList"];
        
        [dic setObject:@"ios" forKey:@"deviceOs"];
        
        if (appToken != nil) {
            [dic setObject:appToken forKey:@"appToken"];
        }
        if (self.flgs != nil) {
            [dic setObject:self.flgs forKey:@"flgs"];
        }
        
        [MBProgressHUD showActivityMessageInWindow:nil];
        
        [[DataManager shareInstance]getPddGoodsDetail:dic callback:^(NSObject *object) {
            [MBProgressHUD hideHUD];
            if (object != nil) {
                self.detailModel = (GoodsDetailModel *)object;
                
                self.detailModel.reservePrice = self.detailModel.zkFinalPrice;
                
                [self.detailView setModel:self.detailModel];
                [[DBManager shareInstance]writeData:self.detailModel];
                NSDictionary *dic = @{@"mid":self.detailModel.numIid, @"deviceOs":@"ios",@"userType":@"3"};
                
                NSMutableDictionary *temDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                if (appToken != nil) {
                    [temDic setObject:appToken forKey:@"appToken"];
                }
                
                
                [[DataManager shareInstance]goodsIsFavorite:temDic callBack:^(Message *message) {
                    if (message.isSuccess == YES) {
                        self.isfavorite = YES;
                    }else{
                        self.isfavorite = NO;
                    }
                }];
                [[DataManager shareInstance]getQrcode:dic callBack:^(NSObject *object) {
                    if ([object isKindOfClass:[NSString class]] == YES) {
                        NSString *tem = (NSString *)object;
                        self.detailModel.qrcodeUrl = tem;
                    }
                }];
                
                
                
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                if (appToken != nil) {
                    [param setObject:appToken forKey:@"appToken"];
                }
                [param setObject:@[self.model.numIid] forKey:@"goodsIdList"];
                
                [param setObject:[NSNumber numberWithBool:YES] forKey:@"generateShortUrl"];
                [param setValue:[NSNumber numberWithBool:YES] forKey:@"generateWeappWebview"];
                
                [[DataManager shareInstance]getPddGoodsProm:param callback:^(NSObject *object) {
                    
                    NSString *urlStr = (NSString *)object;
                    
                    self.detailModel.itemUrl = urlStr;
                }];
                
                [self.detailBottomView setModel:self.detailModel];
                
                //                [self addFootprint];
                NSString *code = [[NSUserDefaults standardUserDefaults]objectForKey:SHOWCONFIG];
                BOOL codeBool = [code boolValue];
                [self setIsIosStatue:codeBool];
                
            }else{
                [self backAction];
            }
        }];
    }
}

/**
 *京东 的商品详情
 */
-(void)initJDData{
    User *user = [[DataManager shareInstance]getUser];
    NSString *appToken = user.appToken;
    if(self.model != nil){
        
        NSDictionary *jdDic = @{
            //                                @"isCoupon":@"1",
            @"deviceOs":@"ios",
            @"skuId":self.model.numIid
        };
        
        
        NSMutableDictionary *temDic = [NSMutableDictionary dictionaryWithDictionary:jdDic];
        if (appToken != nil) {
            [temDic setObject:appToken forKey:@"appToken"];
        }
        
        [[DataManager shareInstance]getJDGoodsQuery:temDic callback:^(NSArray *result) {
            
            if(result.count == 1){
                
                GoodsModel *temModel = [result lastObject];
                self.detailModel = [[GoodsDetailModel alloc]init];
                
                self.detailModel.itemDescription = temModel.itemDescription;
                self.detailModel.shopTitle = temModel.shopTitle;
                self.detailModel.couponClickUrl = temModel.couponClickUrl;
                self.detailModel.couponEndTime = temModel.couponEndTime;
                self.detailModel.sellerId = temModel.sellerId;
                self.detailModel.smallImages = temModel.smallImages;
                self.detailModel.volume = temModel.volume;
                self.detailModel.userType = @"4";
                self.detailModel.nick = temModel.nick;
                self.detailModel.couponInfo = temModel.couponInfo;
                self.detailModel.commissionRate = temModel.commissionRate;
                self.detailModel.title = temModel.title;
                self.detailModel.reservePrice = temModel.reservePrice;
                
                self.detailModel.rebateAmount = temModel.rebateAmount;
                self.detailModel.numIid = temModel.numIid;
                self.detailModel.pictUrl = temModel.pictUrl;
                self.detailModel.zkFinalPrice = temModel.zkFinalPrice;
                self.detailModel.coupon = temModel.couponInfo;
                
                self.detailModel.couponAfterPrice = temModel.couponAfterPrice;
                
                self.detailModel.materialUrl = temModel.materialUrl;
                self.detailModel.couponAfterPrice = temModel.couponAfterPrice;
                
                if (self.detailModel.couponAfterPrice == nil) {
                    self.detailModel.couponAfterPrice = temModel.zkFinalPrice;
                }
                
                if (self.model.couponInfo == nil) {
                    self.detailModel.coupon = @"0";
                }
                
                
                [self.detailView setModel:self.detailModel];
                
                
                
                
                NSDictionary *dic = @{@"mid":self.detailModel.numIid, @"deviceOs":@"ios", @"userType":@"4"};
                
                NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                if (appToken != nil) {
                    [tempDic setObject:appToken forKey:@"appToken"];
                }
                
                
                [[DataManager shareInstance]goodsIsFavorite:tempDic callBack:^(Message *message) {
                    if (message.isSuccess == YES) {
                        self.isfavorite = YES;
                    }else{
                        self.isfavorite = NO;
                    }
                }];
                
//                NSString *code = [[NSUserDefaults standardUserDefaults]objectForKey:SHOWCONFIG];
//                BOOL codeBool = [code boolValue];
//                [self setIsIosStatue:codeBool];
                
                [[DataManager shareInstance]getQrcode:tempDic callBack:^(NSObject *object) {
                    if ([object isKindOfClass:[NSString class]] == YES) {
                        NSString *tem = (NSString *)object;
                        self.detailModel.qrcodeUrl = tem;
                    }
                }];
                
                User *user = [[DataManager shareInstance]getUser];
                NSString *appToken = user.appToken;
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                if(appToken != nil)
                    [param setObject:appToken forKey:@"appToken"];
                [param setObject:self.detailModel.materialUrl forKey:@"materialId"];
                [param setObject:@"ios" forKey:@"deviceOs"];
                
                [param setValue:@"http://img14.360buyimg.com/ads/jfs/t1/106633/7/9/113088/5da58effEe868cd96/055de884adbec231.jpg" forKey:@"sukImage"];
                
                if(self.model.couponClickUrl != nil){
                    [param setObject:self.model.couponClickUrl forKey:@"couponUrl"];
                }
                
                
                [param setValue:@"45094789288" forKey:@"sukId"];
                
                [[DataManager shareInstance]getJDGoodsByunionid:param callback:^(NSObject *object) {
                    NSString *urlStr = (NSString *)object;
                    
                    self.detailModel.itemUrl = urlStr;
                }];
                
                [self.detailBottomView setModel:self.detailModel];
                
                //                [self addFootprint];
                NSString *code = [[NSUserDefaults standardUserDefaults]objectForKey:SHOWCONFIG];
                BOOL codeBool = [code boolValue];
                [self setIsIosStatue:codeBool];
            }
        }];
        
    }else{
        [self backAction];
    }
    
    
}

//跳转淘宝的立即领劵
-(void)jumpTaoBaoLingQuan{
    
    UserAccessChannelsModel *model = [[DBManager shareInstance] userAccessModel];
    
    if (self.detailModel.couponClickUrl.length > 0 && model != nil) {
        BOOL taobaoFlag = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tbopen://"]];
        
        if (taobaoFlag == YES) {
            AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
            showParam.openType = AlibcOpenTypeNative;
            showParam.backUrl=@"tbopen28052033://";
            showParam.isNeedPush=YES;
            
            AlibcWebViewController* myView = [[AlibcWebViewController alloc] init];
            
            AlibcTradeTaokeParams *taoKeParams=[[AlibcTradeTaokeParams alloc] init];
            taoKeParams.pid = model.pId;
            taoKeParams.adzoneId = model.adzoneId;
            taoKeParams.extParams = @{@"taokeAppkey":model.appKey};
            
            [[AlibcTradeSDK sharedInstance].tradeService openByUrl:self.detailModel.couponClickUrl
                                                          identity:@"trade"
                                                           webView:myView.webView
                                                  parentController:self
                                                        showParams:showParam
                                                       taoKeParams:taoKeParams
                                                        trackParam:nil
                                       tradeProcessSuccessCallback:nil
                                        tradeProcessFailedCallback:nil];
        }else{
            [self.passwordBuyView setLinkString:self.shareString];
            [self.passwordBuyView setHidden:NO];
        }
    }else{
        [self.passwordBuyView setLinkString:self.shareString];
        [self.passwordBuyView setHidden:NO];
    }
}

#pragma mark -  GoodsDetailViewDelegate
//立即领券
-(void)tapGoodsInfoView{
    BOOL isShowconfig = [DBManager shareInstance].isShowconfig;
    
    if (isShowconfig == YES) {
        
        PayPageViewController *payPageVC = [[PayPageViewController alloc]init];
        payPageVC.model = self.detailModel;
        [self.navigationController pushViewController:payPageVC animated:YES];
        
    }else{
        if ([self.viewType isEqualToString:@"pdd"] == YES) {
               NSURL *url = [NSURL URLWithString:self.detailModel.itemUrl];
               
               [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES}  completionHandler:nil];
           }else if ([self.viewType isEqualToString:@"jd"] == YES) {
               NSURL *url = [NSURL URLWithString:self.detailModel.itemUrl];
               
               [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES}  completionHandler:nil];
           } else{
               [self jumpTaoBaoLingQuan];
           }
    }
}

#pragma mark - GoodsDetailBottomViewDelegate
//收藏
-(void)tapCollection{
    
    NSLog(@"tapCollection");
    NSDictionary *dic = [self manipulationData];
    NSMutableDictionary *parame = [NSMutableDictionary dictionaryWithDictionary:dic];
    if (self.isfavorite == YES) {
        [parame setValue:@"2" forKey:@"favStatus"];
    }else{
        [parame setValue:@"1" forKey:@"favStatus"];
    }
    
    [[DataManager shareInstance]goodsFavorite:parame callBack:^(Message *message) {
        Message *model = message;
        if ([[NSString stringWithFormat:@"%@",model.code] isEqualToString:@"0"] == YES) {
            self.isfavorite = !self.isfavorite;
        }
    }];
}

-(NSDictionary *)manipulationData{
    User *user = [[DataManager shareInstance]getUser];
    NSString *appToken = user.appToken;
    NSString *jsonStr;
    if (self.detailModel.smallImages.count > 0) {
        
        NSMutableArray *imageMutableArray  = [NSMutableArray array];
        
        NSString *imageUrlStr = [self.detailModel.smallImages firstObject];
        
        [imageMutableArray addObject:imageUrlStr];
        
        NSData *data=[NSJSONSerialization dataWithJSONObject:imageMutableArray options:NSJSONWritingPrettyPrinted error:nil];
        jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }else{
        
        NSMutableArray *imageMutableArray  = [NSMutableArray array];
        
        NSString *imageUrlStr = self.detailModel.pictUrl;
        [imageMutableArray addObject:imageUrlStr];
        
        NSData *data=[NSJSONSerialization dataWithJSONObject:imageMutableArray options:NSJSONWritingPrettyPrinted error:nil];
        jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    if (self.detailModel.numIid != nil) {
        [parame setValue:self.detailModel.numIid forKey:@"mid"];
    }
    
    if (self.detailModel.couponAfterPrice != nil) {
        
        NSString *couponAfterPrice = self.detailModel.couponAfterPrice;
        
        float couponAfterPriceFloat =  [couponAfterPrice floatValue];
        
        [parame setValue:[NSString stringWithFormat:@"%.2f",couponAfterPriceFloat] forKey:@"couponAfterPrice"];
        
        //        [parame setValue:self.detailModel.couponAfterPrice forKey:@"couponAfterPrice"];
    }
    
    if (self.detailModel.zkFinalPrice != nil) {
        NSString *zkFinalPrice = self.detailModel.zkFinalPrice;
        
        float zkFloat =  [zkFinalPrice floatValue];
        
        [parame setValue:[NSString stringWithFormat:@"%.2f",zkFloat] forKey:@"zkFinalPrice"];
    }
    
    if (self.detailModel.reservePrice != nil) {
        
        NSString *reservePrice = self.detailModel.reservePrice;
        
        float reservePriceFloat =  [reservePrice floatValue];
        
        [parame setValue:[NSString stringWithFormat:@"%.2f",reservePriceFloat] forKey:@"reservePrice"];
        
        //        [parame setValue:self.detailModel.reservePrice forKey:@"reservePrice"];
    }
    
    if (self.detailModel.commissionRate != nil) {
        [parame setValue:self.detailModel.commissionRate forKey:@"commissionRate"];
    }
    
    if (self.detailModel.volume != nil) {
        [parame setValue:self.detailModel.volume forKey:@"volume"];
    }
    
    if (self.detailModel.title != nil) {
        [parame setValue:self.detailModel.title forKey:@"title"];
    }
    
    if (self.detailModel.coupon != nil) {
        [parame setValue:self.detailModel.coupon forKey:@"coupon"];
    }
    
    if (self.detailModel.couponStartTime != nil) {
        [parame setValue:self.detailModel.couponStartTime forKey:@"couponStartTime"];
    }
    
    if (self.detailModel.couponEndTime != nil) {
        [parame setValue:self.detailModel.couponEndTime forKey:@"couponEndTime"];
    }
    
    if (self.detailModel.shopTitle != nil) {
        [parame setValue:self.detailModel.shopTitle forKey:@"shopTitle"];
    }
    
    if (self.detailModel.userType != nil) {
        [parame setValue:self.detailModel.userType forKey:@"userType"];
        if (self.detailModel.nick != nil) {
            if ([self.detailModel.nick isEqualToString:@"天猫超市"]) {
                [parame setValue:@"5" forKey:@"userType"];
            }else if ([self.detailModel.nick  rangeOfString:@"天猫"].location != NSNotFound) {
                [parame setValue:@"1" forKey:@"userType"];
            }
        }else{
            [parame setValue:self.detailModel.userType forKey:@"userType"];
        }
    }
    
    if ([self.viewType isEqualToString:@"pdd"] == YES) {
        [parame setValue:@"3" forKey:@"userType"];
    }else if([self.viewType isEqualToString:@"jd"] == YES){
        [parame setValue:@"4" forKey:@"userType"];
    }
    
    
    if (appToken != nil) {
        [parame setValue:appToken forKey:@"appToken"];
    }
    
    if (jsonStr != nil) {
        [parame setValue:jsonStr forKey:@"smallImages"];
    }
    
    
    
    return [NSDictionary dictionaryWithDictionary:parame];
}

//跳转首页
-(void)jumpHomePage{
    NSLog(@"jumpHomePage");
    [self.tabBarController.tabBar setHidden:NO];
    RootViewController *vc = (RootViewController *)[[UIApplication sharedApplication].keyWindow rootViewController];
    vc.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//领券购买
-(void)tapBuy{
    NSLog(@"tapBuy");
    if ([self.viewType isEqualToString:@"pdd"] == YES) {
        NSURL *url = [NSURL URLWithString:self.detailModel.itemUrl];
        
        [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES}  completionHandler:nil];
        
//        if ([self.detailModel.itemUrl containsString:@"https://mobile.yangkeduo.com/"]){
//                NSString *skipUrlStr = [self.detailModel.itemUrl stringByReplacingOccurrencesOfString:@"https://mobile.yangkeduo.com/" withString:@"pinduoduo://com.xunmeng.pinduoduo/"];
//                NSURL *skipUrl = [NSURL URLWithString:skipUrlStr];
//                [[UIApplication sharedApplication] openURL:skipUrl options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES}  completionHandler:nil];
//        };
        
    }else if ([self.viewType isEqualToString:@"jd"] == YES) {
        NSURL *url = [NSURL URLWithString:self.detailModel.itemUrl];
        
//        [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES}  completionHandler:nil];
//        openApp.jdMobile://          
        
        
        if ([[UIApplication sharedApplication]canOpenURL:url] == YES) {
            
            [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES}  completionHandler:^(BOOL success) {
                if (success == NO) {
                    [MBProgressHUD wj_showError:@"请安装京东app"];
                }
            }];
        }
        
//              if ([[UIApplication sharedApplication]canOpenURL:url] == YES) {
//
//                  [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES}  completionHandler:^(BOOL success) {
//                      if (success == NO) {
//                          [MBProgressHUD wj_showError:@"请安装京东app"];
//                      }
//                  }];
//              }
        
    } else{
        [self jumpTaoBaoLingQuan];
    }
}

//分享奖励
-(void)tapShare{
    NSLog(@"tapShare");
    
    
    if(self.isIosStatue){
        [self.passwordBuyView setLinkString:self.shareString];
        [self.passwordBuyView setHidden:NO];
    }else{
        CreateShareViewController *createShare = [[CreateShareViewController alloc]init];
        createShare.model = self.detailModel;
        createShare.shareString = self.shareString;
        [self.navigationController pushViewController:createShare animated:YES];
    }
}

//在 showconfig是yes时的立即购买
-(void)tapNowBuy{
    NSLog(@"在 showconfig是yes时的立即购买 \n tapNowBuy");
    
    PayPageViewController *payPageVC = [[PayPageViewController alloc]init];
    payPageVC.model = self.detailModel;
    [self.navigationController pushViewController:payPageVC animated:YES];
}

-(void)loginFinish{
    
    if ([self.viewType isEqualToString:@"pdd"] == YES) {
        
    }else{
        [self initData];
    }
}

#pragma mark - action
-(void)backAction{
    if (self.isHomePage == YES) {
        if (self.navigationController.childViewControllers.count > 2) {
            [self.tabBarController.tabBar setHidden:YES];
        }else{
            [self.tabBarController.tabBar setHidden:NO];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 添加足迹
-(void)addFootprint{
    NSDictionary *dic = [self manipulationData];
    NSMutableDictionary *parame = [NSMutableDictionary dictionaryWithDictionary:dic];
    [parame setObject:@"1" forKey:@"favStatus"];
    [[DataManager shareInstance]footprint:parame];
}

#pragma mark - setter / getter
-(GoodsDetailView *)detailView{
    if (_detailView == nil) {
        //        CGFloat barHeight = [[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? [[UIApplication sharedApplication] statusBarFrame].size.height : 0;
        _detailView = [[GoodsDetailView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49 - BOTTOM_MARGIN_HEIGHT)];
        [_detailView setDelegate:self];
    }
    return _detailView;
}

-(GoodsDetailBottomView *)detailBottomView{
    if (_detailBottomView == nil) {
        _detailBottomView = [[GoodsDetailBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.detailView.frame), ScreenWidth, 49)];
        [_detailBottomView setDelegate:self];
    }
    return _detailBottomView;
}

-(UIView *)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(9,self.detailView.mj_y, 100, 100)];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"fang"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:_backView.bounds];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -70, 0, 0)];
        [_backView addSubview:button];
    }
    return _backView;
}

-(PassWordToBuyView *)passwordBuyView{
    if (_passwordBuyView == nil) {
        _passwordBuyView = [[PassWordToBuyView alloc]initWithFrame:self.view.bounds];
        
    }
    return _passwordBuyView;
}

-(NSString *)shareString{
    
    User *user = [[DataManager shareInstance]getUser];
    
    NSMutableString *mutableStr = [[NSMutableString alloc]init];
    
    if (self.detailModel.title.length > 0) {
        [mutableStr appendString:[NSString stringWithFormat:@"%@\n", self.detailModel.title]];
    }
    
    if (self.detailModel.itemDescription.length > 0) {
        [mutableStr appendString:[NSString stringWithFormat:@"%@\n", self.detailModel.itemDescription]];
    }
    
    if([self.detailModel.zkFinalPrice isKindOfClass: [NSString class]] == YES){
        if (self.detailModel.zkFinalPrice.length > 0) {
            [mutableStr appendString:[NSString stringWithFormat:@"【券后价】%@元\n", self.detailModel.zkFinalPrice]];
        }
    }else{
        [mutableStr appendString:[NSString stringWithFormat:@"【券后价】%@元\n", self.detailModel.zkFinalPrice]];
    }
    
    //    if (self.detailModel.zkFinalPrice.length > 0) {
    //        [mutableStr appendString:[NSString stringWithFormat:@"【折扣价】%@元\n", self.detailModel.zkFinalPrice]];
    //    }
    
    
    if([self.detailModel.couponAfterPrice isKindOfClass: [NSString class]] == YES){
        if (self.detailModel.couponAfterPrice.length > 0) {
            [mutableStr appendString:[NSString stringWithFormat:@"【券后价】%@元\n", self.detailModel.couponAfterPrice]];
        }
    }else{
        [mutableStr appendString:[NSString stringWithFormat:@"【券后价】%@元\n", self.detailModel.couponAfterPrice]];
    }
    
    BOOL isShowconfig = [DBManager shareInstance].isShowconfig;
    
    if (isShowconfig == NO) {
        [mutableStr appendString:@"-----------------\n"];
        
        [mutableStr appendString:[NSString stringWithFormat:@"请在APP商城搜索 【豆会玩】\n【邀请码】%@\n", user.selfResqCode]];
        [mutableStr appendString:@"-----------------\n"];
    }
    
    
    if ([self.viewType isEqualToString:@"pdd"] == YES) {
        [mutableStr appendString:[NSString stringWithFormat:@"长按復·制这段描述，%@，打开【📱拼多多】即可抢购",self.detailModel.itemUrl]];
    }else if([self.viewType isEqualToString:@"jd"] == YES){
        [mutableStr appendString:[NSString stringWithFormat:@"长按復·制这段描述，%@，打开【📱京东】即可抢购",self.detailModel.itemUrl]];
    }else{
        [mutableStr appendString:[NSString stringWithFormat:@"长按復·制这段描述，%@，打开【📱taobao】即可抢购",self.detailModel.couponTpwd]];
    }
    
    
    
    NSString *str = [NSString stringWithFormat:@"%@", mutableStr];
    
    return str;
}

-(void)setIsfavorite:(BOOL)isfavorite{
    _isfavorite = isfavorite;
    
    if (isfavorite == NO) {
        if ([self.delegate respondsToSelector:@selector(detailViewController:cancelCollection:)]) {
            [self.delegate detailViewController:self cancelCollection:self.model];
        }
    }
    
    
    self.detailModel.isfavorite = isfavorite == YES?@"1":@"0";
    
    [[DBManager shareInstance]writeData:self.detailModel];
    
    [self.detailBottomView setIsfavorite:isfavorite];
}

-(void)setIsIosStatue:(BOOL)isIosStatue{
    _isIosStatue = isIosStatue;
    
    [self.detailBottomView setIsIosStatue:isIosStatue];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
