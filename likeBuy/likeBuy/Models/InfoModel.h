//
//  InfoModel.h
//  likeBuy
//
//  Created by mac on 2019/10/27.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoModel : NSObject

@property(nonatomic, copy)NSString *statue;
@property(nonatomic, copy)NSString *infoId;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *message;
@property(nonatomic, copy)NSString *type;
@property(nonatomic, copy)NSString *crTime;
@property(nonatomic, copy)NSString *url;
@property(nonatomic, copy)NSString *mid;

@end

NS_ASSUME_NONNULL_END




//{
//    statue = 1,
//    id = 7,
//    title = "测试",
//    message = "测试",
//    type = 1,
//    crTime = "2019-10-23 19:54:26",
//},
