//
//  GuessLikeTableViewCell.h
//  likeBuy
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GuessLikeTableViewCellDelegate;

@class GoodsModel;

@interface GuessLikeTableViewCell : UITableViewCell

@property(nonatomic, strong)NSArray *dataList;

@property(nonatomic, weak)id<GuessLikeTableViewCellDelegate> delegate;

@end

@protocol GuessLikeTableViewCellDelegate <NSObject>

-(void)guessLikeTableViewCell:(GuessLikeTableViewCell *)cell tapGoodsItem:(GoodsModel *)model;

@end

NS_ASSUME_NONNULL_END
