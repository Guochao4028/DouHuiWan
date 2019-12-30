//
//  FansOrderTableViewCell.m
//  likeBuy
//
//  Created by mac on 2019/11/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "FansOrderTableViewCell.h"
#import "OrderModel.h"

@interface FansOrderTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *heardImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *yongjinLabel;
@property (weak, nonatomic) IBOutlet UIView *rongqiView;

@end

@implementation FansOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.rongqiView.layer.cornerRadius = 4;
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    self.heardImageView.layer.cornerRadius = 20;
    
    self.heardImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(OrderModel *)model{
    [self.heardImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    
    
    
    NSString *price = model.yuguFree;
    
    NSInteger tkStatus = [model.tkStatus integerValue];
    
    if (tkStatus == 1 || tkStatus == 3) {
           
            price = model.selfComnissionFee;
              
       }else{
           if (price == nil && model.selfComnissionFee != nil) {
               price = model.selfComnissionFee;
           }
       }
    
    
    NSString *title = [NSString stringWithFormat:@"您的粉丝【%@】在%@推广成功，预估普通佣金:%@元，预计结算时间：收货后次月25日结算",model.shortName, model.createTime, price];
    
    [self.titleLabel setText:title];
    
    [self.orderNumberLabel setText:[NSString stringWithFormat:@"订单号：%@",model.tradeId]];
    
    [self.orderTypeLabel setText:[NSString stringWithFormat:@"订单类型：%@",model.orderType]];
    
    [self.priceLabel setText:[NSString stringWithFormat:@"订单金额：%@",model.payPrice]];
    
    
    float priceFloat = [price floatValue];
    
    [self.yongjinLabel setText:[NSString stringWithFormat:@"获得普通佣金：%.2f",priceFloat]];

}

@end
