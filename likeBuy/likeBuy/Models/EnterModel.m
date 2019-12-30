//
//  EnterModel.m
//  likeBuy
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "EnterModel.h"

@implementation EnterModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"enterId" : @"id"//前边的是你想用的key，后边的是返回的key
             };
}
@end
