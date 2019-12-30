//
//  UserInfoTableViewCell.h
//  likeBuy
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UserInfoTableViewCellDelegate <NSObject>

-(void)tapLogin;
-(void)tapTixian;
-(void)tapSetup;

@end

@interface UserInfoTableViewCell : UITableViewCell
@property(nonatomic, weak)id<UserInfoTableViewCellDelegate> delegate;
-(void)refreshData;
@end

NS_ASSUME_NONNULL_END
