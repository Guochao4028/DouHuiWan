//
//  ScreeningView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ScreeningViewDelegate <NSObject>

@optional
-(void)tapZongHe:(ListType)type;

-(void)tapXiaoLiang:(ListType)type;

-(void)tapJiaGe:(ListType)type;

@end

@interface ScreeningView : UIView

@property(nonatomic, assign)ListType type;

@property(nonatomic, weak)id<ScreeningViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
