//
//  ZeroTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "ZeroTableViewCell.h"

#import "ZeroModel.h"

@interface ZeroTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *piceLabel;
@property (weak, nonatomic) IBOutlet UILabel *quanLabel;
@property (weak, nonatomic) IBOutlet UILabel *lijinLabel;

@end

@implementation ZeroTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView setBackgroundColor:WHITE];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(ZeroModel *)model{
    
    [self.titleLabel setText:model.title];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    [self.piceLabel setText:model.couponAfterPrice];
    [self.quanLabel setText:[NSString stringWithFormat:@" 券 ￥%@ ", model.coupon]];
    [self.lijinLabel setText:[NSString stringWithFormat:@" ￥%@ ", model.perFace]];
}

@end
