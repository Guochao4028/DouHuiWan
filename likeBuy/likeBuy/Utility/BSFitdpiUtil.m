//
//  BSFitdpiUtil.m
//  Ali Huishou
//
//  Created by 胡占峰 on 2019/8/8.
//  Copyright © 2019 liuzhuang. All rights reserved.
//

#import "BSFitdpiUtil.h"

@implementation BSFitdpiUtil

+ (CGFloat)adaptWidthWithValue:(CGFloat)floatV;
{
    return floatV*[[UIScreen mainScreen] bounds].size.width/kRefereWidth;
}

@end
