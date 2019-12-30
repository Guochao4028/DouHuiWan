//
//  DataManager.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class User;

@interface DataManager : NSObject

/**********************首页*************************/

/**
 获取首页第一分区数据
 */
-(void)getHomePageFirstPartition:(NSDictionaryCallBack)call;

/**
 获取首页商品列表数据
 */
-(void)getHomePageGoodsListParame:(NSDictionary *)param callBack:(NSArrayCallBack)call;

/**
 获取 top100数据
 */
-(void)getTop100GoodsListParame:(NSDictionary *)param callBack:(MessageCallBack)call;

/**
 获取 9.9包邮 数据
 */
-(void)get99CourierGoodsListParame:(NSDictionary *)param callBack:(MessageCallBack)call;


/**
 获取 猜你喜欢 数据
 */
-(void)guessYouLikeParame:(NSDictionary *)param callBack:(NSArrayCallBack)call;


/**
 获取 限时抢购 数据
 */
-(void)flashParame:(NSDictionary *)param callBack:(MessageCallBack)call;

/**
 *品牌清仓
 */
-(void)brandClearanceParame:(NSDictionary *)param callBack:(NSArrayCallBack)call;

/*********************************登录**********************************/

/**
 获取 验证码
 */
-(void)getSmsParame:(NSDictionary *)param callBack:(MessageCallBack)call;

/**
 手机号登录接口 & 手机号注册接口
 */
-(void)loginAndRegister:(NSDictionary *)param callBack:(NSDictionaryCallBack)call;

/*****************************商品*******************************/

/**
 获取 商品详情 数据
 */
-(void)getGoodsDetailsParame:(NSDictionary *)param callBack:(NSObjectCallBack)call;

/**
 获取商品详情的店铺信息
 */
-(void)getGoodsShopDetail:(NSDictionary *)param callBack:(NSObjectCallBack)call;

/**
 商品收藏
 */
-(void)goodsFavorite:(NSDictionary *)param callBack:(MessageCallBack)call;

/**
 判断商品是否收藏
 */
-(void)goodsIsFavorite:(NSDictionary *)param callBack:(MessageCallBack)call;


/**
 搜索 商品 接口
 */
-(void)getSearchGoodsList:(NSDictionary *)param callBack:(NSArrayCallBack)call;


/// 添加足迹
-(void)footprint:(NSDictionary *)param;

/**
 足迹列表 接口
 */
-(void)getFootprintList:(NSDictionary *)param callBack:(NSArrayCallBack)call;

/******************************淘宝***********************************/

/**
 淘宝客防屏蔽发单二维码生成
 */
-(void)getQrcode:(NSDictionary *)param callBack:(NSObjectCallBack)call;

/**
 淘宝授权接口
 */
-(void)taobaoAuthorization:(NSDictionary *)param callBack:(NSDictionaryCallBack)call;


/**
 淘宝本地授权
 */
-(void)taobaobendiAuthorizationParentController:(UIViewController *)parentController callBack:(NSObjectCallBack)call;

/**
 解绑淘宝
 */
-(void)unbindTaoBao:(NSDictionary *)param callBack:(MessageCallBack)call;

/**
 h5跳 淘宝授权
 
 @param str url
 @param call 没做处理
 */
-(void)weixinTBwapoauth:(NSString *)str  callBack:(NSDictionaryCallBack)call;

/**
 淘口令查询
 */
-(void)queryTKL:(NSDictionary *)param callBack:(NSObjectCallBack)call;


/**
 获取用户渠道id
 */

-(void)getAccessToUserChannelsIDInfo:(NSDictionary *)param callBack:(NSObjectCallBack)call;

/******************************发现***********************************/
/**
 淘宝客精选
 */
-(void)getFeaturedCpy:(NSDictionary *)param callBack:(NSObjectCallBack)call;

/**
 *好物推荐
 */
-(void)getRecommendList:(NSDictionary *)param callBack:(NSObjectCallBack)call;

/******************************分类***********************************/
/**
 获取分类数据
 */
-(void) getAppCategoricalDataInfo:(NSArrayCallBack) call;


/******************************用户中心***********************************/

/**
 返回用户信息
 */
-(User *)getUser;

/**
 查询个人信息
 */
-(void)getCustomerInfo:(NSDictionary *)param callBack:(NSObjectCallBack)call;

/**
 修改手机号
 */
-(void)modifyCustomerPhone:(NSDictionary *)param callBack:(MessageCallBack)call;

/**
 查询粉丝
 */
-(void)selectFans:(NSDictionary *)param callBack:(NSArrayCallBack)call;

/**
 清除用户数据
 */
-(BOOL)clearUser;

/**
 佣金提取列表
 */
-(void)getExtractList:(NSDictionary *)param callBack:(NSArrayCallBack)call;

/**
 微信登录
 */
-(void)weixinAuthorization:(NSDictionary *)param callBack:(NSDictionaryCallBack)call;

/**
 申请提现
 */
-(void)accountApplyToALiAccount:(NSDictionary *)param callBack:(MessageCallBack)call;

/**
 我的订单
 */
-(void)customerOrders:(NSDictionary *)param callBack:(NSArrayCallBack)call;

/**
 收益报表
 */
-(void)getFeeDetail:(NSDictionary *)param callBack:(NSDictionaryCallBack)call;

/**
 收藏列表
 */
-(void)getFavoriteList:(NSDictionary *)param callBack:(NSArrayCallBack)call;

/** 上传头像接口
 @param icon 二进制流
 */
-(void) uploadIcon:(NSData*) icon callback:(MessageCallBack)call;

/**
 常见问题查询
 */
-(void)queryFrequentlyQuestions:(NSDictionary *)parame callback:(NSArrayCallBack)call;

/**
 数据字典查询
 */
-(void)searchDirc:(NSDictionary *)parame callback:(NSArrayCallBack)call;


/**
 商务合作
 */
-(void)businessAdd:(NSDictionary *)parame callback:(NSObjectCallBack)call;


/******************************通知***********************************/
/***
 *系统通知
 */
-(void)getNotificationSystem:(NSDictionary *)parame callback:(NSArrayCallBack)call;

/***
 *好物推荐
 */
-(void)getNotificationCommodity:(NSDictionary *)parame callback:(NSArrayCallBack)call;

/***
 *活动公告
 */
-(void)getNotificationActivity:(NSDictionary *)parame callback:(NSArrayCallBack)call;

/***
 *读取消息
 */
-(void)readMessage:(NSDictionary *)param;

/**
 *是否有新消息
 */

-(void)getNotificationRedPoint:(NSDictionary *)param;

/**
 * 消息页面 ->是否有新消息
 */

-(void)getRedPoint:(NSDictionary *)param callback:(NSDictionaryCallBack)call;

/**
 *订单找回
 */
-(void)findOrder:(NSDictionary *)param callback:(NSDictionaryCallBack)call;

/******************************拼多多***********************************/

/***
 *查询商品目录列表
 *@param param 参数
 *@param call 返回
 */
-(void)getDDKGoodsCats:(NSDictionary *)param callback:(NSArrayCallBack)call;

/***
 *查询标签列表
 */
-(void)getDDKGoodsOpt:(NSDictionary *)param callback:(NSArrayCallBack)call;

/****
 *绑定推广位
 */
-(void)getDDKPidGenerate:(NSDictionary *)param callback:(MessageCallBack)call;

/**
 * 查询商品列表
 */
-(void)getGoodsSearchList:(NSDictionary *)param callback:(NSArrayCallBack)call;


/**
 * 查询商品详情
 */
-(void)getPddGoodsDetail:(NSDictionary *)param callback:(NSObjectCallBack)call;

/**
 * 商品推广链接
 */
-(void)getPddGoodsProm:(NSDictionary *)param callback:(NSObjectCallBack)call;


/******************************京东***********************************/

/**
 *京东 商品类目
 */
-(void)getJDGoodsCategory:(NSDictionary *)param callback:(NSArrayCallBack)call;

/**
 *京东 关键词商品查询接口
 */
-(void)getJDGoodsQuery:(NSDictionary *)param callback:(NSArrayCallBack)call;

/**
 *京东 获取推广链接
 */
-(void)getJDGoodsByunionid:(NSDictionary *)param callback:(NSObjectCallBack)call;

/**
 *京东 用户绑定京东推广位
 */
-(void)getJDlmPidBind:(NSDictionary *)param callback:(MessageCallBack)call;


/******************************其他***********************************/
/**
 开机屏广告
 */
-(void)adconfigCallBack:(MessageCallBack)call;

/**
 *绑定用户设备
 *用于远程推送
 */
-(void)bindDevice:(NSDictionary *)parame callBack:(MessageCallBack)call;


/**淘礼金*/
-(void)getTaoLiJinList:(NSDictionary *)parame callBack:(NSArrayCallBack)call;

/**
 强制更新
 */
-(void)forcedUpdate:(NSDictionary *)param callBack:(MessageCallBack)call;

/**
 检查版本信息
 */
-(void)getShowconfigCallBack:(MessageCallBack)call;


/**
 *功能显示配置
 */
-(void)getBannerConfigCallBack:(NSDictionaryCallBack)call;






































+(DataManager*) shareInstance;

@end

NS_ASSUME_NONNULL_END
