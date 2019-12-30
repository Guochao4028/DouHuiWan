//
//  SharePicView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/18.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SharePicViewDelegate <NSObject>

-(void)tapImage:(NSIndexPath *)indexPath;

@end

@interface SharePicView : UIView

@property(nonatomic, strong)NSArray<UIImage *> *dataSoucreArray;

@property(nonatomic, strong, readonly)NSArray *selectImgList;

@property(nonatomic, weak)id<SharePicViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
