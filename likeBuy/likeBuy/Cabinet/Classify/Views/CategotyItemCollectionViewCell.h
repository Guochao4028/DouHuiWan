//
//  CategotyItemCollectionViewCell.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategorySecondClassModel;
NS_ASSUME_NONNULL_BEGIN

@interface CategotyItemCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong)CategorySecondClassModel *dataSource;
@end

NS_ASSUME_NONNULL_END
