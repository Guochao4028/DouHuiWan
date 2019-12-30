//
//  ImageAndGoodsTableViewCell.h
//  likeBuy
//
//  Created by mac on 2019/10/23.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GoodsModel, ImageAndGoodsTableViewCell;

@protocol ImageAndGoodsTableViewCellDelegate <NSObject>

-(void)imageAndGoodsTableViewCell:(ImageAndGoodsTableViewCell *)cell tapGoodsItem:(GoodsModel *)model;

@end

@interface ImageAndGoodsTableViewCell : UITableViewCell

@property(nonatomic, assign)NSInteger topType;

@property(nonatomic, strong)NSArray *dataList;

@property(nonatomic, weak)id<ImageAndGoodsTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
