//
//  CreateShareViewController.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/17.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class GoodsDetailModel;

@interface CreateShareViewController : BaseViewController

@property(nonatomic, strong)GoodsDetailModel *model;

@property(nonatomic, copy)NSString *shareString;

@end

NS_ASSUME_NONNULL_END
