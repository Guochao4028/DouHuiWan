//
//  Utilities.m
//  帮助与反馈
//
//  Created by Kevin on 2017/8/25.
//  Copyright © 2017年 Dongxk. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities


+ (UIColor *)getColor:(NSString *)hexColor
{
    if (hexColor.length<=0) {
        return [UIColor clearColor];
    }
    
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}


@end
