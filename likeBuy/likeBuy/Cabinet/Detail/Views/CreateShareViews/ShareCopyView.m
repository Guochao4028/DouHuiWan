//
//  ShareCopyView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/18.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "ShareCopyView.h"

@interface ShareCopyView()<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)copyAction:(id)sender;

@end

@implementation ShareCopyView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"ShareCopyView" owner:self options:nil];
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
//    [SVProgressHUD showSuccessWithStatus:@"复制成功"];
    
    [MBProgressHUD wj_showSuccess];
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{ return NO; }

#pragma mark - action
- (IBAction)copyAction:(id)sender {
    [self copylinkBtnClick];
}

#pragma mark - setter

-(void)setLinkString:(NSString *)linkString{
    _linkString = linkString;
    [self.textView setText:linkString];
}


@end
