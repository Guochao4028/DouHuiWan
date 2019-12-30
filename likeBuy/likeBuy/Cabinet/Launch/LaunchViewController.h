//
//  LaunchViewController.h
//  ALiLikePurchase
//
//  Created by mac on 2019/9/25.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LaunchViewController : BaseViewController

- (instancetype) initWithUrl:(NSString*) url;

@property(nonatomic, copy)NSString *titleStr;

@end

NS_ASSUME_NONNULL_END
