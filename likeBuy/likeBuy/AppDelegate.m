//
//  AppDelegate.m
//  likeBuy
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "AppDelegate.h"

#import <AlibcTradeSDK/AlibcTradeSDK.h>

#import "DataManager.h"

#import "DHLaunchAdPageHUD.h"
#import "LaunchViewController.h"

#import "RootViewController.h"

#import "DetailViewController.h"

#import "DBManager.h"

#import "GoodsModel.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface AppDelegate ()<WXApiDelegate, JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    [self.window makeKeyAndVisible];
    RootViewController *rootViewController = [[RootViewController alloc]init];
    
    //    UINavigationController *nav= [[UINavigationController alloc]initWithRootViewController:rootViewController];
    
    self.window.rootViewController = rootViewController;
    
    //注册百川
    [self registerBaiChuan];
    // 注册微信
    [self registerWeiXin];
    
    //广告启动页
    [self initLaunchImageAdView];
    
    //注册极光推送
    [self registerNotifications:launchOptions];
    
    //消除所有推送红点
    [JPUSHService setBadge:0];
    [JPUSHService resetBadge];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATIONCOPYTEXT object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer  API_AVAILABLE(ios(10.0)){
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"likeBuy"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if (![[AlibcTradeSDK sharedInstance]application:app openURL:url sourceApplication:sourceApplication annotation:annotation]) {
        
    }
    
    [WXApi handleOpenURL:url delegate:self];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    __unused BOOL isHandledByALBSDK = [[AlibcTradeSDK sharedInstance]application:app openURL:url options:options];
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}


/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp 具体的回应内容，是自动释放的
 */


-(void) onResp:(BaseResp*)resp{
    
    NSLog(@"发送一个请求后，受到了微信的回应");
    
    NSString *des = [[resp class] description];
    
    NSLog(@"描述： = %@",des);
    
    //登录授权
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *response = (SendAuthResp*) resp;
        int errCode = response.errCode;
        switch (errCode) {
            case 0:{
                //用户同意
                [MBProgressHUD wj_showSuccess:@"登录成功"];
                NSString *code = response.code;
                WXManager * manager =  [[WXManager alloc] init];
                
                NSDictionary * dictionary =  [manager getWeiXinAccessTokenFromCode:code];
                
                NSDictionary * userInfo =  [manager getWeiXinUserInfo:[dictionary objectForKey:@"access_token"] withOpenId:[dictionary objectForKey:@"openid"]];
                
                NSString *nickName = [userInfo objectForKey:@"nickname"];
                NSString *headimgurl = [userInfo objectForKey:@"headimgurl"];
                NSString *openid = [dictionary objectForKey:@"openid"];
                NSString *unionid = [dictionary objectForKey:@"unionid"];
                
                if (dictionary== nil && userInfo== nil && [dictionary objectForKey:@"access_token"]== nil) {
                    [MBProgressHUD wj_showError:@"您过于频繁用微信登录"];
                    return;
                }
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATIONLOGIN object:nil userInfo:@{@"nickname":nickName, @"headimgurl":headimgurl, @"openid":openid, @"deviceOs":@"ios", @"wxPubOpenId":unionid, @"unionid":unionid}];
            }
                break;
                
            default:{
                //用户取消或者拒绝授权
            }
                break;
        }
    }else if([resp isKindOfClass:[SendMessageToWXResp class]]){
        NSString * strTitle = [NSString stringWithFormat:@"分享结果"];
        switch (resp.errCode) {
            case WXSuccess:{
                strTitle = @"分享成功";
            }
                break;
                
        }
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = strTitle;
        [hud show:YES];
        [hud hide:YES afterDelay:1];
    }
}

-(void) registerWeiXin{
    //微信注册
    [WXApi registerApp:WINXINAPPID];
}

-(void)registerBaiChuan{
    
    
    [[AlibcTradeSDK sharedInstance] setIsvVersion:@"1.0"];
    [[AlibcTradeSDK sharedInstance] setIsvAppName:@"douhuiw"];
    
    
    // 配置全局的淘客参数
    //如果没有阿里妈妈的淘客账号,setTaokeParams函数需要调用
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    taokeParams.pid = @"mm_451870089_958600174_109581650168"; //mm_XXXXX为你自己申请的阿里妈妈淘客pid
    [[AlibcTradeSDK sharedInstance] setTaokeParams:taokeParams];
    
    //    设置全局的app标识，在电商模块里等同于isv_code
    //没有申请过isv_code的接入方,默认不需要调用该函数
    //        [[AlibcTradeSDK sharedInstance] setISVCode:BAICHUANAPPID];
    
    //    [[AlibcTradeSDK sharedInstance] setChannel:@"" name:@""];
    
    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:NO];
    
    [[AlibcTradeSDK sharedInstance]enableAuthVipMode];
    
    
    // 百川平台基础SDK初始化，加载并初始化各个业务能力插件
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
        NSLog(@"百川平台基础SDK初始化  ---- > 成功");
    } failure:^(NSError *error) {
        NSLog(@"百川平台基础SDK初始化  ---- > 失败");
    }];
}


-(void)initLaunchImageAdView{
    
    NSString * adUrl = [[NSUserDefaults standardUserDefaults] objectForKey:ADVERTISEMENT_URL];
    
    NSString * imageUrl = [[NSUserDefaults standardUserDefaults] objectForKey:ADVERTISEMENT_IMAGEURL];
    
    NSString * isAppFirstRun = [[NSUserDefaults standardUserDefaults] objectForKey:ZD_IS_APP_FIRSTRUN];
    
    if (![isAppFirstRun isEqualToString:@"1"] && (adUrl && adUrl.length >0)) {
        
        NSString *url = [NSString stringWithFormat:@"http://api.5138fun.com:8888%@", imageUrl];
        
        DHLaunchAdPageHUD *launchAd;
        launchAd = [[DHLaunchAdPageHUD alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) aDduration:6.0 aDImageUrl:url hideSkipButton:NO launchAdClickBlock:nil];
        
        __weak typeof(DHLaunchAdPageHUD) *weakSelf = launchAd;
        
        launchAd.launchAdClickBlock = ^{
            LaunchViewController *controller =  [[LaunchViewController alloc]initWithUrl:adUrl];
            controller.hidesBottomBarWhenPushed = YES;
            [[RootViewController homeNavigationController] pushViewController:controller animated:YES];
            [weakSelf setHidden:YES];
        };
        
        
        NSLog(@"launchAd : %@", launchAd);
    }
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        
        User *user = [[DataManager shareInstance] getUser];
           
           if (user != nil && registrationID != nil) {
               
               NSDictionary *dic = @{@"type":@"1", @"did":registrationID, @"appToken":user.appToken, @"deviceOs":@"ios"};
               
               [[DataManager shareInstance]bindDevice:dic callBack:^(Message *message) {
                   
               }];
           }
           [[DBManager shareInstance]setDeviceToken:registrationID];
    }];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error{
}

#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    NSString *userInfoUrl = userInfo[@"url"];
       if (userInfoUrl != nil && userInfoUrl.length > 0) {
           
           if([userInfoUrl rangeOfString:@"HWID"].location !=NSNotFound){
               NSString *mid = [userInfoUrl substringFromIndex:5];
               DetailViewController *controller =  [[DetailViewController alloc]init];
               controller.hidesBottomBarWhenPushed = YES;
               
               GoodsModel *model = [[GoodsModel alloc]init];
               model.numIid = mid;
               
               controller.flgs = @"1";
               
               controller.model = model;
               
               [[RootViewController homeNavigationController] pushViewController:controller animated:YES];
               
               [[RootViewController homeNavigationController].tabBarController setSelectedIndex:0];
           }else{
               
               [[RootViewController homeNavigationController].tabBarController setSelectedIndex:4];
           }
       }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
}


-(void)registerNotifications:(NSDictionary *)launchOptions{
    
   //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        // Fallback on earlier versions
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
      // 可以添加自定义 categories
      // NSSet<UNNotificationCategory *> *categories for iOS10 or later
      // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
    
    // Optional
     // 获取 IDFA
     // 如需使用 IDFA 功能请添加此代码并在初始化方法的 advertisingIdentifier 参数中填写对应值
     NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];

     // Required
     // init Push
     // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
     [JPUSHService setupWithOption:launchOptions appKey:@"064575873015ca55a2818673"
                           channel:@"App Store"
                  apsForProduction:0
             advertisingIdentifier:advertisingId];
    
    
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];

    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert+UNAuthorizationOptionSound+UNAuthorizationOptionBadge)

                          completionHandler:^(BOOL granted,NSError*_Nullableerror)

     {

        if(granted){
            //    重点是这句话，在用户允许通知以后，手动执行regist方法。
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication]registerForRemoteNotifications];
            });
        }

    }];
    
}


@end

