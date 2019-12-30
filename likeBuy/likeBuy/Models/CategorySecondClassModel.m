//
//  CategorySecondClassModel.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "CategorySecondClassModel.h"

@implementation CategorySecondClassModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"categoryId" : @"id",
             };
}

@end
