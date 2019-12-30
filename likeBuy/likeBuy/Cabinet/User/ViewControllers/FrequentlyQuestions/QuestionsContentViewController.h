//
//  QuestionsContentViewController.h
//  likeBuy
//
//  Created by mac on 2019/12/9.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuestionsContentViewController : BaseViewController

//问题模型数组
@property(nonatomic, strong)NSArray *dataList;

@property(nonatomic, assign)NSInteger index;

@end

NS_ASSUME_NONNULL_END
