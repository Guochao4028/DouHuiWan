//
//  FrequentlyQuestionsViewController.h
//  likeBuy
//
//  Created by mac on 2019/10/15.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FrequentlyQuestionsViewController : BaseViewController


//标题组
@property (nonatomic, strong, nonnull) NSArray *titles;

//问题模型数组
@property(nonatomic, strong)NSArray *dataList;

@end

NS_ASSUME_NONNULL_END
