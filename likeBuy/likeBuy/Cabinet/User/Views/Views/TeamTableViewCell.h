//
//  TeamTableViewCell.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FansModel;

@interface TeamTableViewCell : UITableViewCell

@property(nonatomic, strong)FansModel *model;

@property(nonatomic, copy)NSString *name;

@end

NS_ASSUME_NONNULL_END
