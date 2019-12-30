//
//  ControlItemCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "ControlItemCell.h"

@interface ControlItemCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation ControlItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(NSDictionary *)model{
    NSString *icon = model[@"icon"];
    NSString *name = model[@"name"];
    [self.iconImageView setImage:[UIImage imageNamed:icon]];
    [self.nameLabel setText:name];
}

@end
