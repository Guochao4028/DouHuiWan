//
//  WantBuyView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/28.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "WantBuyView.h"

#import "GoodsDetailModel.h"

//#import "WantBuyModel.h"

@interface WantBuyView()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitle;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *jiangLabel;

@property (weak, nonatomic) IBOutlet UIButton *kanButton;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UILabel *quanLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quanViewW;
@property (weak, nonatomic) IBOutlet UIView *quanView;

@end


@implementation WantBuyView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"WantBuyView" owner:self options:nil];
        [self initUI];
        
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.contentView];
    [self.contentView  setFrame:self.bounds];
    
    
    self.kanButton.layer.cornerRadius = 4;
    self.kanButton.layer.borderWidth = 1;
    self.kanButton.layer.borderColor = [UIColor redColor].CGColor;
    self.kanButton.layer.masksToBounds = YES;
    
    
    self.buyButton.layer.cornerRadius = 4;
    self.buyButton.layer.borderWidth = 1;
    self.buyButton.layer.borderColor = [UIColor redColor].CGColor;
    self.buyButton.layer.masksToBounds = YES;
    
    
    [self.kanButton addTarget:self action:@selector(kanAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.buyButton addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}


-(void)setModel:(GoodsDetailModel *)model{
    _model = model;
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    
    [self.priceLabel setText:[NSString stringWithFormat:@"¥%@", model.couponAfterPrice]];
    
    if(model.commissionRate.length > 0){
        [self.jiangLabel setText:[NSString stringWithFormat:@" 返¥%@ ", model.commissionRate]];
    }
    
    
    self.jiangLabel.layer.borderWidth = 1;
    self.jiangLabel.layer.borderColor = [UIColor redColor].CGColor;
    self.jiangLabel.layer.masksToBounds = YES;
    
    NSString *couponInfo = model.couponInfo;
    NSString *subString;
    if (couponInfo.length > 0) {
        [self.quanView setHidden:NO];
        
        NSRange range = [couponInfo rangeOfString:@"减"];
        subString = [couponInfo substringFromIndex:(range.location +1)];
        
        [self.quanLabel setText:[NSString stringWithFormat:@"劵 ¥%@",subString]];
        
        CGFloat width = [self getWidthWithText:self.quanLabel.text height:14 font:12] + 1;
        
        self.quanViewW.constant = width;
    }else{
        [self.quanView setHidden:YES];
        self.quanViewW.constant = 0;
    }
    
    [self.goodsTitle setText:model.title];
    
    float price = [model.coupon floatValue] + [model.commissionRate floatValue];
    
    [self.buyButton setTitle:[NSString stringWithFormat:@"购买省¥%.2f", price] forState:UIControlStateNormal];
}

- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat )font{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width;
}


-(void)kanAction{
    
    if ([self.delegate respondsToSelector:@selector(jumpGoodsDetail:)]) {
        [self.delegate jumpGoodsDetail:self.model];
    }
    
}

-(void)buyAction{
    if ([self.delegate respondsToSelector:@selector(jumpTaoBao:)]) {
        [self.delegate jumpTaoBao:self.model];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self setHidden:YES];
}

@end
