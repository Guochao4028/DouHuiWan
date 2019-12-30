//
//  QuestionListDataModel.m
//  likeBuy
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "QuestionListDataModel.h"

@implementation QuestionListDataModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"questionId" : @"id"//前边的是你想用的key，后边的是返回的key
             };
}
@end
