//
//  NSString+Tool.m
//  likeBuy
//
//  Created by mac on 2019/9/17.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "NSString+Tool.h"

#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Tool)
/// 判断是否是正确的手机号
- (BOOL)isRightPhoneNumber{
    // 定义正则语句
    NSString *str = @"^(13|14|15|17|18)+\\d{9}$";
    // 定义一个谓词对象
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",str];
    // 判断是否符合
    return [pre evaluateWithObject:self];
}


///格式化手机号
+(NSString *)formatPhoneNumber:(NSString *)phoneNumberStr delBlank:(BOOL)isDelBlank{
    NSString *newStr;
    if (isDelBlank == YES) {
        newStr = [phoneNumberStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    }else{
        NSMutableString * str = [NSMutableString stringWithFormat:@"%@", phoneNumberStr];
        if (phoneNumberStr.length >= 11) {
            [str insertString:@" " atIndex:(3)];
            [str insertString:@" " atIndex:(8)];
        }
       
        newStr = str;
    }
    return newStr;
}

//小写验证码
+ (NSString *)md5HexDigest:(NSString*)input{
    const char* str = [input UTF8String];
    uint8_t result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

//大写验证码
+ (NSString *)MD5HexDigest:(NSString*)input{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}

//16位MD5加密方式   大写
+ (NSString *)md5sss:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr),result);
    return [NSString stringWithFormat:@"%X%X%X%X%X%X%X%X",result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11]];
}

/*验证邮箱*/
+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//32位MD5加密方式   大写
+ (NSString *)md5sssLiu:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr),result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3],result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
}

- (NSString *)sha1String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)sha224String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA224_DIGEST_LENGTH];
    
    CC_SHA224(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA224_DIGEST_LENGTH];
}

- (NSString *)sha256String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha384String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA384_DIGEST_LENGTH];
    
    CC_SHA384(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA384_DIGEST_LENGTH];
}

- (NSString *)sha512String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - HMAC 散列函数
- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgMD5, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA512, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - 文件散列函数

#define FileHashDefaultChunkSizeForReadingData 4096

- (NSString *)fileMD5Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_MD5_CTX hashCtx;
    CC_MD5_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_MD5_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)fileSHA1Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA1_CTX hashCtx;
    CC_SHA1_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA1_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)fileSHA256Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA256_CTX hashCtx;
    CC_SHA256_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA256_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)fileSHA512Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA512_CTX hashCtx;
    CC_SHA512_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA512_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

/**
 *  返回二进制 Bytes 流的字符串表示形式
 *
 *  @param bytes  二进制 Bytes 数组
 *  @param length 数组长度
 *
 *  @return 字符串表示形式
 */
- (NSString *)stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    
    return [strM copy];
}

+ (BOOL)isNumber:(NSString *)strValue{
    if (strValue == nil || [strValue length] <= 0)
    {
        return NO;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[strValue componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if (![strValue isEqualToString:filtered])
    {
        return NO;
    }
    return YES;
}

/**  返回 富文本字符串， 只用作TextFiled */
+(NSAttributedString *)attributedPlaceholder:(NSString *)word inView:(UITextField *)textField{
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:word attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:textField.font }];
    return attrString;
}

/**
 *时间字符串截取年月日
 */
+(NSString *)timeStringInterception:(NSString *)timeStr{
    return [timeStr substringToIndex:10];
}


///判断字符串是纯汉字
-(BOOL)isChinese{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSString *str = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}


-(BOOL)isURL{
    if (([self rangeOfString:@"http"].location == NSNotFound) && [self rangeOfString:@"https"].location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}





@end
