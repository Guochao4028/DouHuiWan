//
//  SearchListViewController.h
//  likeBuy
//
//  Created by mac on 2019/9/25.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchListViewController : BaseViewController
@property(nonatomic, copy)NSString *keyString;

@property(nonatomic, copy)NSString *tabString;

@property(nonatomic, assign)MeunSelectType meunType;

@end

NS_ASSUME_NONNULL_END
