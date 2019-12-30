//
//  ShopModel.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/29.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopModel : NSObject<NSCoding>

@property(nonatomic, copy)NSString *score;
@property(nonatomic, copy)NSString *levelText;
@property(nonatomic, copy)NSString *title;

@end

NS_ASSUME_NONNULL_END


/*
 {"score":"4.7 ","levelText":"4.7 ","title":"物流服务"}
 */
