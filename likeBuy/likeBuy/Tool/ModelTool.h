//
//  ModelTool.h
//  likeBuy
//
//  Created by mac on 2019/10/8.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CategoryModel, UserAccessChannelsModel;

@interface ModelTool : NSObject

/**
 处理分类数据
 @param dataArray 分类数据 数组
 */
+(NSArray<CategoryModel *>*)processCategoricalData:(NSArray *)dataArray;

/**
 字典写入plist文件
 
 @param dataDic 数据
 @param fileName 文件名
 @return 是否成功
 */
+(BOOL)writeFileToData:(NSDictionary *)dataDic  forFileName:(NSString *)fileName;

/**
 打包订单数据
 
 @param orderArray json 数组
 @return ordermodel 数组
 */
+(NSArray *)processingOrder:(NSArray *)orderArray;

/**
 分装订单数据
 
 @param orderArray ordermodel数组
 */
+(NSArray *)processingFinishOrder:(NSArray *)orderArray withString:(NSString *)str;



/**
 打包 粉丝数据
 
 @param dataList json 数组
 */
+(NSArray *)processingFans:(NSArray *)dataList;

/**
 处理RecommendModel数据
 */
+(NSMutableArray *)processingRecommendModelData:(NSArray *)datatArray;

/**
 处理GroomModel数据
 */
+(NSMutableArray *)processingGroomModelData:(NSArray *)datatArray;

/// 处理Banner数据
+(NSMutableDictionary *)processBannerData:(NSArray*)dataArray;

/**json字符串转字典*/
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

///处理分类数据，只返回一级分类的名字
+(NSArray<NSString *>*)processPrimaryClassification:(NSArray*)dataArray;


/// 打包消息数据
+(NSArray *)processingInfoModelData:(NSArray*)dataArray;

/**
 处理url 数据 返回 字典
 
 @param code url
 */
+(NSDictionary *)processingString:(NSString *)code;


/// 存搜索 数组
+(void)saveSearchHistoryArrayToLocal:(NSArray *)historyStringArray;

/// 返回搜索数组
+(NSMutableArray *)getSearchHistoryArrayFromLocal;

/**
 *处理用户渠道 id
 */
+(UserAccessChannelsModel *)processingUserAccessChannelsModel:(NSDictionary *)dic;


/// 处理时间数据
+(NSArray *)processingTimeData:(NSArray *)dataList;

///整理消息数据
+(NSArray *)collateMessageData:(NSArray *)dataList;

///处理 拼多多 查询商品目录列表
+(NSArray *)collatePddGoodsCatData:(NSArray *)dataList;

///处理拼多多 商品列表
+(NSArray *)collatePddGoodsListData:(NSArray *)dataList;

///处理京东 商品类目
+(NSArray *)collateJDGoodsCategoryData:(NSArray *)dataList;

///处理 常见问题 model 数据
+(NSArray *)getQuestionData:(NSArray *)dataList;

///处理 常见问题 列表 model 数据
+(NSArray *)getQuestionListData:(NSArray *)dataList;


@end

NS_ASSUME_NONNULL_END
