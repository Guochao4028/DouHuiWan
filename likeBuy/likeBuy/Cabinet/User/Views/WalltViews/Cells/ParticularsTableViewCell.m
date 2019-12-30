//
//  ParticularsTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "ParticularsTableViewCell.h"

#import "ParticularsModel.h"

@interface ParticularsTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *applyAccountLabel;
@property (weak, nonatomic) IBOutlet UILabel *applyDateLabel;

@end

@implementation ParticularsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(ParticularsModel *)model{
    [self.applyAccountLabel setText:[NSString stringWithFormat:@"+ %@", model.applyAmount]];
    
    NSString *str = [self convertStrToTime:model.applyDate];
    
    [self.applyDateLabel setText:[NSString stringWithFormat:@"提现日期:%@",str]];
    
}

-(NSString *)convertStrToTime:(NSString *)timeStr{
    
    long long time=[timeStr longLongValue] /1000;
    //    如果服务器返回的是13位字符串，需要除以1000，否则显示不正确(13位其实代表的是毫秒，需要除以1000)
    //    long long time=[timeStr longLongValue] / 1000;
    
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString*timeString=[formatter stringFromDate:date];
    
    return timeString;
}

@end
