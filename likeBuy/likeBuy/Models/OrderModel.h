//
//  OrderModel.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject

@property(nonatomic, copy)NSString *sellerNick;
@property(nonatomic, copy)NSString *earningTime;
@property(nonatomic, copy)NSString *itemTitle;
@property(nonatomic, copy)NSString *payPrice;
@property(nonatomic, copy)NSString *sellerShopTitle;
@property(nonatomic, copy)NSString *itemNum;
@property(nonatomic, copy)NSString *price;
@property(nonatomic, copy)NSString *createTime;
@property(nonatomic, copy)NSString *itemImg;
@property(nonatomic, copy)NSString *orderType;
@property(nonatomic, copy)NSString *tradeId;
@property(nonatomic, copy)NSString *numIid;
@property(nonatomic, copy)NSString *tkStatus;

@property(nonatomic, copy)NSString *yuguFree;

@property(nonatomic, copy)NSString *selfComnissionFee;

@property(nonatomic, copy)NSString *avatar;

@property(nonatomic, copy)NSString *phone;

@property(nonatomic, copy)NSString *shortName;

@end

NS_ASSUME_NONNULL_END

/*
 
 sellerNick = "专卖店商城",
 earningTime = "",
 itemTitle = "驼背矫正带隐形透气肩背矫姿带成人姿势矫正器87",
 phone = "18653971367",
 payPrice = "29.90",
 sellerShopTitle = "好爱灸养生馆",
 yuguFree = "0.11",
 shortName = "巴瑞",
 itemNum = "1",
 price = "39.90",
 createTime = "2019-11-10 10:13:13",
 itemImg = "//img.alicdn.com/bao/uploaded/i4/124947927/O1CN019QIJrx28QcBMIMpYK_!!0-item_pic.jpg",
 orderType = "淘宝",
 tradeId = "567219781403027497",
 avatar = "http://thirdwx.qlogo.cn/mmopen/wFh4IX9hPhMFOr5KbPpWichOgXR8qicIxY1JKYdgCV8CnNer9SgtDfK8bs8kUAudeAiasIDbHPxiaZGN0rSlQ1E5YFk6C8gibNhY5/132",
 numIid = "607097102763",
 tkStatus = "12",
 */
