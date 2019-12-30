//
//  LargerEntranceTableViewCell.h
//  likeBuy
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LargerEntranceTableViewCellDelegate;

@interface LargerEntranceTableViewCell : UITableViewCell

@property(nonatomic, weak)id<LargerEntranceTableViewCellDelegate> delegate;

@property(nonatomic, strong)NSArray *top100Array;

@property(nonatomic, strong)NSArray *baiCaiArray;


@end

@protocol LargerEntranceTableViewCellDelegate <NSObject>

-(void)tableViewCell:(LargerEntranceTableViewCell *)cell tapItem:(NSInteger)tag;


@end

NS_ASSUME_NONNULL_END
