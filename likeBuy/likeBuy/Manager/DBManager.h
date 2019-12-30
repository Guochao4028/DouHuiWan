//
//  DBManager.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/23.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GoodsDetailModel, UserAccessChannelsModel;

@interface DBManager : NSObject

/**
 *存储 微信数据
 *由于是单例 所以在手机登录的时候需要重新清空
 */
@property(nonatomic, strong)NSDictionary *weiXinDic;

@property(nonatomic, strong)NSString *deviceToken;
/**
 *存储 用户渠道id
 *跳转 天猫，淘宝，天猫超市等 需要的渠道id
 */
@property(nonatomic, strong)UserAccessChannelsModel *userAccessModel;

///存储  app介绍url
@property(nonatomic, copy)NSString *appUrl;

///存储  会员升级url
@property(nonatomic, copy)NSString *promotionUrl;

///存储  机票酒店URL
@property(nonatomic, copy)NSString *feizuUrl;

///存储  今日爆款url
@property(nonatomic, copy)NSString *todayKaoKuanUrl;

///存储  天猫新品url
@property(nonatomic, copy)NSString *tianmaoXinpinUrl;

///存储  天猫国际url
@property(nonatomic, copy)NSString *tianmaoGuoJiUrl;

///存储  强更url
@property(nonatomic, copy)NSString *qinggengUrl;

/// 显示配置
@property(nonatomic, assign)BOOL isShowconfig;




/**
 *是否显示红点
 */
@property(nonatomic, copy)NSString *isRedView;

+(DBManager *)shareInstance;

-(void)createTableSqlString:(NSArray *)sqlStrings tableNames:(NSArray <NSString *>*)tableNames;

-(void)writeData:(GoodsDetailModel *)model;

-(NSArray *)readData;


@end

NS_ASSUME_NONNULL_END
