//
//  RecommendModel.h
//  ALiLikePurchase
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommendModel : NSObject

@property(nonatomic, copy)NSString *product_id;//自增ID

@property(nonatomic, copy)NSString *itemid;//宝贝ID

@property(nonatomic, copy)NSString *time;//发布时间时间戳

@property(nonatomic, copy)NSString *itemshorttitle;//宝贝短标题

@property(nonatomic, copy)NSString *itemprice;//在售价

@property(nonatomic, copy)NSString *itempic;//

@property(nonatomic, copy)NSString *itemendprice;//宝贝券后价

@property(nonatomic, copy)NSString *shoptype;//店铺类型： 天猫（B） 淘宝店（C）

@property(nonatomic, copy)NSString *couponurl;//优惠券链接

@property(nonatomic, copy)NSString *couponmoney;//优惠券金额

@property(nonatomic, copy)NSString *tkrates;//佣金比例

@property(nonatomic, copy)NSString *tkmoney;//预计可得（宝贝价格 * 佣金比例 / 100）

@property(nonatomic, copy)NSString *text;//文案展示内容

@property(nonatomic, copy)NSString *cText;//文案复制内容

@property(nonatomic, strong)NSArray *pics;//小图

@property(nonatomic, assign)CGFloat tableViewH;

@end

NS_ASSUME_NONNULL_END


/*
 tkrates = "20.10",
 itemshorttitle = "jayjun旗舰店-洛神花眼膜贴",
 itempic = "https://img.alicdn.com/imgextra/i2/3160871576/O1CN012svswx1NVqkmrbP1J_!!3160871576.jpg",
 couponmoney = "60",
 time = "1568115900",
 itemprice = "99.00",
 itemendprice = "39.00",
 copy_text = "【买家实拍】味道香香的，用在眼周感觉给皮肤喝饱水的感觉，用久了感觉黑眼圈也有消散的迹象。&lt;br&gt;给自己来个护眼SPA[耶]&lt;br&gt;jayjun洛神花眼膜贴&lt;br&gt;券后💰39&lt;br&gt;一片就能立刻缓解疲劳&lt;br&gt;👀新时代眼护必备神器！&lt;br&gt;——————————&lt;br&gt;",
 product_id = "28722224",
 tkmoney = "7.84",
 itemid = "593424472672",
 shoptype = "B",
 text = "&lt;item&gt;&lt;cw&gt;&lt;br&gt;【买家实拍】味道香香的，用在眼周感觉给皮肤喝饱水的感觉，用久了感觉黑眼圈也有消散的迹象。给自己来个护眼SPA&lt;img src='http://img.haodanku.com/Fk6qitiomPOPoidFlmEIq1Q6ulFc'&gt;&lt;br&gt;jayjun洛神花眼膜贴&lt;br&gt;券后&lt;img src='http://img.haodanku.com/3_bqfh76.png'&gt;39&lt;br&gt;一片就能立刻缓解疲劳&lt;br&gt;&lt;img src='http://img.haodanku.com/1_bqfh101.png'&gt;新时代眼护必备神器！&lt;br&gt;——————————&lt;br&gt;&lt;cw&gt;&lt;item&gt;",
 pics =     (
 "http://img.alicdn.com/bao/uploaded/i4/3160871576/O1CN01oIOjjQ1NVqkloitxm_!!0-item_pic.jpg",
 "http://img.alicdn.com/bao/uploaded/i1/3160871576/O1CN01dNRNsC1NVqk9goH4q_!!2-item_pic.png",
 "http://img.alicdn.com/bao/uploaded/i1/3160871576/O1CN01bQJXyd1NVqjnzLYbs_!!3160871576.jpg",
 "http://img.alicdn.com/bao/uploaded/i3/3160871576/O1CN01Q2CkZM1NVqjQydO9p_!!3160871576.jpg",
 "http://img.alicdn.com/bao/uploaded/i1/3160871576/O1CN01hLE8Ks1NVqhax90qV_!!3160871576.jpg",
 ),
 couponurl = "https://uland.taobao.com/quan/detail?sellerId=3160871576&activityId=e73397e5215548a2908f926f877c10cd",
 */
