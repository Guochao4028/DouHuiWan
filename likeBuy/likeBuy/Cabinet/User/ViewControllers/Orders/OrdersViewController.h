//
//  OrdersViewController.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrdersViewController : BaseViewController

@property(nonatomic, copy)NSString *orderType;
//标题组
@property (nonatomic, strong, nonnull) NSArray *titles;

@end

NS_ASSUME_NONNULL_END
