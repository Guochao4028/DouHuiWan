//
//  GoodsDetailModel.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/16.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GoodsModel;

@interface GoodsDetailModel : NSObject<NSCoding>

@property(nonatomic, copy)NSString *itemDescription;//
@property(nonatomic, copy)NSString *shopTitle;//
@property(nonatomic, copy)NSString *couponClickUrl;
@property(nonatomic, copy)NSString *couponEndTime;
@property(nonatomic, copy)NSString *sellerId;//
@property(nonatomic, strong) NSArray *smallImages;//
@property(nonatomic, copy)NSString *userType;// 1, 天猫， 0， 淘宝

@property(nonatomic, copy)NSString *volume;//
@property(nonatomic, copy)NSString *nick;//
@property(nonatomic, copy)NSString *couponInfo;
@property(nonatomic, copy)NSString *commissionRate;
@property(nonatomic, copy)NSString *title;//
@property(nonatomic, copy)NSString *reservePrice;
@property(nonatomic, copy)NSString *couponAfterPrice;
@property(nonatomic, copy)NSString *rebateAmount;//
@property(nonatomic, copy)NSString *numIid;//
@property(nonatomic, copy)NSString *pictUrl;//
@property(nonatomic, copy)NSString *zkFinalPrice;
@property(nonatomic, copy)NSString *couponStartTime;
@property(nonatomic, copy)NSString *coupon;
@property(nonatomic, copy)NSString *couponTpwd;
@property(nonatomic, copy)NSString *itemUrl;
@property(nonatomic, copy)NSString *itemTpwd;

@property(nonatomic, copy)NSString *taoShopUrl;


@property(nonatomic, strong)NSArray *evaluatesList;

@property(nonatomic, strong)NSString *iosStatue;

@property(nonatomic, strong)GoodsModel *goodsModel;

@property(nonatomic, copy)NSString *mid;
@property(nonatomic, copy)NSString *picUrl;

@property(nonatomic, copy)NSString *isfavorite;

@property(nonatomic, copy)NSString *qrcodeUrl;

@property(nonatomic, copy)NSString *materialUrl;


@end

NS_ASSUME_NONNULL_END


/*
 couponClickUrl = "https://uland.taobao.com/coupon/edetail?e=8V8KVIO5%2FlwGQASttHIRqTHIw7hE6zw3RZrpy0%2FCKX86iD6KoQzYE92gQ%2FzBvE6jvEPBo6KOVDKonjzirN2a3SFW0KfcUj%2B8Ci%2BP3nw3s2rKWwrD9A4T7vsnwWZGSCD41ug731VBEQm0m3Ckm6GN2CwynAdGnOngMmnVmWO1H8sdpsGU%2BrnkFFLajOROSSHl2g2BSCeDqWPsMlK0uFyiNQ%3D%3D&traceId=0b83323615659411502571877e&union_lens=lensId:0b1aff47_0c1a_16c995db273_9c91&xId=dcfV1nRfg9LBCMnle8PJJoHD0S5h1wXCDdfDCXiI61XONAc1wywZYbewPeOxGEXgCrIRXj9E6VBzzlOprTMD0Y",
 couponEndTime = "2019-08-20",
 reservePrice = "118",
 couponStartTime = "2019-08-14",
 couponAfterPrice = "29.9",
 couponInfo = "满49元减20元",
 coupon = "20",
 commissionRate = "3.27",
 couponTpwd = "￥agu6YQ6FYAK￥",
 itemUrl = "https://s.click.taobao.com/t?e=m%3D2%26s%3DDgBw%2FsayRS9w4vFB6t2Z2ueEDrYVVa64K7Vc7tFgwiHLWlSKdGSYDgtcZEz9cskxJ1gyddu7kN%2F4mcCD3vklbJaH%2FIfRRbNdfsNFS9SL2Q8ENdZ%2FPRwuhV%2FfT1GUiiZLnu9gcCeBZjxWMuL5DPBicgtkyqhBb5%2B4x8PUddoNe3CYK8l9%2BODvDJsz4nxZPn7s4JOed0Rxa6M2kemaWdsNQw8OTXUozqkq83a%2B%2FwxrQQmgDNxAbce%2BKcYl7w3%2FA2kb&union_lens=lensId:0b1aff47_0c1a_16c995db273_9c91&xId=dcfV1nRfg9LBCMnle8PJJoHD0S5h1wXCDdfDCXiI61XONAc1wywZYbewPeOxGEXgCrIRXj9E6VBzzlOprTMD0Y",
 itemTpwd = "￥Z1CmYQ6FfYU￥",
 zkFinalPrice = "49.9",
 */
