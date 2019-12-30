//
//  PayTableViewCell.m
//  likeBuy
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "PayTableViewCell.h"

@interface PayTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageVeiw;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *selecdImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation PayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 8;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    self.backgroundColor = WHITE;
//    [self.contentView setBackgroundColor:WHITE];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(NSDictionary *)model{
    NSString *title = model[@"title"];
    UIImage *image = [UIImage imageNamed:model[@"icon"]];
    
    NSString *isSelecd = model[@"isSelecd"];
    
    [self.titleLabel setText:title];
    [self.iconImageVeiw setImage:image];
    
    if ([isSelecd boolValue] == YES) {
        [self.selecdImageView setImage:[UIImage imageNamed:@"danxuanxuanzhong-3"]];

    }else{
        [self.selecdImageView setImage:[UIImage imageNamed:@"danxuanweixuanzhong"]];
    }
}

@end
