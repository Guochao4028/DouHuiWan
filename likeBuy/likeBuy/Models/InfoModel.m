//
//  InfoModel.m
//  likeBuy
//
//  Created by mac on 2019/10/27.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "InfoModel.h"

@implementation InfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"infoId" : @"id",
             };
}

@end
