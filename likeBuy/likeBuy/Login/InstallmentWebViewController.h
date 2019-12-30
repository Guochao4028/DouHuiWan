//
//  InstallmentWebViewController.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface InstallmentWebViewController : BaseViewController

@property(nonatomic, strong)UIViewController *viewController;


-(instancetype)initWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
