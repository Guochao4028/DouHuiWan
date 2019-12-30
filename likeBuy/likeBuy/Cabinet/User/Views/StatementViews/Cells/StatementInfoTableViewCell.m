//
//  StatementInfoTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "StatementInfoTableViewCell.h"


@interface StatementInfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *zongLabel;

@property (weak, nonatomic) IBOutlet UILabel *benyueLabel;
@property (weak, nonatomic) IBOutlet UILabel *shangyueLabel;

@property (weak, nonatomic) IBOutlet UILabel *benyuefukuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *shangyuefukanLabel;

@end

@implementation StatementInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(NSDictionary *)model{
    User *user = [[DataManager shareInstance]getUser];
    
    if ([user.rebateAmount floatValue] == 0) {
         [self.zongLabel setText:@"¥0"];
    }else{
        [self.zongLabel setText:[NSString stringWithFormat:@"¥%@", user.rebateAmountStr]];
    }
    
    if ([model[@"monthPubFee"] floatValue] == 0) {
        [self.benyueLabel setText:@"¥0"];
    }else{
        [self.benyueLabel setText:[NSString stringWithFormat:@"¥%@", model[@"monthPubFee"]]];
    }
    
    if ([model[@"monthPreFee"] floatValue] == 0) {
        [self.benyuefukuanLabel setText:@"¥0"];
    }else{
        [self.benyuefukuanLabel setText:[NSString stringWithFormat:@"¥%@", model[@"monthPreFee"]]];
    }
    
    if ([model[@"lastMonthPubFee"] floatValue] == 0) {
        [self.shangyueLabel setText:@"¥0"];
    }else{
        [self.shangyueLabel setText:[NSString stringWithFormat:@"¥%@", model[@"lastMonthPubFee"]]];
    }
    
    if ([model[@"lastMonthPreFee"] floatValue] == 0) {
        [self.shangyuefukanLabel setText:@"¥0"];
    }else{
        [self.shangyuefukanLabel setText:[NSString stringWithFormat:@"¥%@", model[@"lastMonthPreFee"]]];
    }
}

@end
