//
//  SearchBarView.h
//  likeBuy
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@protocol SearchBarViewDelegate <NSObject>

@optional
-(void)jumpSearchView;
@end

@interface SearchBarView : UIView

@property(nonatomic, assign)BOOL isClearColor;

@property(nonatomic, weak)id<SearchBarViewDelegate> delegate;

@property(nonatomic, strong)UIColor *bgColor;

@end

NS_ASSUME_NONNULL_END
