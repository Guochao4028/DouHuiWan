//
//  EnterModel.h
//  likeBuy
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EnterModel : NSObject

@property(nonatomic, copy)NSString *statue;
@property(nonatomic, copy)NSString *pid;
@property(nonatomic, copy)NSString *enterId;
@property(nonatomic, copy)NSString *image;
@property(nonatomic, copy)NSString *type;
@property(nonatomic, copy)NSString *desc;
@property(nonatomic, copy)NSString *seq;

@end

NS_ASSUME_NONNULL_END

/*
statue = 0,
pid = 0,
id = 2,
image = "http://api.5138fun.com:8888/image/logo/jd@3x.png",
type = 2,
desc = "京东",
seq = 2,
*/
