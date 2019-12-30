//
//  InfoDetailTableViewCell.h
//  likeBuy
//
//  Created by mac on 2019/10/27.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class InfoModel;

@interface InfoDetailTableViewCell : UITableViewCell

@property(nonatomic, strong)InfoModel *dataModel;

@end

NS_ASSUME_NONNULL_END
