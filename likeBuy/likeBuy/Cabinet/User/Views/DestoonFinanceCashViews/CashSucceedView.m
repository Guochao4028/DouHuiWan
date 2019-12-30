//
//  CashSucceedView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "CashSucceedView.h"

@interface CashSucceedView()

@property (strong, nonatomic) IBOutlet UIView *contentView;
- (IBAction)jumpHomeAction:(id)sender;


@end

@implementation CashSucceedView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CachSucceedView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}

- (IBAction)jumpHomeAction:(id)sender {
    
    if([self.delegate respondsToSelector:@selector(jumpHomePage)]){
        [self.delegate jumpHomePage];
    }
    
}


@end
