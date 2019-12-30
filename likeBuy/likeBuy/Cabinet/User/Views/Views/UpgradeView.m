//
//  UpgradeView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "UpgradeView.h"

@interface UpgradeView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *leveUp;

@end

@implementation UpgradeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"UpgradeView" owner:self options:nil];
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

-(void)setWord:(NSString *)word{
    [self.label setText:word];
}

-(void)setIsLabel:(BOOL)isLabel{
    if (isLabel == YES) {
        [self.leveUp setHidden:YES];
    }else{
        [self.label setHidden:YES];
    }
}

@end
