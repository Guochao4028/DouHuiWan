//
//  FansOrderTableViewCell.h
//  likeBuy
//
//  Created by mac on 2019/11/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OrderModel;

@interface FansOrderTableViewCell : UITableViewCell

@property(nonatomic, strong)OrderModel *model;

@end

NS_ASSUME_NONNULL_END
