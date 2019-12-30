//
//  UIImage+Tool.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/18.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage (Tool)

#pragma mark - 压缩图片
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}

#pragma mark - 压缩图片
- (NSData *)newCompressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
       CGFloat compression = 1;
       NSData *data = UIImageJPEGRepresentation(image, compression);
       if (data.length < maxLength) return data;
       CGFloat max = 1;
       CGFloat min = 0;
       for (int i = 0; i < 6; ++i) {
           compression = (max + min) / 2;
           data = UIImageJPEGRepresentation(image, compression);
           if (data.length < maxLength * 0.9) {
               min = compression;
           } else if (data.length > maxLength) {
               max = compression;
           } else {
               break;
           }
       }
       UIImage *resultImage = [UIImage imageWithData:data];
       if (data.length < maxLength) return data;
       
       // Compress by size
       NSUInteger lastDataLength = 0;
       while (data.length > maxLength && data.length != lastDataLength) {
           lastDataLength = data.length;
           CGFloat ratio = (CGFloat)maxLength / data.length;
           CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                    (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
           UIGraphicsBeginImageContext(size);
           [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
           resultImage = UIGraphicsGetImageFromCurrentImageContext();
           UIGraphicsEndImageContext();
           data = UIImageJPEGRepresentation(resultImage, compression);
       }
       
       return data;
}


#pragma mark - uiview 生成图片
+ (UIImage *)snapshotWithView:(UIView *)view
{
    CGSize size = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) ==NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) *0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) *0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage *)imageSyntheticWithSize:(CGSize)size oneImage:(UIImage *)image twoImage:(UIImage *)secondImage{

    CGFloat gap = size.width *0.3;
    
    CGFloat imageWidth = (size.width - gap)/2;
    
    CGFloat imageHeight = size.height;
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, imageWidth,imageHeight)];
    
    [secondImage drawInRect:CGRectMake((imageWidth + gap), 0, imageWidth,imageHeight)];
    
    UIImage *ZImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return ZImage;
}

+(UIImage*) compressImage:(UIImage*) image scaleToSize:(CGSize) newSize{
    //1:计算
    CGFloat originalWidth =  image.size.width;
    CGFloat originalHeight = image.size.height;
    CGFloat originalRate = originalWidth / originalHeight;
    CGFloat finalRate = newSize.width / newSize.height;
    CGFloat finalWidth = newSize.width;
    CGFloat finalHeight = newSize.height;
    if (originalRate > finalRate) {
        finalWidth = newSize.width;
        finalHeight = originalHeight / (originalWidth / newSize.width);
    }else if(originalRate < finalRate){
        finalWidth = originalWidth / (originalHeight / newSize.height);
        finalHeight = newSize.height;
    }else{
        finalWidth = newSize.width;
        finalHeight = newSize.height;
    }
    CGSize finalSize = CGSizeMake(finalWidth, finalHeight);
    UIGraphicsBeginImageContext(finalSize);
    [image drawInRect:CGRectMake(0,0,finalWidth,finalHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+(UIImage *)resizeQRCodeImage:(CIImage *)image withSize:(CGFloat)size{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    
    CGContextRef contextRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
    CGContextScaleCTM(contextRef, scale, scale);
    CGContextDrawImage(contextRef, extent, imageRef);
    
    CGImageRef imageRefResized = CGBitmapContextCreateImage(contextRef);
    
    //Release
    CGContextRelease(contextRef);
    CGImageRelease(imageRef);
    return [UIImage imageWithCGImage:imageRefResized];
}

@end
