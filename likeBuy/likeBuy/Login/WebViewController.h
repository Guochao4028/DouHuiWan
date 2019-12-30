//
//  WebViewController.h
//  likeBuy
//
//  Created by mac on 2019/10/25.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "InstallmentWebViewController.h"
#import "BaseViewController.h"
#import <WebKit/WebKit.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : BaseViewController<UIWebViewDelegate>

@property(nonatomic, strong)UIWebView *webView;

@property(nonatomic, strong)UIViewController *vc;


@end

NS_ASSUME_NONNULL_END
