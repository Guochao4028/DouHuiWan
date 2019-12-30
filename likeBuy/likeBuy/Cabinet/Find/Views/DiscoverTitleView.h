//
//  DiscoverTitleView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DiscoverTitleViewDelegate <NSObject>

-(void)selectedItem:(NSUInteger)index;

@end

@interface DiscoverTitleView : UIView

@property(nonatomic, weak)id<DiscoverTitleViewDelegate> delegate;

-(void)selectTitleItemAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
