//
//  DiscoverCellRemarkView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DiscoverCellRemarkViewDelegate <NSObject>

-(void)tapView;

@end

@interface DiscoverCellRemarkView : UIView

@property(nonatomic, weak)id<DiscoverCellRemarkViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
