//
//  CooperTableViewCell.h
//  likeBuy
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CooperTableViewCell;

@protocol CooperTableViewCellDelegate <NSObject>

-(void)cooperCell:(CooperTableViewCell *)cell loction:(NSInteger)row endInput:(NSString *)word;

@end

NS_ASSUME_NONNULL_BEGIN


@interface CooperTableViewCell : UITableViewCell

@property(nonatomic, strong)NSDictionary *mdoel;

@property(nonatomic, assign)NSInteger indexPathRow;

@property(nonatomic, assign)id<CooperTableViewCellDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
