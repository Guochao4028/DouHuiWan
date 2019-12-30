//
//  TeamDetailsView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "TeamDetailsView.h"

#import "FansModel.h"

@interface TeamDetailsView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuguLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *heardImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation TeamDetailsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"TeamDetailsView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    
    [self addSubview:self.contentView];
    
    [self.contentView  setFrame:self.bounds];
    
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(tapSelf)]) {
        [self.delegate tapSelf];
    }
}

-(void)setModel:(FansModel *)model{
    [self.heardImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"def1"]];
    
    
    self.heardImageView.layer.cornerRadius = 56 / 2;
    
    
    if (model.shortName == nil || model.shortName.length == 0) {
        [self.nameLabel setText:model.telephone];
    }else{
        [self.nameLabel setText:model.shortName];
    }
    
    //[self.nameLabel setText:model.shortName];
    
    
    [self.timeLabel setText:[NSString stringWithFormat:@"注册时间:%@",[self convertStrToTime:model.createTime]]];
    //    self.yaoqingLabel;
    [self.idLabel setText:model.selfResqCode];
    
    [self.numberLabel setText:model.wxNo];
    
    [self.yuguLabel setText:[NSString stringWithFormat:@"¥%.2f",[model.rebateAmount floatValue]]];
    [self.sumLabel setText:[NSString stringWithFormat:@"¥%.2f",[model.montyForecast floatValue]]];
}

-(NSString *)convertStrToTime:(NSString *)timeStr{
    
//    long long time=[timeStr longLongValue];
    //    如果服务器返回的是13位字符串，需要除以1000，否则显示不正确(13位其实代表的是毫秒，需要除以1000)
    long long time=[timeStr longLongValue] / 1000;
    
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString*timeString=[formatter stringFromDate:date];
    
    return timeString;
}

@end
