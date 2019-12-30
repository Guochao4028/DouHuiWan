//
//  SearchCommandView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/11/6.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SearchCommandViewDelegate <NSObject>

@optional

-(void)jumpSearch:(NSString *)word;
-(void)tapQuXiao;


@end

@interface SearchCommandView : UIView

@property(nonatomic, copy)NSString *wordStr;

@property(nonatomic, weak)id<SearchCommandViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
