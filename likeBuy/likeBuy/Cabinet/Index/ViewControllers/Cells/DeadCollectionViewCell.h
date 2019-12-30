//
//  DeadCollectionViewCell.h
//  likeBuy
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GoodsModel;

@interface DeadCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)GoodsModel *model;

@end

NS_ASSUME_NONNULL_END
