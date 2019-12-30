//
//  PromptListView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PromptListViewDelegate <NSObject>

-(void)selectSwitchChage:(BOOL)isOn;

@end

@interface PromptListView : UIView

@property(nonatomic, weak)id<PromptListViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
