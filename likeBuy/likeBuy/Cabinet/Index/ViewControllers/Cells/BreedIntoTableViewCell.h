//
//  BreedIntoTableViewCell.h
//  likeBuy
//
//  Created by mac on 2019/10/22.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CategorySecondClassModel;

@protocol BreedIntoTableViewCellDelegate <NSObject>

-(void)jumpClassify:(CategorySecondClassModel *)model;


@end

@interface BreedIntoTableViewCell : UITableViewCell

@property(nonatomic, strong)NSArray<CategorySecondClassModel *> *dataArray;

@property(nonatomic, weak)id<BreedIntoTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
