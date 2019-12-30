//
//  DiscoverCellRemarkView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "DiscoverCellRemarkView.h"

@interface DiscoverCellRemarkView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end


@implementation DiscoverCellRemarkView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"DiscoverCellRemarkView" owner:self options:nil];
        [self initUI];
    }
    return self;
}


-(void)initUI{
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}

-(void)tap{
    if ([self.delegate respondsToSelector:@selector(tapView)] == YES) {
        [self.delegate tapView];
    }
}


@end
