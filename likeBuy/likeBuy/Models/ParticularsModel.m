//
//  ParticularsModel.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "ParticularsModel.h"

@implementation ParticularsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"Particularsid" : @"id"//前边的是你想用的key，后边的是返回的key
             };
}
@end
