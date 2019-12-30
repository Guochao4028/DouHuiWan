//
//  UIColor+HexColors.m
//  KiwiHarness
//
//  Created by Tim on 07/09/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "UIColor+HexColors.h"

@implementation UIColor (HexColors)

+(UIColor *)colorWithHexString:(NSString *)hexString {

//    if ([hexString length] != 6) {
//        return nil;
//    }
//
//    // Brutal and not-very elegant test for non hex-numeric characters
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-fA-F|0-9]" options:0 error:NULL];
//    NSUInteger match = [regex numberOfMatchesInString:hexString options:NSMatchingReportCompletion range:NSMakeRange(0, [hexString length])];
//
//    if (match != 0) {
//        return nil;
//    }
//
//    NSRange rRange = NSMakeRange(0, 2);
//    NSString *rComponent = [hexString substringWithRange:rRange];
//    NSUInteger rVal = 0;
//    NSScanner *rScanner = [NSScanner scannerWithString:rComponent];
//    [rScanner scanHexInt:(unsigned int *)&rVal];
//    float rRetVal = (float)rVal / 254;
//
//
//    NSRange gRange = NSMakeRange(2, 2);
//    NSString *gComponent = [hexString substringWithRange:gRange];
//    NSUInteger gVal = 0;
//    NSScanner *gScanner = [NSScanner scannerWithString:gComponent];
//    [gScanner scanHexInt:(unsigned int *)&gVal];
//    float gRetVal = (float)gVal / 254;
//
//    NSRange bRange = NSMakeRange(4, 2);
//    NSString *bComponent = [hexString substringWithRange:bRange];
//    NSUInteger bVal = 0;
//    NSScanner *bScanner = [NSScanner scannerWithString:bComponent];
//    [bScanner scanHexInt:(unsigned int *)&bVal];
//    float bRetVal = (float)bVal / 254;
//
//    return [UIColor colorWithRed:rRetVal green:gRetVal blue:bRetVal alpha:1.0f];
        
        if (![hexString isKindOfClass:[NSString class]] || [hexString length] == 0)
           {
               return [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
           }

           const char *s = [hexString cStringUsingEncoding:NSASCIIStringEncoding];
           if (*s == '#')
           {
               ++s;
           }
           unsigned long long value = strtoll(s, nil, 16);
           int r, g, b, a;
           switch (strlen(s))
           {
               case 2:
                   // xx
                   r = g = b = (int)value;
                   a = 255;
                   break;
               case 3:
                   // RGB
                   r = ((value & 0xf00) >> 8);
                   g = ((value & 0x0f0) >> 4);
                   b = ((value & 0x00f) >> 0);
                   r = r * 16 + r;
                   g = g * 16 + g;
                   b = b * 16 + b;
                   a = 255;
                   break;
               case 6:
                   // RRGGBB
                   r = (value & 0xff0000) >> 16;
                   g = (value & 0x00ff00) >> 8;
                   b = (value & 0x0000ff) >> 0;
                   a = 255;
                   break;
               default:
                   // RRGGBBAA
                   r = (value & 0xff000000) >> 24;
                   g = (value & 0x00ff0000) >> 16;
                   b = (value & 0x0000ff00) >> 8;
                   a = (value & 0x000000ff) >> 0;
                   break;
           }
           return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a / 255.0f];
        
}

+(NSString *)hexValuesFromUIColor:(UIColor *)color {
    
    if (!color) {
        return nil;
    }
    
    if (color == [UIColor whiteColor]) {
        // Special case, as white doesn't fall into the RGB color space
        return @"ffffff";
    }
 
    CGFloat red;
    CGFloat blue;
    CGFloat green;
    CGFloat alpha;
    
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    int redDec = (int)(red * 255);
    int greenDec = (int)(green * 255);
    int blueDec = (int)(blue * 255);
    
    NSString *returnString = [NSString stringWithFormat:@"%02x%02x%02x", (unsigned int)redDec, (unsigned int)greenDec, (unsigned int)blueDec];

    return returnString;
    
}


+ (UIColor *)getColorWithColor:(UIColor *)beginColor andCoe:(double)coe  andEndColor:(UIColor *)endColor {
    NSArray *beginColorArr = [self getRGBDictionaryByColor:beginColor];
    NSArray *marginArray = [self transColorBeginColor:beginColor andEndColor:endColor];
    double red = [beginColorArr[0] doubleValue] + coe * [marginArray[0] doubleValue];
    double green = [beginColorArr[1] doubleValue] + coe * [marginArray[1] doubleValue];
    double blue = [beginColorArr[2] doubleValue] + coe * [marginArray[2] doubleValue];
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (NSArray *)getRGBDictionaryByColor:(UIColor *)originColor {
    CGFloat r = 0,g = 0,b = 0,a = 0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [originColor getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        const CGFloat *components = CGColorGetComponents(originColor.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    return @[@(r),@(g),@(b)];
}

+ (NSArray *)transColorBeginColor:(UIColor *)beginColor andEndColor:(UIColor *)endColor {
    NSArray<NSNumber *> *beginColorArr = [self getRGBDictionaryByColor:beginColor];
    NSArray<NSNumber *> *endColorArr = [self getRGBDictionaryByColor:endColor];
    return @[@([endColorArr[0] doubleValue] - [beginColorArr[0] doubleValue]),@([endColorArr[1] doubleValue] - [beginColorArr[1] doubleValue]),@([endColorArr[2] doubleValue] - [beginColorArr[2] doubleValue])];
}

@end
