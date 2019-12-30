//
//  WantBuyView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/28.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GoodsDetailModel;


@protocol WantBuyViewDelegate <NSObject>

@optional

-(void)jumpTaoBao:(GoodsDetailModel *)model;

-(void)jumpGoodsDetail:(GoodsDetailModel *)model;

@end


@interface WantBuyView : UIView

@property(nonatomic, strong)GoodsDetailModel *model;

@property(nonatomic, weak)id<WantBuyViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
