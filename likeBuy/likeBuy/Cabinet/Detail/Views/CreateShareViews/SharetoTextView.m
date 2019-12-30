//
//  SharetoTextView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/18.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "SharetoTextView.h"

@interface SharetoTextView()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *saveView;
@property (weak, nonatomic) IBOutlet UIView *weixinView;
@property (weak, nonatomic) IBOutlet UIView *pengyouquanView;
@property (weak, nonatomic) IBOutlet UIView *qqView;
@property (weak, nonatomic) IBOutlet UIView *qqZView;

@end


@implementation SharetoTextView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"SharetoTextView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
    
    UITapGestureRecognizer *saveTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(savePic)];
    [self.saveView addGestureRecognizer:saveTap];
    
    UITapGestureRecognizer *weixinTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendWeiXin)];
    [self.weixinView addGestureRecognizer:weixinTap];
    
    UITapGestureRecognizer *pengyouquanTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendPengyouquan)];
    [self.pengyouquanView addGestureRecognizer:pengyouquanTap];
    
    UITapGestureRecognizer *qqTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendQQ)];
    [self.qqView addGestureRecognizer:qqTap];
    
    
    UITapGestureRecognizer *qqZTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendQQZ)];
    [self.qqZView addGestureRecognizer:qqZTap];
    
    
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}

#pragma mark - action
-(void)savePic{
    if ([self.delegate respondsToSelector:@selector(tapSavePic)]) {
        [self.delegate tapSavePic];
    }
}

-(void)sendWeiXin{
    if ([self.delegate respondsToSelector:@selector(tapSendWeiXin)]) {
        [self.delegate tapSendWeiXin];
    }
}

-(void)sendPengyouquan{
    if ([self.delegate respondsToSelector:@selector(tapSendPengyouquan)]) {
        [self.delegate tapSendPengyouquan];
    }
}

-(void)sendQQ{
    if ([self.delegate respondsToSelector:@selector(tapSendQQ)]) {
        [self.delegate tapSendQQ];
    }
}

-(void)sendQQZ{
    if ([self.delegate respondsToSelector:@selector(tapSendQQZ)]) {
        [self.delegate tapSendQQZ];
    }
}


@end
