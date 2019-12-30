//
//  PromptListView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "PromptListView.h"

@interface PromptListView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UISwitch *selectSwitch;

- (IBAction)selectSwitchAction:(id)sender;

@end
@implementation PromptListView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"PromptListView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.contentView];
    [self.contentView  setFrame:self.bounds];
    
    self.selectSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];    
}

- (IBAction)selectSwitchAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(selectSwitchChage:)]){
        [self.delegate selectSwitchChage:self.selectSwitch.on];
       }
}

@end
