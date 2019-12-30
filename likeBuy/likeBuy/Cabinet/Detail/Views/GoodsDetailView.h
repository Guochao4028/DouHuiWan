//
//  GoodsDetailView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/16.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GoodsDetailModel;

@protocol GoodsDetailViewDelegate <NSObject>

@optional
-(void)tapGoodsInfoView;
@end


@interface GoodsDetailView : UIView

@property(nonatomic, strong)GoodsDetailModel *model;


@property(nonatomic, weak)id<GoodsDetailViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
