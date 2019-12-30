//
//  BreedViewController.h
//  likeBuy
//
//  Created by mac on 2019/10/22.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BreedViewController : BaseViewController
//分类数组
@property(nonatomic, strong)NSArray *classifyArray;
//当前位置
@property(nonatomic, assign)NSInteger index;
//关键字
@property(nonatomic, strong)NSString *keyString;

@end

NS_ASSUME_NONNULL_END
