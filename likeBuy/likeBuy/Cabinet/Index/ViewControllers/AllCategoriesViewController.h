//
//  AllCategoriesViewController.h
//  likeBuy
//
//  Created by mac on 2019/9/26.
//  Copyright © 2019 Beans. All rights reserved.
// 带带全部分类的列表

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AllCategoriesViewController : BaseViewController

@property(nonatomic, copy)NSString *titleStr;

//标题组
@property (nonatomic, strong, nonnull) NSArray *titles;

//@property(nonatomic, strong)NSArray *categoryModelArray;

@property(nonatomic, assign)ViewControllerType vcType;

@end

NS_ASSUME_NONNULL_END
