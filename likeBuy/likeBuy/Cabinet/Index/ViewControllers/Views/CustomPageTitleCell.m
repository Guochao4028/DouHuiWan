//
//  CustomPageTitleCell.m
//  likeBuy
//
//  Created by mac on 2019/10/8.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "CustomPageTitleCell.h"
@interface CustomPageTitleCell ()

//标题label
@property (nonatomic, strong) UILabel *titleLabel;

//副标题
@property (nonatomic, strong) UILabel *subtitleLabel;

@end

@implementation CustomPageTitleCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initCustomCell];
    }
    return self;
}

- (void)initCustomCell {
    //隐藏父视图中的label
    self.textLabel.hidden = true;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    
    self.subtitleLabel = [[UILabel alloc] init];
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subtitleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.subtitleLabel];
}

//设置布局
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat labelHeight = self.bounds.size.height/2.0f;
    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, labelHeight);
    self.subtitleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.bounds.size.width, labelHeight);
}



-(void)setModel:(NSDictionary *)model{
    self.titleLabel.text = model[@"title"];
    self.subtitleLabel.text = model[@"subTitles"];
}

//通过此父类方法配置cell是否被选中
- (void)configCellOfSelected:(BOOL)selected {
    
    UIColor *textColor = selected ? [UIColor blackColor] : [UIColor grayColor];
    UIFont *font;
    if (selected == YES) {
        textColor =[UIColor colorWithHexString:@"303133"];
        font = [UIFont fontWithName:MediumFont size:18];
        
    }else{
        textColor = [UIColor colorWithHexString:@"606265"];
        font = [UIFont fontWithName:RegularFont size:18];
    }
    
    self.titleLabel.textColor = textColor;
    
    self.subtitleLabel.textColor = textColor;
    
    [self.titleLabel setFont:font];
    [self.subtitleLabel setFont:[UIFont fontWithName:RegularFont size:12]];
    
}

//通过此父类方法配置cell动画
- (void)showAnimationOfProgress:(CGFloat)progress type:(XLPageTitleCellAnimationType)type {
    
}

@end
