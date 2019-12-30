//
//  PddGoodsList.h
//  likeBuy
//
//  Created by mac on 2019/11/10.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PddGoodsListModel : NSObject
//boolean    是否有店铺券
@property(nonatomic, strong)NSString * hasMallCoupon;
//int    店铺券id
@property(nonatomic, strong)NSString * mallCouponId;
//int    店铺券折扣
@property(nonatomic, strong)NSString * mallCouponDiscountPct;
//int    最小使用金额
@property(nonatomic, strong)NSString * mallCouponMinOrderAmount;
//int    最大使用金额
@property(nonatomic, strong)NSString * mallCouponMaxDiscountAmount;
//int    店铺券总量
@property(nonatomic, strong)NSString * mallCouponTotalQuantity;
//int    店铺券余量
@property(nonatomic, strong)NSString * mallCouponRemainQuantity;
//int    商品id
@property(nonatomic, strong)NSString * goodsId;
//String    商品名
@property(nonatomic, strong)NSString * goodsName;
//String    商品描述
@property(nonatomic, strong)NSString * goodsDesc;
//String    缩略图
@property(nonatomic, strong)NSString * goodsThumbnailUrl;
//String    商品住图片
@property(nonatomic, strong)NSString * goodsImageUrl;
//int    最下拼团价
@property(nonatomic, strong)NSString * minGroupPrice;
//int    最小单买价格
@property(nonatomic, strong)NSString * minNormalPrice;
//String    店铺名称
@property(nonatomic, strong)NSString * mallName;
//int    店铺类型，1-个人，2-企业，3-旗舰店，4-专卖店，5-专营店，6-普通店
@property(nonatomic, strong)NSString * merchantType;
//int    商品类目ID(/ddk/goods/cats接口获取)
@property(nonatomic, strong)NSString * categoryId;
//String    商品类目名
@property(nonatomic, strong)NSString * categoryName;
//int    标签id(/ddk/goods/opt接口获取)
@property(nonatomic, strong)NSString * optId;
//String    标签名
@property(nonatomic, strong)NSString * optName;
//list    标签id
@property(nonatomic, strong)NSArray * optIds;
// list    目录id
@property(nonatomic, strong)NSArray * catIds;
//int    该商品所在店铺是否参与全店推广，0：否，1：是
@property(nonatomic, strong)NSString * mallCps;
//boolean    商品是否有优惠券 true-有，false-没有
@property(nonatomic, strong)NSString * hasCoupon;
//int    优惠券门槛价格
@property(nonatomic, strong)NSString * couponMinOrderAmount;
//int    优惠券面额
@property(nonatomic, strong)NSString * couponDiscount;
//int    优惠券总数
@property(nonatomic, strong)NSString * couponTotalQuantity;
//int    优惠券剩余数量
@property(nonatomic, strong)NSString * couponRemainQuantity;
//String    优惠券生效时间
@property(nonatomic, strong)NSString * couponStartTime;
//String    优惠券失去效时间
@property(nonatomic, strong)NSString * couponEndTime;
//int    佣金比例
@property(nonatomic, strong)NSString * promotionRate;
//int    商品评价数量
@property(nonatomic, strong)NSString * goodsEvalCount;
//int    已售卖件数
@property(nonatomic, strong)NSString * salesTip;
@property(nonatomic, strong)NSString * serviceTags;
//String    描述分
@property(nonatomic, strong)NSString * descTxt;
//String    服务分
@property(nonatomic, strong)NSString * servTxt;
//String    物流分
@property(nonatomic, strong)NSString * lgstTxt;
//int    推广计划类型 3:定向 4:招商
@property(nonatomic, strong)NSString * planType;
//int    招商团长id
@property(nonatomic, strong)NSString * zsDuoId;
//boolean    快手专享
@property(nonatomic, strong)NSString * onlySceneAuth;
//int    佣金金额
@property(nonatomic, strong)NSString * couponAmount;

@end

NS_ASSUME_NONNULL_END


//hasMallCoupon    boolean    是否有店铺券
//mallCouponId    int    店铺券id
//mallCouponDiscountPct    int    店铺券折扣
//mallCouponMinOrderAmount    int    最小使用金额
//mallCouponMaxDiscountAmount    int    最大使用金额
//mallCouponTotalQuantity    int    店铺券总量
//mallCouponRemainQuantity    int    店铺券余量
//goodsId    int    商品id
//goodsName    String    商品名
//goodsDesc    String    商品描述
//goodsThumbnailUrl    String    缩略图
//goodsImageUrl    String    商品住图片
//minGroupPrice    int    最下拼团价
//minNormalPrice    int    最小单买价格
//mallName    String    店铺名称
//merchantType    int    店铺类型，1-个人，2-企业，3-旗舰店，4-专卖店，5-专营店，6-普通店
//categoryId    int    商品类目ID(/ddk/goods/cats接口获取)
//categoryName    String    商品类目名
//optId    int    标签id(/ddk/goods/opt接口获取)
//optName    String    标签名
//optIds    list    标签id
//catIds    list    目录id
//mallCps    int    该商品所在店铺是否参与全店推广，0：否，1：是
//hasCoupon    boolean    商品是否有优惠券 true-有，false-没有
//couponMinOrderAmount    int    优惠券门槛价格
//couponDiscount    int    优惠券面额
//couponTotalQuantity    int    优惠券总数
//couponRemainQuantity    int    优惠券剩余数量
//couponStartTime    String    优惠券生效时间
//couponEndTime    String    优惠券失去效时间
//promotionRate    int    佣金比例
//goodsEvalCount    int    商品评价数量
//salesTip    int    已售卖件数
//serviceTags
//descTxt    String    描述分
//servTxt    String    服务分
//lgstTxt    String    物流分
//planType    int    推广计划类型 3:定向 4:招商
//zsDuoId    int    招商团长id
//onlySceneAuth    boolean    快手专享
//couponAmount    int    佣金金额
