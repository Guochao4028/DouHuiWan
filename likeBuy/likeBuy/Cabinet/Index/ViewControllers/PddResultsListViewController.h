//
//  PddResultsListViewController.h
//  likeBuy
//
//  Created by mac on 2019/11/10.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class PddGoodsOpt;

@interface PddResultsListViewController : BaseViewController

@property(nonatomic, assign)NSInteger index;

@property(nonatomic, strong)PddGoodsOpt *model;

@end

NS_ASSUME_NONNULL_END
