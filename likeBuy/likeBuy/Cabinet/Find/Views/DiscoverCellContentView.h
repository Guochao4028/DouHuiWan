//
//  DiscoverCellContentView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RecommendModel;

@protocol DiscoverCellContentViewDelegate <NSObject>

-(void)tapView;

-(void)tapGoodsImageWith:(NSIndexPath *)indexPath;

@end


@interface DiscoverCellContentView : UIView

@property(nonatomic, strong)RecommendModel *model;

@property(nonatomic, weak)id<DiscoverCellContentViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
