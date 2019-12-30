//
//  ClassifyListViewController.h
//  likeBuy
//
//  Created by mac on 2019/9/25.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class CategorySecondClassModel;

@interface ClassifyListViewController : BaseViewController

@property(nonatomic, strong)CategorySecondClassModel *model;
@property(nonatomic, assign)BOOL isViewImage;
@property(nonatomic, strong)NSDictionary *iconDic;

@end

NS_ASSUME_NONNULL_END
