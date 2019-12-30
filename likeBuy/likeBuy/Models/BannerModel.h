//
//  BannerModel.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/16.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerModel : NSObject

@property(nonatomic, copy)NSString *imgID;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *sort;
@property(nonatomic, copy)NSString *imgUrl;
@property(nonatomic, copy)NSString *toUrl;
@property(nonatomic, copy)NSString *level;

@property(nonatomic, copy)NSString *colour;


@end

NS_ASSUME_NONNULL_END
