//
//  OrdeTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "OrdeTableViewCell.h"
#import "OrderModel.h"

@interface  OrdeTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *xidanshijianLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *piceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldLabel;
@property (weak, nonatomic) IBOutlet UILabel *staticLabel;
@property (weak, nonatomic) IBOutlet UILabel *ordeNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ordeIconImageView;

@end

@implementation OrdeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(OrderModel *)model{
    [self.xidanshijianLabel setText:[NSString stringWithFormat:@"下单时间:%@", model.createTime]];
    
    NSString *oderType = model.orderType;
    if ([oderType isEqualToString:@"天猫"] == YES) {
        [self.ordeIconImageView setImage:[UIImage imageNamed:@"tianmao"]];
    }else if ([oderType isEqualToString:@"淘宝"] == YES){
        [self.ordeIconImageView setImage:[UIImage imageNamed:@"taobao"]];
    }else if ([oderType isEqualToString:@"京东"] == YES){
        [self.ordeIconImageView setImage:[UIImage imageNamed:@"jd"]];
    }else if ([oderType isEqualToString:@"拼多多"] == YES){
        [self.ordeIconImageView setImage:[UIImage imageNamed:@"pdd"]];
    }
    
    
    if ([model.itemImg rangeOfString:@"http"].location !=NSNotFound) {
        [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.itemImg]];
    }else{
        [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",model.itemImg]]];
    }
    

    [self.ordeNumberLabel setText:[NSString stringWithFormat:@"订单号:%@", model.tradeId]];
    
    NSString *payPrice = model.payPrice;
    
    if (payPrice.length == 0) {
        payPrice = @"0";
    }
    

    [self.piceLabel setText:[NSString stringWithFormat:@"付款%@元", payPrice]];

    NSInteger tkStatus = [model.tkStatus integerValue];
    
    NSString *statusStr;
    
    NSString *finishStr;
//
    switch (tkStatus) {
        case 1:{
            statusStr = @"订单结算";
            finishStr = @"到账佣金";
            
        }
            break;
            case 3:{
                statusStr = @"订单结算";
                finishStr = @"到账佣金";
                
            }
                break;
        case 12:{
            statusStr = @"订单付款";
            finishStr = @"预估佣金";
        }
            break;
        case 13:{
            statusStr = @"订单失效";
            finishStr = @"预估佣金";
        }
            

            break;
        case 14:{
            statusStr = @"订单成功";
            finishStr = @"到账佣金";
            
        }
            break;

        default:{
            statusStr = @"订单结算";
            finishStr = @"预估佣金";
        }
            break;
    }
    
    [self.staticLabel setText:statusStr];
    
    NSString *freePice = model.yuguFree;
    
    
    if (tkStatus == 1 || tkStatus == 3) {
        if ([self.orderType isEqualToString:@"2"] == NO) {
                freePice = model.selfComnissionFee;
           }
    }else{
        if (freePice == nil && model.selfComnissionFee != nil) {
            freePice = model.selfComnissionFee;
        }
    }
    
    

    [self.goldLabel setText:[NSString stringWithFormat:@"%@￥%@", finishStr,freePice]];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@￥%@", finishStr,freePice]];

    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, 1+freePice.length)];
    
    [self.goldLabel setAttributedText:str];

    
}



@end
