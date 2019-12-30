//
//  StoreInfoTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/16.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "StoreInfoTableViewCell.h"

#import "GoodsModel.h"

#import "GoodsDetailModel.h"

#import "ShopModel.h"

@interface StoreInfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;
@property (weak, nonatomic) IBOutlet UILabel *baobeiTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *baobeiNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *wuliuTitelLabel;

@property (weak, nonatomic) IBOutlet UILabel *wuliuNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *fuwuTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fuwuNumberLabel;


@end

@implementation StoreInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView setBackgroundColor:WHITE];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(GoodsDetailModel *)model{
    _model = model;
    
    [self.storeNameLabel setText:model.shopTitle];
    
    NSInteger userType = [model.userType integerValue];
    
    
    GoodsModel *tem = model.goodsModel;
    
    if (tem.isComm != nil) {
        
        NSInteger userType = [tem.isComm[@"type"] integerValue];
        switch (userType) {
            case 0:{
                [self.storeImageView setImage:[UIImage imageNamed:@"pdd"]];
            }
                break;
            case 1:{
                [self.storeImageView setImage:[UIImage imageNamed:@"jd"]];
            }
                break;
            case 2:{
                [self.storeImageView setImage:[UIImage imageNamed:@"chaoshi"]];
            }
                break;
            case 3:{
                [self.storeImageView setImage:[UIImage imageNamed:@"taobao"]];
            }
                break;
            case 4:{
                [self.storeImageView setImage:[UIImage imageNamed:@"tianmao"]];
            }
                break;
            default:
                break;
        }
        
    }else{
        if (userType == 1) {
            [self.storeImageView setImage:[UIImage imageNamed:@"tianmao"]];
        }else{
            [self.storeImageView setImage:[UIImage imageNamed:@"taobao"]];
        }
    }
    
    
    if (model.nick != nil) {
        if ([model.nick isEqualToString:@"天猫超市"]) {
            [self.storeImageView setImage:[UIImage imageNamed:@"chaoshi"]];
        }else if ([model.nick  rangeOfString:@"天猫"].location != NSNotFound) {
            [self.storeImageView setImage:[UIImage imageNamed:@"tianmao"]];
        }
    }
    
    
    for(int i = 0; i < model.evaluatesList.count ; i++) {
        ShopModel *shopModel = model.evaluatesList[i];
        switch (i) {
            case 0:
            {
                [self.baobeiTitleLabel setText:shopModel.title];
                [self.baobeiNumberLabel setText:shopModel.levelText];
                
            }
                break;
            case 1:
            {
                [self.wuliuTitelLabel setText:shopModel.title];
                [self.wuliuNumberLabel setText:shopModel.levelText];
                
            }
                break;
                
            case 2:
            {
                [self.fuwuTitleLabel setText:shopModel.title];
                [self.fuwuNumberLabel setText:shopModel.levelText];
            }
                break;
                
            default:
                break;
        }
    }
    
    
    if ([model.userType isEqualToString:@"3"]) {
        [self.storeImageView setImage:[UIImage imageNamed:@"pdd"]];
    }else if ([model.userType isEqualToString:@"4"]) {
        [self.storeImageView setImage:[UIImage imageNamed:@"jd"]];
    }else if ([model.userType isEqualToString:@"5"]) {
        [self.storeImageView setImage:[UIImage imageNamed:@"chaoshi"]];
    }
}

@end
