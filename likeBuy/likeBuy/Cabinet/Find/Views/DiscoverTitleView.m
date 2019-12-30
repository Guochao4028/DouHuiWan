//
//  DiscoverTitleView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "DiscoverTitleView.h"


@interface DiscoverTitleView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *jinxuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *haohuoLabel;

@property(nonatomic, assign)NSUInteger index;

@end


@implementation DiscoverTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"DiscoverTitleView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
    
    UITapGestureRecognizer *jingxuanTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jingxuanAction)];
    [self.jinxuanLabel addGestureRecognizer:jingxuanTap];
    [self.jinxuanLabel setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *haohuoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(haohuoAction)];
    [self.haohuoLabel addGestureRecognizer:haohuoTap];
    [self.haohuoLabel setUserInteractionEnabled:YES];
    
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}

-(void)selectTitleItemAtIndex:(NSUInteger)index{
    self.index = index;
    
    if (index == 0) {
        [self.jinxuanLabel setFont:[UIFont fontWithName:MediumFont size:18]];
        [self.haohuoLabel setFont:[UIFont fontWithName:RegularFont size:18]];

        [self.jinxuanLabel setTextColor:[UIColor colorWithHexString:@"303133"]];
        [self.haohuoLabel setTextColor:[UIColor colorWithHexString:@"606265"]];
    }else{
        [self.jinxuanLabel setFont:[UIFont fontWithName:RegularFont size:18]];
        [self.haohuoLabel setFont:[UIFont fontWithName:MediumFont size:18]];
        [self.jinxuanLabel setTextColor:[UIColor colorWithHexString:@"606265"]];
        [self.haohuoLabel setTextColor:[UIColor colorWithHexString:@"303133"]];
    }
}

-(void)jingxuanAction{
    self.index = 0;
    [self.jinxuanLabel setFont:[UIFont fontWithName:MediumFont size:18]];
    [self.haohuoLabel setFont:[UIFont fontWithName:RegularFont size:18]];
    [self.jinxuanLabel setTextColor:[UIColor colorWithHexString:@"303133"]];
    [self.haohuoLabel setTextColor:[UIColor colorWithHexString:@"606265"]];
    if ([self.delegate respondsToSelector:@selector(selectedItem:)] == YES) {
        [self.delegate selectedItem:self.index];
    }
}

-(void)haohuoAction{
    self.index = 1;
    [self.jinxuanLabel setFont:[UIFont fontWithName:RegularFont size:18]];
    [self.haohuoLabel setFont:[UIFont fontWithName:MediumFont size:18]];
    [self.jinxuanLabel setTextColor:[UIColor colorWithHexString:@"606265"]];
    [self.haohuoLabel setTextColor:[UIColor colorWithHexString:@"303133"]];
    if ([self.delegate respondsToSelector:@selector(selectedItem:)] == YES) {
        [self.delegate selectedItem:self.index];
    }
}


@end
