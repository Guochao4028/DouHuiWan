//
//  User.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject<NSSecureCoding>


@property(nonatomic, copy)NSString *userid;

@property(nonatomic, copy)NSString *shortName;
//性别
@property(nonatomic, copy)NSString *sex;
//微信号
@property(nonatomic, copy)NSString *wxNo;
//电话
@property(nonatomic, copy)NSString *telephone;
//头像
@property(nonatomic, copy)NSString *avatar;

@property(nonatomic, copy)NSString *deviceOs;

@property(nonatomic, copy)NSString *appToken;

@property(nonatomic, copy)NSString *wxPubOpenId;

@property(nonatomic, copy)NSString *selfResqCode;

@property(nonatomic, copy)NSString *grade;

@property(nonatomic, copy)NSString *memberFlag;

@property(nonatomic, copy)NSString *rebateAmount;

@property(nonatomic, copy)NSString *extractableRebate;

@property(nonatomic, copy)NSString *aliAccount;

@property(nonatomic, copy)NSString *todayForecast;

@property(nonatomic, copy)NSString *montyForecast;

@property(nonatomic, copy)NSString *directFans;

@property(nonatomic, copy)NSString *otherFans;

@property(nonatomic, copy)NSString *tbUserNick;

@property(nonatomic, copy)NSString *tbUserId;

@property(nonatomic, copy)NSString *relationId;

@property (nonatomic,assign) BOOL  loginState;//登陆状态

@property(nonatomic, copy)NSString *rebateAmountStr;

//拼多多推广位
@property(nonatomic, copy)NSString *pddPid;

//京东推广位
@property(nonatomic, copy)NSString *jdlmPid;




@end

NS_ASSUME_NONNULL_END
