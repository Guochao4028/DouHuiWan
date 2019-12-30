//
//  ChangeNumberView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/23.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ChangeNumberViewDelegate <NSObject>

@optional
-(void)finish;

@end

@interface ChangeNumberView : UIView

@property(nonatomic, weak)id<ChangeNumberViewDelegate> delegate;

@property(nonatomic, assign)BOOL isUnbundling;

@end

NS_ASSUME_NONNULL_END
