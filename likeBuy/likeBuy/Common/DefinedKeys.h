//
//  DefinedKeys.h
//  likeBuy
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#ifndef DefinedKeys_h
#define DefinedKeys_h

#define ScreenWidth [[UIScreen mainScreen]bounds].size.width

#define ScreenHeight [[UIScreen mainScreen]bounds].size.height

#define SHOWTIME 0.6
//iPhone 6 的高
#define IPHONE6HEIGHT 667
//iPhone 6 的宽
#define IPHONE6WIDTH  375
//高度比
#define HEIGHTPROPROTION (ScreenHeight / IPHONE6HEIGHT)
//宽度比
#define WIDTHTPROPROTION (ScreenWidth / IPHONE6WIDTH)
// 检查系统版本
#define iOS_SYSTEM_VERSION(VERSION) ([[UIDevice currentDevice].systemVersion doubleValue] >= VERSION)

#define NavigatorHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64)

#define TabbarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

#define BOTTOM_MARGIN_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0)

#define RegularFont @"PingFangSC-Regular"

#define MediumFont @"PingFangSC-Medium"

#define WINXINAPPID @"wxf4cb791dc86eb889"

#define WINXINAPPSECRET @"35614ff900dfae36bb036061f1010292"

#define CODE @"code"//状态码

#define DATAS @"data"//数据

#define ERROR @"error"//错误

#define TOKEN    @"appToken"

#define BAICHUANAPPID @"28052033"

#define BAICHUANAPPSECRET @"af91bc6e8a4ea979fbc109ee59f3c235"

#define NOTIFICATIONLOGIN  @"NotificationLogin"

#define NOTIFICATIONREDPOINT  @"NotificationRedPoint"



#define NOTIFICATIONCOPYTEXT  @"NotificationCopyText"

#define LOGFINISH  @"logfinish"

#define RENOVATE  @"renovate"

#define ZD_IS_APP_FIRSTRUN @"isAppFirstRun"//是否是第一次启动

#define ZD_LAST_RUN_VERSION @"last_run_version"  //最后一次运行版本（判断引导页用）

#define ZD_CURRENT_VERSION @"10"//本地版本

#define ADVERTISEMENT_URL @"advertisement_url"

#define ADVERTISEMENT_IMAGEURL @"advertisement_imageUrl"

#define SHOWCONFIG       @"showconfig"

#define VERSION @"v1.0"



#define NOTIFICATIONCHANGE  @"NotificationChange"

#define NOTIFICATIONCHANGEEND  @"NotificationChangeEnd"

#define NOTIFICATIONCHANGEBEGIN  @"NotificationChangeBegin"



#endif /* DefinedKeys_h */
