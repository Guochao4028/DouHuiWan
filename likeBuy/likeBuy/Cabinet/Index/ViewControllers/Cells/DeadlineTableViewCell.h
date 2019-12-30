//
//  DeadlineTableViewCell.h
//  likeBuy
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GoodsModel;

@protocol DeadlineTableViewCellDelegate;

@interface DeadlineTableViewCell : UITableViewCell

@property(nonatomic, strong)NSArray *dataList;

@property(nonatomic, copy)NSString *titleStr;

@property(nonatomic, copy)NSString *atMoreStr;

@property(nonatomic, assign)NSInteger type;

@property(nonatomic, weak)id<DeadlineTableViewCellDelegate> delegate;

@property(nonatomic, strong)NSArray *timeArray;

@end

@protocol DeadlineTableViewCellDelegate <NSObject>

-(void)deadlineTableCell:(DeadlineTableViewCell *)cell tapGoodsItem:(GoodsModel *)model;

-(void)deadlineTableCell:(DeadlineTableViewCell *)cell tapChange:(NSInteger)tap;



@end


NS_ASSUME_NONNULL_END
