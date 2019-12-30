//
//  CashView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CashViewDelegate <NSObject>

@optional
-(void)tijiao:(NSDictionary *)dataDic;

@end

@interface CashView : UIView

@property(nonatomic, weak)id<CashViewDelegate> delegate;

@property(nonatomic, strong)User *user;

@end

NS_ASSUME_NONNULL_END
