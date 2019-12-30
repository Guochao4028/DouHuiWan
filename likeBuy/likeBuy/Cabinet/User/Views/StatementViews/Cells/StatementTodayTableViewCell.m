//
//  StatementTodayTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "StatementTodayTableViewCell.h"

@interface StatementTodayTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bishuLabel;

@property (weak, nonatomic) IBOutlet UILabel *yongjinLabel;

@property(nonatomic, assign)BOOL isToday;

@end

@implementation StatementTodayTableViewCell

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

-(void)setTitle:(NSString *)title{
    [self.titleLabel setText:title];
    if ([title isEqualToString:@"今天"]) {
        self.isToday = YES;
    }else{
        self.isToday = NO;
    }
}

-(void)setModel:(NSDictionary *)model{
    
    NSString *pubFee, *count;
    
    if (self.isToday == YES) {
        pubFee = [NSString stringWithFormat:@"%@",model[@"todayPreFee"]];
        count = [NSString stringWithFormat:@"%@",model[@"todayCount"]];
    }else{
        pubFee = [NSString stringWithFormat:@"%@",model[@"yestodayPreFee"]];
        count = [NSString stringWithFormat:@"%@",model[@"yestodayCount"]];
    }
    [self.bishuLabel setText:count];
    
    
    if ([pubFee floatValue] == 0 || pubFee.length == 0) {
        [self.yongjinLabel setText:@"¥0"];
    }else{
        [self.yongjinLabel setText:[NSString stringWithFormat:@"¥%@",pubFee]];
    }
}

@end
