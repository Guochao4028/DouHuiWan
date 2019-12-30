//
//  LeftTableViewCell.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "LeftTableViewCell.h"

@interface LeftTableViewCell ()

@property (nonatomic, strong) UIView *yellowView;

@end

@implementation LeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:RGB(247, 247, 247)];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(0, (56 - 16)/2, 80, 16)];
        self.name.numberOfLines = 0;
        
        self.name.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        
        self.name.textColor = TEXTNORMALCOLOR;
        self.name.highlightedTextColor = TEXTCHANGECOLOR;
        [self.name setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.name];
        self.yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, (56 - 23)/2, 3, 23)];
        self.yellowView.backgroundColor = REDLINECOLOR;
        [self.contentView addSubview:self.yellowView];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.highlighted = selected;
    
    if ([self isHighlighted] == YES) {

        self.name.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];

        [self.contentView setBackgroundColor:RGB(255, 255, 255)];
    }else{
        self.name.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [self.contentView setBackgroundColor:RGB(247, 247, 247)];
    }
    
    self.name.highlighted = selected;
    self.yellowView.hidden = !selected;
}

@end
