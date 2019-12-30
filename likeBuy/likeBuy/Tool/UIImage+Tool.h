//
//  UIImage+Tool.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/18.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Tool)
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;

+ (UIImage *)snapshotWithView:(UIView *)view;

- (NSData *)newCompressImage:(UIImage *)image toByte:(NSUInteger)maxLength;

+(UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

/**
 两张图片合成一张

 @param size 合成图片的宽高
 @param image 第一张图片
 @param secondImage 第二张图片
 @return 新的图片
 */
+(UIImage *)imageSyntheticWithSize:(CGSize)size oneImage:(UIImage *)image twoImage:(UIImage *)secondImage;

+(UIImage*) compressImage:(UIImage*) image scaleToSize:(CGSize) newSize;


/**
 *生成清晰 二维码 图片
 *根据宽度 ciiimg二维码  生成一个uiimage 这个uiimage比较清晰
 *@param image 系统生成二维码
 *@param size 指定宽度
 */
+(UIImage *)resizeQRCodeImage:(CIImage *)image withSize:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
