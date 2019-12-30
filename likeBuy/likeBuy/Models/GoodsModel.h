//
//  GoodsModel.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/16.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsModel : NSObject<NSCoding>

@property(nonatomic, copy)NSString *itemDescription;
@property(nonatomic, copy)NSString *shopTitle;
@property(nonatomic, copy)NSString *couponClickUrl;
@property(nonatomic, copy)NSString *couponEndTime;
@property(nonatomic, copy)NSString *sellerId;
@property(nonatomic, strong) NSArray *smallImages;
@property(nonatomic, copy)NSString *userType;
@property(nonatomic, copy)NSString *volume;
@property(nonatomic, copy)NSString *nick;
@property(nonatomic, copy)NSString *couponInfo;
@property(nonatomic, copy)NSString *commissionRate;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *reservePrice;
@property(nonatomic, copy)NSString *couponAfterPrice;
@property(nonatomic, copy)NSString *rebateAmount;
@property(nonatomic, copy)NSString *numIid;
@property(nonatomic, copy)NSString *pictUrl;
@property(nonatomic, copy)NSString *zkFinalPrice;


@property(nonatomic, copy)NSString *materialUrl;

@property(nonatomic, strong)NSDictionary *isComm;

@end

NS_ASSUME_NONNULL_END


/*
 
 itemDescription = "光学uv全屏无缝隙，防污防指纹，触感灵敏",
 shopTitle = "义恒数码专营店",
 couponClickUrl = "https://uland.taobao.com/coupon/edetail?e=TZBCV1ZjBIoGQASttHIRqR7paIcQ0Q4a%2B8tGCSCYexmJBiHzvBsckbILlwNtQ49oSQuYk5DrRgvgOirnV%2F43MIb2tdSrUKqwm4VLH9mslwwyKVeZ4tKgy5DOmzY0xaEQIyGgr95D9Bb6JdLl2aN8M4ct90qKVfF%2FGkAdz%2BZIZ6utHUrzULdXCnYefz8NXcoYTJnbK5InWzlFfSAQOJJoy%2FdCLQnHbiQWtFpQEeaj4k%2Fom9kMiklcP0rjocr09cIe&traceId=0b0baf5915659254284151034e",
 couponEndTime = "2019-09-15",
 sellerId = 2211264479,
 smallImages =     (
 "http://img.alicdn.com/tfscom/i1/2211264479/O1CN013KSpWb1ixQTtE988O_!!2211264479.jpg",
 "http://img.alicdn.com/tfscom/i1/2211264479/O1CN01Vmriao1ixQTs3pkfN_!!2211264479.jpg",
 "http://img.alicdn.com/tfscom/i1/2211264479/O1CN01uX5T4f1ixQTuY4kFT_!!2211264479.jpg",
 "http://img.alicdn.com/tfscom/i1/2211264479/O1CN011NkF321ixQTtpL3a5_!!2211264479.jpg",
 ),
 userType = 1,
 volume = 10,
 nick = "义恒数码专营店",
 couponInfo = "满25元减5元",
 commissionRate = "0.73",
 title = "三星s10钢化膜s10+plus手机膜光学uv膜s10e全屏覆盖热弯曲面屏全包边s10lite高清防指纹玻璃膜无网点水凝防摔",
 reservePrice = "",
 couponAfterPrice = "28.0",
 rebateAmount = "50.0",
 numIid = 588108372995,
 pictUrl = "http://img.alicdn.com/tfscom/i4/2211264479/O1CN014D5Z061ixQTrK0Lw7_!!0-item_pic.jpg",
 zkFinalPrice = "33.00",
 
 */
