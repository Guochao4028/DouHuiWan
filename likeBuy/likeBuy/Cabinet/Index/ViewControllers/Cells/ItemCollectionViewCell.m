//
//  ItemCollectionViewCell.m
//  likeBuy
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "ItemCollectionViewCell.h"

#import "EnterModel.h"

@interface ItemCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation ItemCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView setBackgroundColor:WHITE];
    [self setBackgroundColor:WHITE];
}

-(void)setModel:(EnterModel *)model{
    [self.nameLabel setText:model.desc];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
}

@end
