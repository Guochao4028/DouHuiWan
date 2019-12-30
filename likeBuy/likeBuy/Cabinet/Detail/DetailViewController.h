//
//  DetailViewController.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class GoodsModel;

@protocol DetailViewControllerDelegate;


@interface DetailViewController : BaseViewController

@property(nonatomic, strong)GoodsModel *model;

@property(nonatomic, assign)BOOL isHomePage;

@property(nonatomic, assign)id<DetailViewControllerDelegate>delegate;

@property(nonatomic, copy)NSString *flgs;

/**
 * 用于 区分 拼多多， 京东，正常
 * pdd，jd， nou
 */
@property(nonatomic, copy)NSString *viewType;

@end

@protocol DetailViewControllerDelegate <NSObject>

-(void)detailViewController:(DetailViewController *)vc cancelCollection:(GoodsModel *)model;

@end

NS_ASSUME_NONNULL_END
