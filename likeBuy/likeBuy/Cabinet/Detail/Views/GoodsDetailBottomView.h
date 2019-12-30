//
//  GoodsDetailBottomView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/17.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GoodsDetailModel;


@protocol GoodsDetailBottomViewDelegate <NSObject>

-(void)jumpHomePage;
-(void)tapCollection;
-(void)tapBuy;
-(void)tapShare;

-(void)tapNowBuy;

@end

@interface GoodsDetailBottomView : UIView

@property(nonatomic, weak)id<GoodsDetailBottomViewDelegate> delegate;

@property(nonatomic, assign)BOOL isfavorite;

@property(nonatomic, assign)BOOL isIosStatue;

@property(nonatomic, strong)GoodsDetailModel *model;

@end

NS_ASSUME_NONNULL_END
