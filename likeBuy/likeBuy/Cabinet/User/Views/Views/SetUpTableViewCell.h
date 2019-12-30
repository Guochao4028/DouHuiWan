//
//  SetUpTableViewCell.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetUpTableViewCell : UITableViewCell

@property(nonatomic, strong)NSDictionary *model;

@property(nonatomic, strong)User *user;

@property(nonatomic, strong)UIImage *image;

@end

NS_ASSUME_NONNULL_END
