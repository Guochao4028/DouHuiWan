//
//  CashSucceedView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CashSucceedViewDelegate <NSObject>

@optional
-(void)jumpHomePage;

@end

@interface CashSucceedView : UIView

@property(nonatomic, weak)id<CashSucceedViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
