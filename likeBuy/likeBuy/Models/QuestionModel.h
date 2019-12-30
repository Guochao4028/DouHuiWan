//
//  QuestionModel.h
//  likeBuy
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuestionModel : NSObject

@property(nonatomic, copy)NSString *group;

@property(nonatomic, copy)NSString *title;

@property(nonatomic, copy)NSString *code;

@end

NS_ASSUME_NONNULL_END


/**
 
 group = "problem_self_order",
 title = "自营订单",
 code = 20,
 */
