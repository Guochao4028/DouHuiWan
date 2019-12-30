//
//  FansModel.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "FansModel.h"

@implementation FansModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"fansid" : @"id"//前边的是你想用的key，后边的是返回的key
             };
}

@end
