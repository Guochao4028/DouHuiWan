//
//  CategoryModel.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"categoryId" : @"id",
             };
}


+ (NSDictionary *)mj_objectClassInArray{
    return @{@"chiledList" : @"CategorySecondClassModel"};//前边，是属性数组的名字，后边就是类名
}
@end
