//
//  NSString+Tool.h
//  likeBuy
//
//  Created by mac on 2019/9/17.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

/**
 字符串的扩展类，以后所有关于字符串的扩展都写在这里
 */
@interface NSString (Tool)

/**
 判断是否是正确的手机号
 */
- (BOOL)isRightPhoneNumber;

/**
 格式化手机号
 */
+(NSString *)formatPhoneNumber:(NSString *)phoneNumberStr delBlank:(BOOL)isDelBlank;

/** 小写加密*/
+ (NSString *)md5HexDigest:(NSString*)input;

/** 大写加密*/
+ (NSString *)MD5HexDigest:(NSString*)input;

/** 16位MD5加密方式   大写*/
+ (NSString *)md5sss:(NSString *)str;

/** 32位MD5加密方式   大写*/
+ (NSString *)md5sssLiu:(NSString *)str;

/** 验证邮箱*/
+ (BOOL)validateEmail:(NSString *)email;

 /** 判断字符串是否为数字*/
+ (BOOL)isNumber:(NSString *)strValue;

/// 返回 富文本字符串， 只用作TextFiled
/// @param word 提示词
/// @param view TextFiled
+(NSAttributedString *)attributedPlaceholder:(NSString *)word inView:(UIView *)view;

/**
 *时间字符串截取年月日
 *截取前 2019-11-02 00:00:00
 *截取后 2019-11-02
 */
+(NSString *)timeStringInterception:(NSString *)timeStr;

///判断字符串是纯汉字
-(BOOL)isChinese;

-(BOOL)isURL;


@end

NS_ASSUME_NONNULL_END
