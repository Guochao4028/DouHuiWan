//
//  PddGoodsCat.h
//  likeBuy
//
//  Created by mac on 2019/11/8.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PddGoodsCat : NSObject

@property(nonatomic, copy)NSString *catId;
@property(nonatomic, copy)NSString *catName;
@property(nonatomic, copy)NSString *level;
@property(nonatomic, copy)NSString *parentCatId;

@end

NS_ASSUME_NONNULL_END


//catId = 239,
//catName = "男装",
//level = 1,
//parentCatId = 0,
