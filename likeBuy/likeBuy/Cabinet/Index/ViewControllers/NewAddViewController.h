//
//  NewAddViewController.h
//  likeBuy
//
//  Created by mac on 2019/10/23.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewAddViewController : BaseViewController

@property(nonatomic, strong)NSString *titleStr;

@property(nonatomic, assign)ViewControllerType vcType;

@property(nonatomic, assign)NSInteger type;

@property(nonatomic, strong)NSArray *titles;

@end

NS_ASSUME_NONNULL_END
