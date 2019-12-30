//
//  AboutTitleView.m
//  likeBuy
//
//  Created by mac on 2019/11/29.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "AboutTitleView.h"

@interface AboutTitleView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation AboutTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"AboutTitleView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.contentView];
    [self.contentView  setFrame:self.bounds];
    
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}

@end
