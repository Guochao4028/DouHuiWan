//
//  WXManager.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/23.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "WXManager.h"

@implementation WXManager

-(NSDictionary*) getWeiXinAccessTokenFromCode:(NSString*) code{
    //URL
    NSString *url =  [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WINXINAPPID,WINXINAPPSECRET,code];
    
    return [self getDictionaryFromURL:url];
}

-(NSDictionary*) getWeiXinRefreshToken:(NSString*) refreshToken{
    
    //URL
    NSString *url =  [NSString stringWithFormat:@"//https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@",WINXINAPPID,refreshToken];
    
    return [self getDictionaryFromURL:url];
}



-(NSDictionary*) isInvalidOfAccessToken:(NSString*) accessToken withOpenId:(NSString*) openId{
    
    //URL
    NSString *url =  [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/auth?access_token=%@&openid=%@",WINXINAPPID,openId];
    
    
    return [self getDictionaryFromURL:url];
    
    
}


-(NSDictionary*) getWeiXinUserInfo:(NSString*) accessToken withOpenId:(NSString*) openId{
    
    //URL
    NSString *url =  [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openId];
    
    
    return [self getDictionaryFromURL:url];
    
}

-(NSDictionary*) getDictionaryFromURL:(NSString*) url{
    
    NSDictionary * dictionary;
    
    //Request
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
    
    //NSURLConnection
    NSURLResponse * response;
    NSError * error;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (!error && data) {
        
        dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        
    }
    
    return dictionary;
    
}

@end
