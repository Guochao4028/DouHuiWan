//
//  ShareModel.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareModel : NSObject

/**
 发送一张信息到微信好友
 */
+(void) shareToWeChatToSession:(NSString*) title withDescription:(NSString*) description withThumbImage:(NSData*) thumbImageData withUrl:(NSString*) url;

/**
 发送一张信息到朋友圈
 */
+(void) shareToWeChatToTimeline:(NSString*) title withDescription:(NSString*) description withThumbImage:(NSData*) thumbImageData withUrl:(NSString*) url;

/**
 发送一张图片到朋友圈
 */
+(void) shareToWeChatToTimeline:(NSData*) imageData;

/**
 发送一张图片到微信好友
 */
+(void) shareToWeChatToSession:(NSData*) imageData;

@end

NS_ASSUME_NONNULL_END
