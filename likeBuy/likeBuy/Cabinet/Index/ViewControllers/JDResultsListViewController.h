//
//  JDResultsListViewController.h
//  likeBuy
//
//  Created by mac on 2019/11/11.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class JDCategoryModel;

@interface JDResultsListViewController : BaseViewController

@property(nonatomic, assign)NSInteger index;

@property(nonatomic, strong)JDCategoryModel *model;

@end

NS_ASSUME_NONNULL_END
