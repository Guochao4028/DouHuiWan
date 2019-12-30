//
//  TeamTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "TeamTableViewCell.h"

#import "FansModel.h"

@interface TeamTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *heardImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *leveLabel;
@property (weak, nonatomic) IBOutlet UILabel *yaoqingLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansNumberLabel;

@end

@implementation TeamTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(FansModel *)model{
    _model = model;
    
    [self.heardImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"121"]];
    
    
    self.heardImageView.layer.cornerRadius = 56 / 2;
    
    if (model.shortName == nil || model.shortName.length == 0) {
        [self.nameLabel setText:model.telephone];
    }else{
        [self.nameLabel setText:model.shortName];
    }
    
    if (self.name != nil) {
        [self.yaoqingLabel setText:[NSString stringWithFormat:@"邀请人:%@",self.name]];
    }else{
        [self.yaoqingLabel setText:[NSString stringWithFormat:@"邀请人:%@", model.upName]];
    }
    
    [self.leveLabel setText:model.grade];;
//    self.yaoqingLabel;
    [self.fansNumberLabel setText:[NSString stringWithFormat:@"粉丝数 %@", model.directFans]];
}

@end
