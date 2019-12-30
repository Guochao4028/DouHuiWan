//
//  DiscoverTableViewCell.h
//  ALiLikePurchase
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RecommendModel;

@protocol DiscoverTableViewCellDelegate <NSObject>

-(void)tapView:(NSIndexPath *)indexPath;

-(void)tapGoodsImageWithGoodsItem:(NSIndexPath *)indexPath andTableViewCellIndexPath:(NSIndexPath *)cellIndexPath;

@end

@interface DiscoverTableViewCell : UITableViewCell

@property(nonatomic, strong)RecommendModel *model;

@property(nonatomic, strong)NSIndexPath *indexPath;

@property(nonatomic, weak)id<DiscoverTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
