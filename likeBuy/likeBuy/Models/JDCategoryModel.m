//
//  JDCategoryModel.m
//  likeBuy
//
//  Created by mac on 2019/11/11.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "JDCategoryModel.h"

@implementation JDCategoryModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"jdCategoryId" : @"id",
             };
}

@end
