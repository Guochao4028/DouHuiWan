//
//  PassWordToBuyView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/17.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "PassWordToBuyView.h"

@interface PassWordToBuyView ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)copyAction:(UIButton *)sender;


@end

@implementation PassWordToBuyView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
       NSArray *d =  [[NSBundle mainBundle] loadNibNamed:@"PassWordToBuyView" owner:self options:nil];
        
        NSLog(@"d : %@", d);
        self.backgroundColor = [UIColor clearColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
    [self.textView setDelegate:self];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}

- (void)copylinkBtnClick {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.linkString;
    
    
    [MBProgressHUD wj_showSuccess];
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{ return NO; }

#pragma mark - action
- (IBAction)copyAction:(UIButton *)sender {
    [self copylinkBtnClick];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self setHidden:YES];
}

#pragma mark - setter

-(void)setLinkString:(NSString *)linkString{
    _linkString = linkString;
    [self.textView setText:linkString];
}

@end
