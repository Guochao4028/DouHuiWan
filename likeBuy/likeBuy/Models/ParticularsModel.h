//
//  ParticularsModel.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParticularsModel : NSObject

@property(nonatomic, copy)NSString *Particularsid;

@property(nonatomic, copy)NSString *avatar;

@property(nonatomic, copy)NSString *customerId;

@property(nonatomic, copy)NSString *grade;

@property(nonatomic, copy)NSString *gradeStr;

@property(nonatomic, copy)NSString *nickName;

@property(nonatomic, copy)NSString *phone;

@property(nonatomic, copy)NSString *aliAccount;

@property(nonatomic, copy)NSString *applyAmount;

@property(nonatomic, copy)NSString *applyDate;

@property(nonatomic, copy)NSString *checkFlg;

@end

NS_ASSUME_NONNULL_END

/*
 
 "id": 3,
 "customerId": "ed572fa23d2c42e6a651b5de9cda9fc7",
 "grade": "1",
 "gradeStr": "黄金会员",
 "nickName": "aaadi",
 "phone": "17625018494",
 "aliAccount": "jhmwfe8848@sandbox.com",
 "applyAmount": 5.00,
 "applyDate": 1565768617000,
 "checkFlg": "2"
 
 */
