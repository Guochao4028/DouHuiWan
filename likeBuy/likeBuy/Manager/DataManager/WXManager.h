//
//  WXManager.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/23.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXManager : NSObject
/**
 *  获取微信用户信息
 *
 *  @param accessToken access token
 *  @param openId      openId
 *
 *  @return åå{
 "openid":"OPENID",
 "nickname":"NICKNAME",
 "sex":1,
 "province":"PROVINCE",
 "city":"CITY",
 "country":"COUNTRY",
 "headimgurl": "http://wx.qlogo.cn/mmopen/g3MonUZtNHkdmzicIlibx6iaFqAc56vxLSUfpb6n5WKSYVY0ChQKkiaJSgQ1dZuTOgvLLrhJbERQQ4eMsv84eavHiaiceqxibJxCfHe/0",
 "privilege":[
 "PRIVILEGE1",
 "PRIVILEGE2"
 ],
 "unionid": " o6_bmasdasdsad6_2sgVt7hMZOPfL"
 
 }
 
 */
-(NSDictionary*) getWeiXinUserInfo:(NSString*) accessToken withOpenId:(NSString*) openId;
/**
 *  验证 access token 是否有效
 *
 *  @param accessToken Token
 *  @param openId OpenId
 *  @return {
 "errcode":0,"errmsg":"ok"
 }
 */
-(NSDictionary*) isInvalidOfAccessToken:(NSString*) accessToken withOpenId:(NSString*) openId;

/**
 *  获取微信RefreshToken
 *
 *  @param refreshToken refresh Token
 *  @return {
 "access_token":"ACCESS_TOKEN",
 "expires_in":7200,
 "refresh_token":"REFRESH_TOKEN",
 "openid":"OPENID",
 "scope":"SCOPE"
 }
 */
-(NSDictionary*) getWeiXinRefreshToken:(NSString*) refreshToken;


/**
 *  获取微信的access token
 *
 *  @param code Code
 *  @return {
 "access_token":"ACCESS_TOKEN",
 "expires_in":7200,
 "refresh_token":"REFRESH_TOKEN",
 "openid":"OPENID",
 "scope":"SCOPE"
 }
 */
-(NSDictionary*) getWeiXinAccessTokenFromCode:(NSString*) code;

@end

NS_ASSUME_NONNULL_END
