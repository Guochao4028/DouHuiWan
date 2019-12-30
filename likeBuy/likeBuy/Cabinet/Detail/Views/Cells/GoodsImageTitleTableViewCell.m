//
//  GoodsImageTitleTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/17.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "GoodsImageTitleTableViewCell.h"

@implementation GoodsImageTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView setBackgroundColor:WHITE];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
