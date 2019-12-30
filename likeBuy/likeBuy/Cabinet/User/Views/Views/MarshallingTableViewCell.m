//
//  MarshallingTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "MarshallingTableViewCell.h"

@interface MarshallingTableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *tixianButton;
@property (weak, nonatomic) IBOutlet UILabel *ketixianLabel;
@property (weak, nonatomic) IBOutlet UILabel *zongshouyiLabel;



@end


@implementation MarshallingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.tixianButton.layer.cornerRadius = 4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUser:(User *)user{
    
    if(user.extractableRebate == nil){
       [self.ketixianLabel setText:@"可提现 ¥0"];
         [self.zongshouyiLabel setText:@"¥0"];
    }else{
        [self.ketixianLabel setText:[NSString stringWithFormat:@"可提现 ¥%@", user.extractableRebate]];
        
         [self.zongshouyiLabel setText:[NSString stringWithFormat:@"¥%@", user.rebateAmountStr]];
    }
    
    
    
    
    
   
}

@end
