//
//  OrdeTableViewCell.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OrderModel;

@interface OrdeTableViewCell : UITableViewCell

@property(nonatomic, copy)NSString  *orderType;
@property(nonatomic, strong)OrderModel *model;

@end

NS_ASSUME_NONNULL_END
