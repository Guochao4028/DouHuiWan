//
//  PaySuccessViewController.h
//  likeBuy
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class GoodsDetailModel;


@interface PaymentSuccessViewController : BaseViewController

@property(nonatomic, strong)GoodsDetailModel *model;

@property(nonatomic, copy)NSString *payName;


@end

NS_ASSUME_NONNULL_END
