//
//  GoodsHeadTableViewCell.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/16.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDetailModel;
NS_ASSUME_NONNULL_BEGIN

@interface GoodsHeadTableViewCell : UITableViewCell
@property(nonatomic, strong)GoodsDetailModel *model;
@end

NS_ASSUME_NONNULL_END
