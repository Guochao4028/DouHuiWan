//
//  DataManager.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 郭超. All rights reserved.
//
#import "DataManager.h"

#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibabaAuthSDK/ALBBSDK.h>
#import <AlibabaAuthSDK/ALBBSession.h>
#import <AlibabaAuthSDK/ALBBUser.h>

#import "GoodsModel.h"
#import "GoodsDetailModel.h"
#import "ShopModel.h"
#import "CategoryModel.h"
#import "CategorySecondClassModel.h"

#import "Message.h"

#import "ParticularsModel.h"
//
//#import "WantBuyModel.h"
#import "ShopModel.h"

#import "ModelTool.h"

#import "DBManager.h"

#import "FansModel.h"

#import "NSString+Tool.h"

#import "ZeroModel.h"




@interface DataManager()

@property(strong, nonatomic)AFHTTPSessionManager *manager;
@property (nonatomic, strong) User * user;

@end

@implementation DataManager

/**********************首页*************************/
/** 获取首页第一分区数据 */
-(void)getHomePageFirstPartition:(NSDictionaryCallBack)call{
    [self.manager POST:ADD(URL_POST_IMSCATEGOORY_HOMEPAGE) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataArray = dic[DATAS];
        
        for (NSDictionary *tem in dataArray) {
            NSString *name =  tem[@"name"];
            
            NSString *toUrl = tem[@"toUrl"];
            
            if ([name isEqualToString:@"app介绍"] == YES) {
                [[DBManager shareInstance]setAppUrl:toUrl];
            }
            
            if ([name isEqualToString:@"会员升级"] == YES) {
                [[DBManager shareInstance]setPromotionUrl:toUrl];
            }
            
            if ([name isEqualToString:@"机票酒店"] == YES) {
                [[DBManager shareInstance]setFeizuUrl:toUrl];
            }
            
            if ([name isEqualToString:@"今日爆款"] == YES) {
                [[DBManager shareInstance]setTodayKaoKuanUrl:toUrl];
            }
            
            if ([name isEqualToString:@"天猫新品"] == YES) {
                [[DBManager shareInstance]setTianmaoXinpinUrl:toUrl];
            }
            
            if ([name isEqualToString:@"天猫国际"] == YES) {
                [[DBManager shareInstance]setTianmaoGuoJiUrl:toUrl];
            }
            
        }
        
        
        NSDictionary *dataDic = [ModelTool processBannerData:dataArray];
        call(dataDic);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/** 获取首页商品列表数据*/
-(void)getHomePageGoodsListParame:(NSDictionary *)param callBack:(NSArrayCallBack)call{
    
    // todo 拼接token
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:param];
    
    User *user = [[DataManager shareInstance]getUser];
    
    if (user != nil) {
        [dic  setObject:user.appToken forKey:@"appToken"];
    }
    
    [self.manager POST:ADD(URL_POST_THIRDPARTY_TBKMATERIALGET) parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataArray = dic[DATAS];
        
        NSArray *goodsList = [GoodsModel mj_objectArrayWithKeyValuesArray:dataArray];
        
        call(goodsList);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/** 获取 top100数据 */
-(void)getTop100GoodsListParame:(NSDictionary *)param callBack:(MessageCallBack)call{
    
    // todo 拼接token
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:param];
    
    User *user = [[DataManager shareInstance]getUser];
    
    if (user != nil) {
        [dic  setObject:user.appToken forKey:@"appToken"];
    }
    
    [self.manager POST:ADD(URL_POST_DINGDANXIA_TABKTOP100) parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataArray = dic[DATAS];
        NSArray *goodsList = [GoodsModel mj_objectArrayWithKeyValuesArray:dataArray];
        Message *message = [[Message alloc]init];
        message.modelList = goodsList;
        message.reason = dic[@"message"];
        call(message);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/** 获取 9.9包邮 数据 */
-(void)get99CourierGoodsListParame:(NSDictionary *)param callBack:(MessageCallBack)call{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:param];
    
    User *user = [[DataManager shareInstance]getUser];
    
    if (user != nil) {
        [dic  setObject:user.appToken forKey:@"appToken"];
    }
    
    [self.manager POST:ADD(URL_POST_DINGDANXIA_TABKSPKJIUKUAIJIU) parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        //        NSLog(@"dic : %@", dic);
        
        NSArray *dataArray = dic[DATAS];
        
        NSArray *goodsList = [GoodsModel mj_objectArrayWithKeyValuesArray:dataArray];
        Message *message = [[Message alloc]init];
        message.modelList = goodsList;
        message.reason = dic[@"message"];
        call(message);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/** 获取 猜你喜欢 数据 */
-(void)guessYouLikeParame:(NSDictionary *)param callBack:(NSArrayCallBack)call{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:param];
    User *user = [[DataManager shareInstance]getUser];
    
    if (user != nil) {
        [dic  setObject:user.appToken forKey:@"appToken"];
    }
    
    [self.manager POST:ADD(URL_POST_DINGDANXIA_TBKOPTIMUS) parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataArray = dic[DATAS];
        
        NSArray *goodsList = [GoodsModel mj_objectArrayWithKeyValuesArray:dataArray];
        
        call(goodsList);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/**
 获取 限时抢购 数据
 */
-(void)flashParame:(NSDictionary *)param callBack:(MessageCallBack)call{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:param];
    
    User *user = [[DataManager shareInstance]getUser];
    
    if (user != nil) {
        [dic  setObject:user.appToken forKey:@"appToken"];
    }
    
    [self.manager POST:ADD(URL_POST_DINGDANXIA_DDXIASPKQQIANG) parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataArray = dic[DATAS];
        
        NSArray *goodsList = [GoodsModel mj_objectArrayWithKeyValuesArray:dataArray];
        
        Message *messageModel = [[Message alloc]init];
        [messageModel setModelList:goodsList];
        [messageModel setReason:dic[@"message"]];
        
        call(messageModel);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/**
 *品牌清仓
 */
-(void)brandClearanceParame:(NSDictionary *)param callBack:(NSArrayCallBack)call{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:param];
    
    User *user = [[DataManager shareInstance]getUser];
    
    if (user != nil) {
        [dic  setObject:user.appToken forKey:@"appToken"];
    }
    
    [self.manager POST:ADD(URL_POST_DINGDANXIA_TBKOPTIMUS) parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataArray = dic[DATAS];
        
        NSArray *goodsList = [GoodsModel mj_objectArrayWithKeyValuesArray:dataArray];
        
        call(goodsList);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}


/*********************************登录**********************************/

/** 获取 验证码 */
-(void)getSmsParame:(NSDictionary *)param callBack:(MessageCallBack)call{
    [self.manager POST:ADD(URL_POST_CUSTOMER_SENDSMS) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSInteger code =  [dic[@"code"] integerValue];
        
        Message *model = [[Message alloc]init];
        model.reason = dic[@"message"];
        model.isSuccess = code == 0? YES : NO;
        call(model);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/** 手机号登录接口 & 手机号注册接口 */
-(void)loginAndRegister:(NSDictionary *)param callBack:(NSDictionaryCallBack)call{
    
    [self.manager POST:ADD(URL_POST_CUSTOMER_CUSTOMERREGISTER) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSInteger code =  [dic[@"code"] integerValue];
        if (code != 0) {
            Message *model = [[Message alloc]init];
            model.reason = dic[@"message"];
            model.code = [NSString stringWithFormat:@"%@",dic[@"code"]];
            
            NSDictionary *dic = @{@"type":@"message", @"model":model};
            call(dic);
        }else{
            [self updateUser:dic[DATAS]];
            
            NSDictionary *dic = @{@"type":@"user", @"model":self.user};
            call(dic);
        }
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/*****************************商品*******************************/

/**获取 商品详情 数据*/
-(void)getGoodsDetailsParame:(NSDictionary *)param callBack:(NSObjectCallBack)call{
    
    NSString *addtoken = [[NSUserDefaults standardUserDefaults]objectForKey:TOKEN];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
    if (addtoken != nil && addtoken.length > 0) {
        [dic setObject:addtoken forKey:TOKEN];
    }
    
    [self.manager POST:ADD(URL_POST_DINGDANXIE_DDXIAIDPRIVILEGE) parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSInteger code =  [dic[@"code"] integerValue];
        
        if (code != 0) {
            
            Message *message = [[Message alloc]init];
            message.reason = dic[@"message"];
            message.code = dic[@"code"];
            call(message);
            
        }else{
            GoodsDetailModel *model = [GoodsDetailModel mj_objectWithKeyValues:dic[DATAS]];
            call(model);
        }
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/**获取商品详情的店铺信息*/
-(void)getGoodsShopDetail:(NSDictionary *)param callBack:(NSObjectCallBack)call{
    
    __block GoodsDetailModel *model = param[@"model"];
    
    NSDictionary *dic = @{@"appToken":param[@"appToken"], @"mid":param[@"mid"], @"deviceOs":@"ios"};
    
    
    [self.manager POST:ADD(URL_POST_DINGDANXIA_SHOPWDETAIL) parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        model.shopTitle = dic[DATAS][@"shopTitle"];
        
        NSString *taoShopUrl = [NSString stringWithFormat:@"%@",dic[DATAS][@"taoShopUrl"]];
        model.taoShopUrl = taoShopUrl;
        NSArray *dataList = dic[DATAS][@"evaluatesList"];
        
        NSMutableArray *temArray = [NSMutableArray array];
        
        for (NSString *tempStr in dataList) {
            [temArray addObject:[ModelTool dictionaryWithJsonString:tempStr]];
        }
        
        NSMutableArray *shopEvaliates = [NSMutableArray array];
        for (NSDictionary *dic in temArray) {
            ShopModel *shop = [[ShopModel alloc]init];
            shop.title = dic[@"title"];
            shop.score = dic[@"score"];
            shop.levelText = dic[@"levelText"];
            [shopEvaliates addObject:shop];
        }
        
        model.evaluatesList = shopEvaliates;
        call(model);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
    
}

/**商品收藏*/
-(void)goodsFavorite:(NSDictionary *)param callBack:(MessageCallBack)call{
    [self.manager POST:ADD(URL_POST_CUSTOMER_FAVORITE) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Message *message = [[Message alloc]init];
        message.code = dic[@"code"];
        message.reason = dic[@"message"];
        call(message);
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/**判断商品是否收藏*/
-(void)goodsIsFavorite:(NSDictionary *)param callBack:(MessageCallBack)call{
    [self.manager POST:ADD(URL_POST_CUSTOMER_FAVORITECHECK) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Message *message = [[Message alloc]init];
        message.code = dic[@"code"];
        message.reason = dic[@"message"];
        NSString *favStatus = dic[DATAS][@"favStatus"];
        if ([favStatus isEqualToString:@"2"] ||[favStatus isEqualToString:@"0"]) {
            message.isSuccess = NO;
        }else{
            message.isSuccess = YES;
        }
        call(message);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/** 搜索 商品 接口 */
-(void)getSearchGoodsList:(NSDictionary *)param callBack:(NSArrayCallBack)call{
    [self.manager POST:ADD(URL_POST_THIRDPARTY_TBKMATERIALGET) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSInteger code =  [dic[@"code"] integerValue];
        
        if (code == 0) {
            NSArray *dataArray = dic[DATAS];
            NSArray *goodsList = [GoodsModel mj_objectArrayWithKeyValuesArray:dataArray];
            call(goodsList);
        }else{
            call(@[dic[@"message"]]);
        }
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/** 添加足迹 接口 */
-(void)footprint:(NSDictionary *)param{
    
    [self.manager POST:ADD(URL_POST_CUSTOMER_FOOTPRINT) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"添加足迹 >> dic : %@",dic);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

/** 收藏列表 */
-(void)getFavoriteList:(NSDictionary *)param callBack:(NSArrayCallBack)call{
    
    [self.manager POST:ADD(URL_POST_CUSTOMER_FAVORITELIST) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataArray = dic[DATAS][@"list"];
        NSMutableArray *dataList = [NSMutableArray array];
        for (NSDictionary *tem in dataArray) {
            GoodsModel *model = [[GoodsModel alloc]init];
            model.itemDescription = tem[@"title"];
            model.shopTitle =  tem[@"shopTitle"];
            model.couponEndTime =  tem[@"couponEndTime"];
            model.smallImages =  tem[@"smallImages"];
            model.userType =  tem[@"userType"];
            model.volume =  tem[@"volume"];
            model.commissionRate =  tem[@"commissionRate"];
            model.title =  tem[@"title"];
            model.reservePrice =  tem[@"reservePrice"];
            model.couponAfterPrice =  tem[@"couponAfterPrice"];
            model.numIid =  tem[@"mid"];
            model.zkFinalPrice =  tem[@"zkFinalPrice"];
            model.couponInfo = tem[@"coupon"];
            [dataList addObject:model];
        }
        
        call(dataList);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/**
 足迹列表 接口
 */
-(void)getFootprintList:(NSDictionary *)param callBack:(NSArrayCallBack)call{
    
    [self.manager POST:ADD(URL_POST_CUSTOMER_FOOTPRINTLIST) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataArray = dic[DATAS];
        NSMutableArray *dataList = [NSMutableArray array];
        for (NSDictionary *tem in dataArray) {
            GoodsModel *model = [[GoodsModel alloc]init];
            model.itemDescription = tem[@"title"];
            model.shopTitle =  tem[@"shopTitle"];
            model.couponEndTime =  tem[@"couponEndTime"];
            model.smallImages =  tem[@"smallImages"];
            model.userType =  tem[@"userType"];
            model.volume =  tem[@"volume"];
            model.commissionRate =  tem[@"commissionRate"];
            model.title =  tem[@"title"];
            model.reservePrice =  tem[@"reservePrice"];
            model.couponAfterPrice =  tem[@"couponAfterPrice"];
            model.numIid =  tem[@"mid"];
            model.zkFinalPrice =  tem[@"zkFinalPrice"];
            model.couponInfo = tem[@"coupon"];
            [dataList addObject:model];
        }
        
        call(dataList);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

/******************************淘宝***********************************/

/** 淘宝客防屏蔽发单二维码生成*/
-(void)getQrcode:(NSDictionary *)param callBack:(NSObjectCallBack)call{
    [self.manager POST:ADD(URL_POST_DINGDANXIA_TBKTKQRCODE) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        call(dic[DATAS]);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/** 淘宝本地授权 */
-(void)taobaobendiAuthorizationParentController:(UIViewController *)parentController callBack:(NSObjectCallBack)call{
    if(![[ALBBSession sharedInstance] isLogin]){
        ALBBSDK *albbSDK = [ALBBSDK sharedInstance];
        [albbSDK setAuthOption:NormalAuth];
        [albbSDK auth:parentController successCallback:^(ALBBSession *session) {
            call(session);
        } failureCallback:^(ALBBSession *session, NSError *error) {
            call(nil);
        }];
    }else{
        ALBBSession *session=[ALBBSession sharedInstance];
        call(session);
    }
    
}

-(void)saveTaobaoAuthorization:(ALBBSession *)session callBack:(nonnull NSDictionaryCallBack)call{
    ALBBUser *alUser = [session getUser];
    User *user = [[DataManager shareInstance]getUser];
    
    NSString *code = alUser.topAccessToken;
    NSString *nickName = alUser.nick;
    NSString *avatarUrlStr = alUser.avatarUrl;
    NSString *openIdStr = alUser.openId;
    NSString *openSidStr = alUser.openSid;
    NSString *topAccessTokensStr = alUser.topAccessToken;
    NSString *topAuthCodeStr = alUser.topAuthCode;
    NSString *appToken = user.appToken;
    
    NSDictionary *tem = @{@"deviceOs":@"ios", @"code":code, @"apptoken":appToken, @"userNick":nickName, @"state": @"0", @"avatarUrlStr":avatarUrlStr, @"openIdStr":openIdStr, @"openSidStr":openSidStr, @"topAccessTokensStr":topAccessTokensStr, @"topAuthCodeStr":topAuthCodeStr};
    
    NSLog(@"< - tem   %@ ->", tem);
    
    NSDictionary *dic = @{ @"accessToken":code, @"appToken":appToken,@"state": @"11", @"userNick":nickName, @"deviceOs":@"ios"};
    NSLog(@"dic : <- %@ ->", dic);
    
    [[DataManager shareInstance]taobaoAuthorization:dic callBack:^(NSDictionary *result) {
        
        call(result);
    }];
}

-(void)taobaoAuthorization:(NSDictionary *)param callBack:(NSDictionaryCallBack)call{
    
    [self.manager POST:ADD(URL_POST_WEIXIN_TBOAUTH) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
//        NSLog(@"dic %@", dic);
        call(dic);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/** 解绑淘宝 */
-(void)unbindTaoBao:(NSDictionary *)param callBack:(MessageCallBack)call{
    [self.manager POST:ADD(URL_POST_CUSTOMER_UNBIND) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        Message *message = [[Message alloc]init];
        message.reason = dic[@"message"];
        message.code = dic[@"code"];
        call(message);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/** 淘口令查询 */
-(void)queryTKL:(NSDictionary *)param callBack:(NSObjectCallBack)call{
    
    [self.manager POST:ADD(URL_POST_THIRDPARTY_TKL_QUERY) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *tem = dic[DATAS][@"product"];
        
        GoodsDetailModel *model = [GoodsDetailModel mj_objectWithKeyValues:tem];
        
        call(model);
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/**
 h5跳 淘宝授权
 
 @param str url
 @param call 没做处理
 */

-(void)weixinTBwapoauth:(NSString *)str  callBack:(NSDictionaryCallBack)call{
    NSDictionary *param = [ModelTool processingString:str];
    
    [self.manager POST:ADD(URL_POST_WEIXIN_TBWAPOAUTH) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"dic :%@", dic);
        call(dic);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}


/** 获取用户渠道id*/
-(void)getAccessToUserChannelsIDInfo:(NSDictionary *)param callBack:(NSObjectCallBack)call{
    [self.manager POST:ADD(URL_POST_CUSTOMER_CUSTOMERRELATION) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *tem = dic[DATAS];
        
        //        UserAccessChannelsModel *mode = ;
        call((NSObject *)[ModelTool processingUserAccessChannelsModel:tem]);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/******************************发现***********************************/

/** 淘宝客精选 */
-(void)getFeaturedCpy:(NSDictionary *)param callBack:(NSObjectCallBack)call{
    
    [self.manager POST:ADD(URL_POST_DINGDANXIA_FEATUREDCPY) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSInteger code = [dic[@"code"] integerValue];
        Message *message = [[Message alloc]init];
        message.code = dic[@"code"];
        if (code == 0) {
            NSArray *dataList =  dic[DATAS];
            NSArray *dataArray = [ModelTool processingRecommendModelData:dataList];
            message.modelList = dataArray;
        }
        message.reason = dic[@"message"];
        call(message);
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/**
 *好物推荐
 */
-(void)getRecommendList:(NSDictionary *)param callBack:(NSObjectCallBack)call{
    
    [self.manager POST:ADD(URL_POST_TCOMMODITYRECOMMEND_LIST) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSInteger code = [dic[@"code"] integerValue];
        Message *message = [[Message alloc]init];
        message.code = dic[@"code"];
        if (code == 0) {
            NSArray *dataList =  dic[DATAS];
            NSArray *dataArray = [ModelTool processingGroomModelData :dataList];
            message.modelList = dataArray;
        }
        message.reason = dic[@"message"];
        call(message);
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
        
        NSLog(@"error : %@", error);
    }];
}

/******************************分类***********************************/

-(void) getAppCategoricalDataInfo:(NSArrayCallBack) call{
    
    [self.manager POST:ADD(URL_POST_THIRD_CATEGORYINFO) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //分类数据写入文件
        [ModelTool writeFileToData:dic forFileName:@"categoryData.plist"];
        NSArray *dataArray = dic[DATAS];
        NSArray<CategoryModel *> *modelList = [ModelTool processCategoricalData:dataArray];
        call(modelList);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/******************************用户中心***********************************/
/** 查询个人信息 */
-(void)getCustomerInfo:(NSDictionary *)param callBack:(NSObjectCallBack)call{
    [self.manager POST:ADD(URL_POST_CUSTOMER_CUSTOMERINFO) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        
        NSInteger code =  [dic[@"code"] integerValue];
        if (code != 0) {
            Message *model = [[Message alloc]init];
            model.reason = dic[@"message"];
            model.code = [NSString stringWithFormat:@"%@",dic[@"code"]];
            
            NSDictionary *dic = @{@"type":@"message", @"model":model};
            call(dic);
        }else{
            [self updateUser:dic[DATAS]];
            
            NSDictionary *dic = @{@"type":@"user", @"model":self.user};
            call(dic);
        }
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/** 返回用户信息 */
-(User *)getUser{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"userInfo"];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    
    User *person;
    if (@available(iOS 11.0, *)) {
        person  =[NSKeyedUnarchiver unarchivedObjectOfClass:[User class] fromData:data error:&error];
    } else {
        // Fallback on earlier versions
        person = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:person.appToken forKey:TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return person;
}

/** 修改手机号 */
-(void)modifyCustomerPhone:(NSDictionary *)param callBack:(MessageCallBack)call{
    [self.manager POST:ADD(URL_POST_CUSTOMER_MODIFYCUSTOMERPHONE) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        Message *message = [[Message alloc]init];
        message.reason = dic[@"message"];
        message.code = dic[@"code"];
        call(message);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/** 查询粉丝 */
-(void)selectFans:(NSDictionary *)param callBack:(NSArrayCallBack)call{
    [self.manager POST:ADD(URL_POST_CUSTOMER_MYFANS) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSArray *dataList = [ModelTool processingFans:dic[DATAS]];
        
        for (FansModel *tem in dataList) {
            tem.numberStr = dic[@"message"];
        }
        
        call(dataList);
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/** 清除用户数据 */
-(BOOL)clearUser{
    self.user.loginState = NO;
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"userInfo"];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    
    if ([fileManage fileExistsAtPath:path]) {
        //文件存在
        BOOL isSuccess = [fileManage removeItemAtPath:path error:nil];
        return isSuccess;
    }else{
        return NO;
    }
}

/** 佣金提取列表 */
-(void)getExtractList:(NSDictionary *)param callBack:(NSArrayCallBack)call{
    [self.manager POST:ADD(URL_POST_CUSTOMER_EXTRACT_LIST) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSArray *dataArray = dic[DATAS][@"list"];
        NSArray *particularsList = [ParticularsModel mj_objectArrayWithKeyValuesArray:dataArray];
        
        call(particularsList);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/** 微信登录 */
-(void)weixinAuthorization:(NSDictionary *)param callBack:(NSDictionaryCallBack)call{
    
    [self.manager POST:ADD(URL_POST_WEIXIN_GETWEIXINCUSTOMERINFO) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSInteger code =  [dic[@"code"] integerValue];
        
        if (code == 0) {
            [self updateUser:dic[DATAS]];
            NSDictionary *dic = @{@"type":@"user", @"model":self.user};
            call(dic);
        }else{
            Message *model = [[Message alloc]init];
            model.reason = dic[@"message"];
            model.code = [NSString stringWithFormat:@"%@",dic[@"code"]];
            
            NSDictionary *dic = @{@"type":@"message", @"model":model};
            call(dic);
        }
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dic = @{@"type":@"error"};
        call(dic);
    }];
}

/** 申请提现 */
-(void)accountApplyToALiAccount:(NSDictionary *)param callBack:(MessageCallBack)call{
    
    [self.manager POST:ADD(URL_POST_ACCOUNT_APPLYTOALIACCOUNT) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Message *message = [[Message alloc]init];
        message.code = dic[@"code"];
        message.reason = dic[@"message"];
        NSString *favStatus = dic[DATAS][@"favStatus"];
        message.isSuccess = [favStatus boolValue];
        
        call(message);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/** 我的订单 */
-(void)customerOrders:(NSDictionary *)param callBack:(NSArrayCallBack)call{
    [self.manager POST:ADD(URL_POST_CUSTOMER_ORDERS) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSString *codeStr = [NSString stringWithFormat:@"%@",dic[@"code"]];
        
        NSInteger code = [codeStr integerValue];
        
        if (code != 0) {
            NSMutableArray *temp = [NSMutableArray array];
            
            Message *message = [[Message alloc]init];
            message.reason = dic[@"message"];
            [temp addObject:message];
            
            call(temp);
            
        }else{
            NSArray *orderArray = [ModelTool processingOrder:dic[DATAS]];
            call(orderArray);
        }
        
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/** 收益报表 */
-(void)getFeeDetail:(NSDictionary *)param callBack:(NSDictionaryCallBack)call{
    [self.manager POST:ADD(URL_POST_CUSTOMER_FEE_DETAIL) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        call(dic[DATAS]);
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/// 上传头像接口
/// @param icon 二进制流
-(void) uploadIcon:(NSData*) icon callback:(MessageCallBack)call{
    
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc] init];
    
    [parameters setObject:self.user.appToken forKey:TOKEN];
    
    [self.manager POST:ADD(URL_POST_IMSCATEGORY_UPAVATAR) parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:icon name:@"file" fileName:@"org_img.jpg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"dic %@", dic);
        NSInteger code = [dic[@"code"] integerValue];
        Message *message = [[Message alloc] init];
        if (code != 0) {
            message.isSuccess = NO;
            message.reason = dic[@"message"];
        }else if(code == 0){
            message.isSuccess = YES;
            message.reason = dic[@"message"];
        }
        call(message);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Message *message = [[Message alloc] init];
        message.isSuccess = NO;
        message.reason = @"没有网络";
        
        call(message);
    }];
}

/** 常见问题查询 */
-(void)queryFrequentlyQuestions:(NSDictionary *)parame callback:(NSArrayCallBack)call{
    
    [self.manager POST:ADD(URL_POST_COMMON_PROBLEM_LIST) parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataList = [ModelTool getQuestionListData:dic[DATAS][@"list"]];
        call(dataList);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
    
}

/**
 数据字典查询
 */
-(void)searchDirc:(NSDictionary *)parame callback:(NSArrayCallBack)call{
    
    [self.manager POST:ADD(URL_POST_DIRC_SEARCH) parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSArray *dataList = [ModelTool getQuestionData:dic[DATAS]];
        call(dataList);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/**
 *订单找回
 */
-(void)findOrder:(NSDictionary *)param callback:(NSDictionaryCallBack)call{
    [self.manager POST:ADD(URL_POST_THIRDPARTY_FINDORDER) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
           NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
           call(dic);
           
       }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           call(nil);
       }];
}


/**
 商务合作
 */
-(void)businessAdd:(NSDictionary *)parame callback:(NSObjectCallBack)call{
    [self.manager POST:ADD(URL_POST_BUSINESS_ADD) parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
           
              call(dic);
              
          }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              call(nil);
          }];
}



/******************************通知***********************************/
/***
 *系统通知
 */
-(void)getNotificationSystem:(NSDictionary *)parame callback:(NSArrayCallBack)call{
    [self.manager POST:ADD(URL_POST_SETTING_NOTIFICATIONSYSTEM) parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataArray = dic[DATAS];
        
        NSArray *arrayList = [ModelTool collateMessageData:dataArray];
        
        
        call(arrayList);;
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
    
}

/***
 *好物推荐
 */
-(void)getNotificationCommodity:(NSDictionary *)parame callback:(NSArrayCallBack)call{
    
    [self.manager POST:ADD(URL_POST_SETTING_NOTIFICATIONCOMMODITY) parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataArray = dic[DATAS];
        
        NSArray *arrayList = [ModelTool collateMessageData:dataArray];
        
        
        call(arrayList);;
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
    
    
}

/***
 *活动公告
 */
-(void)getNotificationActivity:(NSDictionary *)parame callback:(NSArrayCallBack)call{
    
    [self.manager POST:ADD(URL_POST_SETTING_NOTIFICATIONACTIVITY) parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataArray = dic[DATAS];
        
        NSArray *arrayList = [ModelTool collateMessageData:dataArray];
        
        
        call(arrayList);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}


/**
 *是否有新消息
 */

-(void)getNotificationRedPoint:(NSDictionary *)param{
    
    [self.manager POST:ADD(URL_POST_SETTING_NOTIFICATIONINFO) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *temDictionary = dic[DATAS];
        
        NSString *readFlgs = [NSString stringWithFormat:@"%@",temDictionary[@"readFlgs"]];
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATIONREDPOINT object:nil userInfo:@{@"isRedPoint":readFlgs}];
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


/***
 *读取消息
 */
-(void)readMessage:(NSDictionary *)param{
    [self.manager POST:ADD(URL_POST_SETTING_NOTIFICATIONSAVE) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

/**
 * 消息页面 ->是否有新消息
 */

-(void)getRedPoint:(NSDictionary *)param callback:(NSDictionaryCallBack)call{
    [self.manager POST:ADD(URL_POST_SETTING_NOTIFICATIONINFO) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *temDictionary = dic[DATAS];
        
        call(temDictionary[@"readFlgsChild"]);
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


/******************************拼多多***********************************/

/***
 *查询商品目录列表
 *@param param 参数
 *@param call 返回
 */
-(void)getDDKGoodsCats:(NSDictionary *)param callback:(NSArrayCallBack)call{
    
    [self.manager POST:ADD(URL_POST_DDK_GOODS_CATS) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *data = dic[DATAS];
        NSArray *dataList = data[@"goodsCatsList"];
        NSArray *list = [ModelTool collatePddGoodsCatData:dataList];
        call(list);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


/***
 *查询标签列表
 */
-(void)getDDKGoodsOpt:(NSDictionary *)param callback:(NSArrayCallBack)call{
    
    [self.manager POST:ADD(URL_POST_DDK_GOODS_OPT) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSArray *dataList = dic[DATAS];
        NSArray *list = [ModelTool collatePddGoodsCatData:dataList];
        call(list);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

/****
 *绑定推广位
 */
-(void)getDDKPidGenerate:(NSDictionary *)param callback:(MessageCallBack)call{
    [self.manager POST:ADD(URL_POST_DDK_PID_GENERATE) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        [self updateUser:dic[DATAS]];
        Message *message = [[Message alloc]init];
        message.reason = [dic description];
        call(message);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/**
 * 查询商品列表
 */
-(void)getGoodsSearchList:(NSDictionary *)param callback:(NSArrayCallBack)call{
    
    [self.manager POST:ADD(URL_POST_DDK_GOODS_SEARCH) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataList = [ModelTool collatePddGoodsListData:dic[DATAS]];
        call(dataList);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/**
 * 查询商品详情
 */
-(void)getPddGoodsDetail:(NSDictionary *)param callback:(NSObjectCallBack)call{
    [self.manager POST:ADD(URL_POST_DDK_GOODS_DETAIL) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        //      [PddGoodsListModel mj_objectArrayWithKeyValuesArray:dataList];
        
        NSArray *tempArray = dic[DATAS];
        
        NSDictionary *dataDic = [tempArray lastObject];
        GoodsDetailModel *tempDetailModel = [[GoodsDetailModel alloc]init];
        
        tempDetailModel.smallImages = dataDic[@"goodsGalleryUrls"];
        tempDetailModel.title = dataDic[@"goodsName"];
        tempDetailModel.shopTitle = dataDic[@"mallName"];
        tempDetailModel.pictUrl = dataDic[@"goodsImageUrl"];
        tempDetailModel.numIid = dataDic[@"goodsId"];
        tempDetailModel.itemDescription = dataDic[@"goodsDesc"];
        tempDetailModel.coupon = dataDic[@"couponDiscount"];
        tempDetailModel.rebateAmount = dataDic[@"promotionRate"];
        tempDetailModel.volume = dataDic[@"salesTip"];
        
        tempDetailModel.couponEndTime = [NSString timeStringInterception:dataDic[@"couponEndTime"]];//dataDic[@"couponEndTime"];
        tempDetailModel.couponStartTime = [NSString timeStringInterception:dataDic[@"couponStartTime"]];//dataDic[@"couponStartTime"];
        
        
        
        
        
        tempDetailModel.commissionRate = dataDic[@"couponAmount"];
        float commissionRate = [tempDetailModel.commissionRate floatValue];
        tempDetailModel.commissionRate = [NSString stringWithFormat:@"%.2f",commissionRate];
        
        
        tempDetailModel.couponAfterPrice = dataDic[@"afterCouponPrice"];
        float couponAfterPrice = [tempDetailModel.couponAfterPrice floatValue];
        tempDetailModel.couponAfterPrice = [NSString stringWithFormat:@"%.2f",couponAfterPrice];
        
        
        
        tempDetailModel.zkFinalPrice = dataDic[@"minGroupPrice"];
        
        float zkFinalPrice = [tempDetailModel.zkFinalPrice floatValue];
        tempDetailModel.zkFinalPrice = [NSString stringWithFormat:@"%.2f",zkFinalPrice];
        
        
        
        tempDetailModel.userType = @"3";
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (int i =0 ; i< 3; i++) {
            ShopModel *model = [[ShopModel alloc]init];
            
            NSString *title;
            NSString *txt;
            switch (i) {
                case 0:{
                    title = @"商品描述 ";
                    txt = dataDic[@"descTxt"];
                }
                    break;
                case 1:{
                    title = @"服务态度 ";
                    txt = dataDic[@"servTxt"];
                }
                    break;
                case 2:{
                    title = @"发货速度 ";
                    txt = dataDic[@"lgstTxt"];
                }
                    break;
                default:
                    break;
            }
            
            model.title = title;
            model.levelText = txt;
            
            [mutableArray addObject:model];
            
        }
        
        tempDetailModel.evaluatesList = mutableArray;
        
        
        call(tempDetailModel);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}




/**
 * 商品推广链接
 */
-(void)getPddGoodsProm:(NSDictionary *)param callback:(NSObjectCallBack)call{
    [self.manager POST:ADD(URL_POST_DDK_GOODS_PROM) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *temDic=  dic[DATAS];
        NSArray *dataList = temDic[@"goodsPromotionUrlList"];
        NSDictionary *urlDic = [dataList lastObject];
        
        NSString *urlStr = urlDic[@"shortUrl"];
        
        call(urlStr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/******************************京东***********************************/

/**
 *京东 商品类目
 */
//-(void)getJDGoodsCategory:(NSDictionary *)param callback:(NSArrayCallBack)call{
//    [self.manager POST:ADD(URL_POST_JDLM_GOODS_CATEGORY) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//
//       NSArray *dataList = [ModelTool collateJDGoodsCategoryData:dic[DATAS]];
//
//        call(dataList);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        call(nil);
//    }];
//}


/**
 *京东 商品类目 新
 */
-(void)getJDGoodsCategory:(NSDictionary *)param callback:(NSArrayCallBack)call{
    [self.manager POST:ADD(URL_POST_THIRDPARTY_CATEGORY_INFO) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataList = [ModelTool collateJDGoodsCategoryData:dic[DATAS]];
        
        call(dataList);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/**
 *京东 关键词商品查询接口
 */
-(void)getJDGoodsQuery:(NSDictionary *)param callback:(NSArrayCallBack)call{
    [self.manager POST:ADD(URL_POST_JDLM_GOODS_QUERY) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataArray = dic[DATAS];
        
        NSArray *goodsList = [GoodsModel mj_objectArrayWithKeyValuesArray:dataArray];
        
        for (GoodsModel *model in goodsList) {
            model.userType = @"4";
        }
        
        call(goodsList);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/**
 *京东 获取推广链接
 */
-(void)getJDGoodsByunionid:(NSDictionary *)param callback:(NSObjectCallBack)call{
    [self.manager POST:ADD(URL_POST_JDLM_GOODS_BYUNIONID) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *urlStr = dic[DATAS];
        
        call(urlStr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}


/**
 *京东 用户绑定京东推广位
 */
-(void)getJDlmPidBind:(NSDictionary *)param callback:(MessageCallBack)call{
    
    NSLog(@"param : %@", param);
    
    [self.manager POST:ADD(URL_POST_JDLM_GOODS_PIDBIND) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        [self updateUser:dic[DATAS]];
        Message *message = [[Message alloc]init];
        message.reason = [dic description];
        call(message);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}


/******************************其他***********************************/
/**
 开机屏广告
 */
-(void)adconfigCallBack:(MessageCallBack)call{
    [self.manager POST:ADD(URL_POST_SETTING_ADCONFIG) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSInteger code = [dic[@"code"] integerValue];
        
        NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
        if (code == 0) {
            NSDictionary *tem =  dic[DATAS];
            NSString *url = tem[@"url"];
            NSString *image = tem[@"image"];
            
            [userDefault setObject:image forKey:ADVERTISEMENT_IMAGEURL];
            [userDefault setObject:url forKey:ADVERTISEMENT_URL];
            [userDefault synchronize];
        }else{
            [userDefault setObject:@"" forKey:ADVERTISEMENT_URL];
            [userDefault setObject:@"" forKey:ADVERTISEMENT_IMAGEURL];
            [userDefault synchronize];
        }
        
        Message *message = [[Message alloc]init];
        message.code = dic[@"code"];
        message.reason = dic[@"message"];
        call(message);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}


/**
 *绑定用户设备
 *用于远程推送
 */
-(void)bindDevice:(NSDictionary *)parame callBack:(MessageCallBack)call{
    
    [self.manager POST:ADD(URL_POST_SETTING_BINDDEVICE) parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
//        NSLog(@"dic %@", dic);
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/**
 *淘礼金
 */
-(void)getTaoLiJinList:(NSDictionary *)parame callBack:(NSArrayCallBack)call{
    [self.manager POST:ADD(URL_POST_THIRDPARTY_TLJ) parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataArray = dic[DATAS];
        
        NSArray *dataList = [ZeroModel mj_objectArrayWithKeyValuesArray:dataArray];
        
        call(dataList);
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/**
 强制更新
 */
-(void)forcedUpdate:(NSDictionary *)param callBack:(MessageCallBack)call{
    [self.manager POST:ADD(URL_POST_SETTING_SETUPDATECONFIG) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *temDic = dic[DATAS];
        
        NSString *statue = temDic[@"statue"];
        Message *message = [[Message alloc]init];
        
        if (temDic[@"url"] != nil) {
            [[DBManager shareInstance]setQinggengUrl:temDic[@"url"]];
        }
        
        if ([statue isEqualToString:@"false"] == NO && statue != nil) {
            message.isSuccess = YES;
        }
        
        call(message);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}



/**
 检查版本信息
 */
-(void)getShowconfigCallBack:(MessageCallBack)call{
    
    NSDictionary *param = @{@"deviceOs":@"ios", @"version": VERSION};
    
    [self.manager POST:ADD(URL_POST_THIRDPARTY_SHOWCONFIG) parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
        
        //        [userDefault setObject:@"1" forKey:SHOWCONFIG];
        
        
        [userDefault setObject:dic[DATAS] forKey:SHOWCONFIG];
        [userDefault synchronize];
        
        NSString *code = dic[DATAS];
        
        [[DBManager shareInstance] setIsShowconfig:[code boolValue]];
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}

/**
 *功能显示配置
 */
-(void)getBannerConfigCallBack:(NSDictionaryCallBack)call{
    [self.manager POST:ADD(URL_POST_SETTING_BANNERCONFIG) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        call(dic[DATAS]);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        call(nil);
    }];
}


#pragma mark - private

/// 更新用户信息
-(void)updateUser:(NSDictionary *)info{
    self.user = [User mj_objectWithKeyValues:info];
    
    self.user.loginState = YES;
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *path = [doc stringByAppendingPathComponent:@"userInfo"];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.user.appToken forKey:TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (@available(iOS 11.0, *)) {
        NSData *data =  [NSKeyedArchiver archivedDataWithRootObject:self.user requiringSecureCoding:NO error:nil];
        [data writeToFile:path atomically:YES];
    } else {
        [NSKeyedArchiver archiveRootObject:self.user toFile:path];
    }
    
}

#pragma mark - getter / setter
-(AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        //获取请求对象
        _manager= [AFHTTPSessionManager manager];
        // 设置请求格式
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        // 设置返回格式
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 返回数据解析类型
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        _manager.requestSerializer.timeoutInterval = 60;
    }
    return _manager;
}

+(DataManager*) shareInstance{
    static DataManager * dataManager;
    if (!dataManager) {
        dataManager = [[super allocWithZone:NULL] init];
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            // 当网络状态改变时调用
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:{
                    //todo:没有网络 处理
                    //NSLog(@"没有网络");
                }
                    break;
                default:{
                }
                    break;
            }
        }];
        //开始监控
        [manager startMonitoring];
    }
    return dataManager;
};

+(id) allocWithZone:(struct _NSZone *)zone{
    
    return [DataManager shareInstance];
}


@end
