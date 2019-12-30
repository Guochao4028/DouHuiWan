//
//  GoodsDBModel.h
//  ALiLikePurchase
//
//  Created by mac on 2019/9/11.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsDBModel : NSObject
@property (nullable, nonatomic, strong) NSData *goodsData;
@property (nullable, nonatomic, copy) NSString *goodsId;
@property (nullable, nonatomic, copy) NSString *time;
@property (nullable, nonatomic, copy) NSString *isFav;
@property (nullable, nonatomic, copy) NSString *token;
@end

NS_ASSUME_NONNULL_END
