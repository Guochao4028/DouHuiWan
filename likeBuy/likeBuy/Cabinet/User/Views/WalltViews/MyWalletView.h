//
//  MyWalletView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MyWalletViewDelegate <NSObject>

-(void)jumpPage;

@end

@interface MyWalletView : UIView

@property(nonatomic, strong)User *user;

@property(nonatomic, weak)id<MyWalletViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
