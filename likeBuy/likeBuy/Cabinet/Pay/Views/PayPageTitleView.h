//
//  PayPageTitleView.h
//  likeBuy
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GoodsDetailModel;

@protocol PayPageTitleViewDelegate <NSObject>

-(void)back;

@end

@interface PayPageTitleView : UIView

@property(nonatomic, strong)GoodsDetailModel *model;
@property(nonatomic, weak)id<PayPageTitleViewDelegate> delegate;



@end

NS_ASSUME_NONNULL_END
