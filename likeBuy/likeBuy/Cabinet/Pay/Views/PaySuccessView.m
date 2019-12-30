//
//  PaySuccessView.m
//  likeBuy
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "PaySuccessView.h"
#import "GoodsDetailModel.h"


@interface PaySuccessView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *funchLabel;

@end

@implementation PaySuccessView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"PaySuccessView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.contentView];
    [self.contentView  setFrame:self.bounds];
}


- (IBAction)back:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(back)] == YES) {
        [self.delegate back];
    }
}

-(void)setModel:(GoodsDetailModel *)model{
    [self.priceLabel setText:[NSString stringWithFormat:@"￥%@", model.couponAfterPrice]];
    
     [self.payLabel setText:[NSString stringWithFormat:@"￥%@", model.couponAfterPrice]];
    
    User *user = [[DataManager shareInstance]getUser];
    
    [self.nameLabel setText:user.shortName];
    
    [self.funchLabel setText:self.funName];
    
}
@end
