//
//  SharePicCollectionViewCell.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/18.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SharePicCollectionViewCellDelegate <NSObject>

-(void)selectitem:(NSIndexPath *)indexPath;

-(void)tapImage:(NSIndexPath *)indexPath;

@end

@interface SharePicCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)NSDictionary *model;

@property(nonatomic, strong)NSIndexPath *indexPath;

@property(nonatomic, weak)id<SharePicCollectionViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
