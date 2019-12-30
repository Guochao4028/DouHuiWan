//
//  PayPageTitleView.m
//  likeBuy
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "PayPageTitleView.h"
#import "GoodsDetailModel.h"

@interface PayPageTitleView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end


@implementation PayPageTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"PayPageTitleView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.contentView];
    [self.contentView  setFrame:self.bounds];
    [self setCornerWithView:self.contentView viewSize:self.contentView.frame.size corners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) radius:30];
    
}

-(void)setModel:(GoodsDetailModel *)model{
    
    [self.priceLabel setText:[NSString stringWithFormat:@"￥%@", model.couponAfterPrice]];
    
}



- (void)setCornerWithView:(UIView*)view
                 viewSize:(CGSize)viewSize
                  corners:(UIRectCorner)corners
                   radius:(CGFloat)radius{
    CGRect fr = CGRectZero;
    fr.size = viewSize;
    
    UIBezierPath *round = [UIBezierPath bezierPathWithRoundedRect:fr byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *shape = [[CAShapeLayer alloc]init];
    
    [shape setPath:round.CGPath];
    view.layer.mask = shape;
}

- (IBAction)back:(id)sender {

    if ([self.delegate respondsToSelector:@selector(back)] == YES) {
        [self.delegate back];
    }
    
}


@end
