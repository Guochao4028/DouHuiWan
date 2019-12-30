//
//  GoodsListTableViewCell.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GoodsModel, PddGoodsListModel;

@protocol GoodsListTableViewCellDelegate <NSObject>

-(void)tapGoodsListTableViewCell:(GoodsModel *)item;

@end

@interface GoodsListTableViewCell : UITableViewCell

@property(nonatomic, strong)GoodsModel *model;

@property(nonatomic, strong)PddGoodsListModel *goodsListModel;


@property(nonatomic, strong)NSDictionary *dic;

@property (nonatomic,assign) id<GoodsListTableViewCellDelegate>delegate;


/**
 * 用于 区分 拼多多， 京东，正常
 * pdd，jd， nou
 */
@property(nonatomic, copy)NSString *viewType;


@end

NS_ASSUME_NONNULL_END
