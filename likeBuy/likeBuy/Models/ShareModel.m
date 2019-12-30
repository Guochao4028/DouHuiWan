//
//  ShareModel.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "ShareModel.h"

@implementation ShareModel

+(void) shareToWeChatToSession:(NSString*) title withDescription:(NSString*) description withThumbImage:(NSData*) thumbImageData withUrl:(NSString*) url{
    
    if ([WXApi isWXAppInstalled] == YES) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title =title;
        message.description = description;
        message.thumbData = thumbImageData;
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = url;
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneSession;
        [WXApi sendReq:req];
    }else{
        
        [MBProgressHUD wj_showError:@"请安装微信"];
    }
}

+(void) shareToWeChatToTimeline:(NSString*) title withDescription:(NSString*) description withThumbImage:(NSData*) thumbImageData withUrl:(NSString*) url{
    
    if ([WXApi isWXAppInstalled] == YES) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title =title;
        message.description = description;
        message.thumbData = thumbImageData;
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = url;
        message.mediaObject = ext;
        
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneTimeline;
        [WXApi sendReq:req];
    }else{
        
        [MBProgressHUD wj_showError:@"请安装微信"];
    }
    
}

+(void) shareToWeChatToTimeline:(NSData*) imageData{
    
    if ([WXApi isWXAppInstalled] == YES) {
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.thumbData = imageData;
        
        WXImageObject *ext = [WXImageObject object];
        ext.imageData = imageData;
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneTimeline;
        
        [WXApi sendReq:req];
    }else{
        
         [MBProgressHUD wj_showError:@"请安装微信"];
    }
    
}

+(void) shareToWeChatToSession:(NSData*) imageData{
    if ([WXApi isWXAppInstalled] == YES) {
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.thumbData = imageData;
        
        WXImageObject *ext = [WXImageObject object];
        ext.imageData = imageData;
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneSession;
        
        [WXApi sendReq:req];
    }else{
        [MBProgressHUD wj_showError:@"请安装微信"];
    }
}

@end
