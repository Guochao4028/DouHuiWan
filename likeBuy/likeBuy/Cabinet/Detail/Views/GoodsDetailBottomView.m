//
//  GoodsDetailBottomView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/17.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "GoodsDetailBottomView.h"
#import "GoodsDetailModel.h"




@interface GoodsDetailBottomView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *collectionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *collectionImageView;
@property (weak, nonatomic) IBOutlet UIButton *indexButton;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
- (IBAction)buyAction:(id)sender;
- (IBAction)shareAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;


@property (weak, nonatomic) IBOutlet UILabel *lingQuanTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lingQuanPriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lingQuanTop;


@property (weak, nonatomic) IBOutlet UILabel *shareTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sharePriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shareTop;
//在 showconfig是yes时的立即购买
- (IBAction)nowBuyAction:(id)sender;
//在 showconfig是yes时的立即购买 view
@property (weak, nonatomic) IBOutlet UIView *nowBuyView;

@end


@implementation GoodsDetailBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"GoodsDetailBottomView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
    
    [self.indexButton addTarget:self action:@selector(tapIndexAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.collectionButton addTarget:self action:@selector(tapCollectionAction) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}

#pragma mark - action
-(void)tapIndexAction{
    if ([self.delegate respondsToSelector:@selector(jumpHomePage)]) {
        [self.delegate jumpHomePage];
    }
}

-(void)tapCollectionAction{
    if ([self.delegate respondsToSelector:@selector(tapCollection)]) {
        [self.delegate tapCollection];
    }
}



- (IBAction)buyAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(tapBuy)]) {
        [self.delegate tapBuy];
    }
}

- (IBAction)shareAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(tapShare)]) {
        [self.delegate tapShare];
    }
}

-(void)setIsfavorite:(BOOL)isfavorite{
    _isfavorite = isfavorite;
    if (isfavorite == YES) {
        [self.collectionImageView setImage:[UIImage imageNamed:@"collect2ion_fill"]];
    }else{
        [self.collectionImageView setImage:[UIImage imageNamed:@"collection"]];
    }
}

-(void)setIsIosStatue:(BOOL)isIosStatue{
    
    
    _isIosStatue = isIosStatue;
    if(isIosStatue == YES){
        
        //        [self.shareButton setTitle:@"立即购买" forState:UIControlStateNormal];
        self.shareTop.constant = (42-14)/2;
        [self.shareTitleLabel setText:@""];
        [self.sharePriceLabel setText:@""];
        
        self.lingQuanTop.constant = (42-14)/2;
        [self.lingQuanTitleLabel setText:@""];
         [self.lingQuanPriceLabel setText:@""];
        
        [self.nowBuyView setHidden:NO];
        
    }else{
        [self.nowBuyView setHidden:YES];
        self.shareTop.constant = 5;
        [self.shareTitleLabel setText:@"分享奖"];
        [self.sharePriceLabel setText:@""];
        //        [self.shareButton setTitle:@"分享奖励" forState:UIControlStateNormal];
    }
}


#pragma mark - setter / getter

-(void)setModel:(GoodsDetailModel *)model{
    
    float couponFloat = [model.coupon floatValue];
    float commissionRateFloat = [model.commissionRate floatValue];
    
    if (self.isIosStatue == YES) {
        [self.nowBuyView setHidden:NO];
    }else{
        [self.nowBuyView setHidden:YES];
        if (couponFloat == 0 && commissionRateFloat == 0) {
            self.lingQuanTop.constant = (42-14)/2;
            [self.lingQuanTitleLabel setText:@"领券购买"];
            [self.lingQuanPriceLabel setText:@""];
            
            self.shareTop.constant = (42-14)/2;
            [self.shareTitleLabel setText:@"立即购买"];
            [self.sharePriceLabel setText:@""];
            
        }else{
            
            self.lingQuanTop.constant = 5;
            [self.lingQuanTitleLabel setText:@"购买省"];
            [self.lingQuanPriceLabel setText:[NSString stringWithFormat:@"¥%.2f", (couponFloat+commissionRateFloat)]];
            
            self.shareTop.constant = 5;
            [self.shareTitleLabel setText:@"分享奖"];
            [self.sharePriceLabel setText:[NSString stringWithFormat:@"¥%.2f", commissionRateFloat]];
            
        }
        
    }
    
}

//在 showconfig是yes时的立即购买
- (IBAction)nowBuyAction:(id)sender {
  if ([self.delegate respondsToSelector:@selector(tapNowBuy)]) {
        [self.delegate tapNowBuy];
    }
}

@end
