//
//  ControlPanelTableViewCell.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ControlPanelTableViewCellDelegate <NSObject>

-(void)tapItem:(UserSelectItemType)type;

@end

@interface ControlPanelTableViewCell : UITableViewCell

@property(nonatomic, weak)id<ControlPanelTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
