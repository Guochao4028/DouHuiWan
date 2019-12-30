//
//  MyWalletView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "MyWalletView.h"


@interface MyWalletView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
- (IBAction)jumpPageAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *zongShouYiLabel;


@end

@implementation MyWalletView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"MyWalletView" owner:self options:nil];
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

-(void)setUser:(User *)user{
    
    [self.zongShouYiLabel setText:[NSString stringWithFormat:@"¥%@", user.rebateAmountStr]];
}

- (IBAction)jumpPageAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(jumpPage)]) {
        [self.delegate jumpPage];
    }
}
@end
