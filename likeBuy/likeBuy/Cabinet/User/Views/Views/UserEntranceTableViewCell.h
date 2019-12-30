//
//  UserEntranceTableViewCell.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UserEntranceTableViewCellDelegate <NSObject>

-(void)tapOrde;

-(void)tapQianban;

-(void)tapShouyiView;

@end

@interface UserEntranceTableViewCell : UITableViewCell

@property(nonatomic, weak)id<UserEntranceTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
