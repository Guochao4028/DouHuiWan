//
//  CreateShareHeardView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/18.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "CreateShareHeardView.h"

@interface CreateShareHeardView()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *HeardTextLabel;

@end

@implementation CreateShareHeardView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CreateShareHeardView" owner:self options:nil];
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

- (void)setShareHeardString:(NSString *)shareHeardString{
    _shareHeardString = shareHeardString;
    [self.HeardTextLabel setText:shareHeardString];
}

@end
