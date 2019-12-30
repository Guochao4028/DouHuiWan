//
//  GoodsInfoTableViewCell.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/16.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol GoodsInfoTableViewCellDelegate <NSObject>

@optional
-(void)tapGoodsInfoView;

@end


@class GoodsDetailModel;

@interface GoodsInfoTableViewCell : UITableViewCell

@property(nonatomic, strong)GoodsDetailModel *model;

@property(nonatomic, weak)id<GoodsInfoTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
