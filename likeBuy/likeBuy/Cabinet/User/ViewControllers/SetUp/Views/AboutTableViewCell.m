//
//  AboutTableViewCell.m
//  likeBuy
//
//  Created by mac on 2019/11/29.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "AboutTableViewCell.h"

@interface AboutTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *returnImageVeiw;
@property (weak, nonatomic) IBOutlet UILabel *neirongLabel;

@end

@implementation AboutTableViewCell

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

-(void)setModel:(NSDictionary *)model{
    _model = model;
    [self.titleLabel setText:model[@"title"]];
    BOOL isReturn = [model[@"isReturn"] boolValue];
    BOOL isword = [model[@"isword"] boolValue];

    if (isReturn == NO) {
        [self.returnImageVeiw setHidden:YES];
    }
    
    if (isword == NO) {
        [self.neirongLabel setHidden:YES];
    }
    
    
    if (isword == YES) {
        [self.neirongLabel setText:model[@"neirong"]];
    }
    
}

@end
