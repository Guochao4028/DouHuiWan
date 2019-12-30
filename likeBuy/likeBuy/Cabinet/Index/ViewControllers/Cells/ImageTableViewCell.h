//
//  ImageTableViewCell.h
//  likeBuy
//
//  Created by mac on 2019/12/4.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ImageTableViewCellDelegate;

@interface ImageTableViewCell : UITableViewCell

@property(nonatomic, weak)id<ImageTableViewCellDelegate> delegate;

@property(nonatomic, copy)NSString *imageName;

@end


@protocol ImageTableViewCellDelegate <NSObject>

-(void)tapImageTableViewCell;

-(void)jumpPage:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
