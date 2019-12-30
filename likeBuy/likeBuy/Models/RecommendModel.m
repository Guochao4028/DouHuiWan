//
//  RecommendModel.m
//  ALiLikePurchase
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"cText" : @"copy_text"//前边的是你想用的key，后边的是返回的key
             };
}

@end
