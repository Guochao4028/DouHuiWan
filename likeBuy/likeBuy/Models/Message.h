//
//  Message.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Message : NSObject

@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,strong) NSString * reason;

@property(nonatomic, strong)NSArray *modelList;

@property(nonatomic, strong)NSString *code;

@end

NS_ASSUME_NONNULL_END
