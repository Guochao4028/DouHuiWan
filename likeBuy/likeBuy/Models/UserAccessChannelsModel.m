//
//  UserAccessChannelsModel.m
//  likeBuy
//
//  Created by mac on 2019/10/19.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "UserAccessChannelsModel.h"

@implementation UserAccessChannelsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"modelId" : @"id",
             @"descriptionId" : @"description",
             };
}

@end
