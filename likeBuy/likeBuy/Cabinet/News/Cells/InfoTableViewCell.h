//
//  InfoTableViewCell.h
//  likeBuy
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class InfoModel;

@interface InfoTableViewCell : UITableViewCell

@property(nonatomic, strong)NSString *title;

@property(nonatomic, strong)NSString *icon;

@property(nonatomic, strong)NSArray *dataModel;

@property(nonatomic, assign)BOOL isRedView;

@end

NS_ASSUME_NONNULL_END
