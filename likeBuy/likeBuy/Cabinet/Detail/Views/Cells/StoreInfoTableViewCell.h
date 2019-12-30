//
//  StoreInfoTableViewCell.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/16.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GoodsDetailModel;

@interface StoreInfoTableViewCell : UITableViewCell

@property(nonatomic, strong)GoodsDetailModel *model;

@end

NS_ASSUME_NONNULL_END
