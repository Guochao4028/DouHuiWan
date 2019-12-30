//
//  EntranceTableViewCell.h
//  likeBuy
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EntranceTableViewCellDelegate;

@interface EntranceTableViewCell : UITableViewCell

@property(nonatomic, weak)id<EntranceTableViewCellDelegate> delegate;

@property(nonatomic, strong)NSArray *dataArray;

@end


@protocol EntranceTableViewCellDelegate <NSObject>

-(void)tableViewCell:(EntranceTableViewCell *)cell selectItem:(NSInteger)tag;

@end

NS_ASSUME_NONNULL_END
