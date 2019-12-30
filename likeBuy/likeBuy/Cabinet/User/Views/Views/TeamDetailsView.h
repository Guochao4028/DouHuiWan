//
//  TeamDetailsView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FansModel;

@protocol TeamDetailsViewDelegate <NSObject>

@optional
-(void)tapSelf;

@end

@interface TeamDetailsView : UIView

@property(nonatomic, strong)FansModel *model;

@property(nonatomic, weak)id<TeamDetailsViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
