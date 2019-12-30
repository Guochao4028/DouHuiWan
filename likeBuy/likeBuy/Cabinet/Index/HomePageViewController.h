//
//  HomePageViewController.h
//  likeBuy
//
//  Created by mac on 2019/10/22.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomePageViewController : BaseViewController
//标题组
@property (nonatomic, strong, nonnull) NSArray *titles;
//分类数组
@property(nonatomic, strong)NSArray *classifyArray;

-(void)beginColor;

@end

NS_ASSUME_NONNULL_END
