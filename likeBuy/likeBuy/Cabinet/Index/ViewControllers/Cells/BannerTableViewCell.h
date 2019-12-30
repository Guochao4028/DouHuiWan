//
//  BannerTableViewCell.h
//  likeBuy
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BannerModel;
@protocol BannerTableViewCellDelegate <NSObject>

-(void)pushToOtherViewControllerwithHomeItem:(BannerModel *)item;

@end

@interface BannerTableViewCell : UITableViewCell

@property (nonatomic,strong)NSArray <BannerModel *> *dataSource;
@property (nonatomic,assign) id<BannerTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
