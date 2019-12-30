//
//  DiscoverCellTitleView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "DiscoverCellTitleView.h"

#import "RecommendModel.h"

@interface DiscoverCellTitleView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shearLabel;


@end


@implementation DiscoverCellTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"DiscoverCellTitleView" owner:self options:nil];
        [self initUI];
    }
    return self;
}


-(void)initUI{
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
    
    self.imageView.layer.cornerRadius = 42/2;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}

-(void)setModel:(RecommendModel *)model{
    [self.titleLabel setText:model.itemshorttitle];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.itempic]];

    [self.timeLabel setText:@"  "];
//    NSInteger time = [model.time integerValue];
//    [self.timeLabel setText:[self updateTimeForRow:time]];
}


/**返回更新时间 */
- (NSString *)updateTimeForRow:(NSInteger)row {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = row;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    
    NSInteger mini = time/60;
    if (mini<60) {
        return @"刚刚";
    }
    
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",years];
}

@end
