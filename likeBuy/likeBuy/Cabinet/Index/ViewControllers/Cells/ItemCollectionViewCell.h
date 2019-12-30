//
//  ItemCollectionViewCell.h
//  likeBuy
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class EnterModel;

@interface ItemCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)EnterModel *model;

@end

NS_ASSUME_NONNULL_END
