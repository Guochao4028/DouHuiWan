//
//  ResultsListViewController.h
//  likeBuy
//
//  Created by mac on 2019/10/8.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class CategoryModel;

@interface ResultsListViewController : BaseViewController

@property(nonatomic, strong)CategoryModel *model;

@property(nonatomic, assign)NSInteger index;

@property(nonatomic, assign)ViewControllerType vcType;

@property(nonatomic, strong)NSArray *titles;

@property(nonatomic, assign)BOOL isBuy;

@end

NS_ASSUME_NONNULL_END
