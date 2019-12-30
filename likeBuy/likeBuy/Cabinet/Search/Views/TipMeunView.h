//
//  TipMeunView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TipMeunViewDelegate <NSObject>

@optional
-(void)selectedMeunType:(MeunSelectType)type;

@end

@interface TipMeunView : UIView
@property(nonatomic, assign)MeunSelectType type;
@property(nonatomic, weak)id<TipMeunViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
