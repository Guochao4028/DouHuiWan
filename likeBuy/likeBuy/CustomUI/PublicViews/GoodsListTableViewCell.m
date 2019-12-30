//
//  GoodsListTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "GoodsListTableViewCell.h"
#import "GoodsModel.h"
#import "PddGoodsListModel.h"
//#import "UIView+CGFrameLayout.h"

@interface GoodsListTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *storeIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *storeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *voucherLabel;
@property (weak, nonatomic) IBOutlet UILabel *pinLabel;
@property (weak, nonatomic) IBOutlet UILabel *prizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *couponViewW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *couponBGw;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *couponLabelW;
@property (weak, nonatomic) IBOutlet UIView *couponView;
@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;

@end

@implementation GoodsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     [self.contentView setBackgroundColor:WHITE];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.goodsImageView.layer.masksToBounds = YES;
    self.goodsImageView.layer.cornerRadius = 4;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setModel:(GoodsModel *)model{
    _model = model;
    
    [self.goodsTitleLabel setText:model.title];
    
    if (model.pictUrl == nil) {
        
        if (model.smallImages.count > 0) {
             [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.smallImages[0]]];
        }
        
    }else{
        if ([model.pictUrl rangeOfString:@"http"].location !=NSNotFound) {
            [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.pictUrl]];
        }else{
            [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",model.pictUrl]]];
        }
    }
    
    
    
    
   
    [self.storeTitleLabel setText:model.shopTitle];
    
    NSString *storeTitleLabelText = self.storeTitleLabel.text;
    
    if ([storeTitleLabelText length] == 0) {
        [self.storeTitleLabel setText:model.nick];
    }
    
    [self.pinLabel setText:[NSString stringWithFormat:@"月销%@", model.volume]];
    
    if (model.commissionRate.length > 0) {
        [self.prizeLabel setHidden:NO];
        
        NSString *tem = [NSString stringWithFormat:@"%.2f",[model.commissionRate floatValue]];
        
        
       float commissionRate = [model.commissionRate floatValue];
        
        [self.prizeLabel setText:[NSString stringWithFormat:@"返¥%.2f", commissionRate]];
        
        if([tem floatValue] <= 0){
             [self.prizeLabel setHidden:YES];
        }
    }else{
        [self.prizeLabel setHidden:YES];
    }
    
    NSString *couponInfo = model.couponInfo;
    
    NSInteger couponInfoNumber = [couponInfo integerValue];
    NSString *subString;
    CGFloat width;
    if (couponInfo.length > 0 && couponInfoNumber > 0) {
         [self.couponView setHidden:NO];
        NSRange range = [couponInfo rangeOfString:@"减"];
        if (range.location != NSNotFound) {
            subString = [couponInfo substringFromIndex:(range.location +1)];
            [self.couponLabel setText:[NSString stringWithFormat:@" 劵 ¥%@ ", subString]];
        }else{
            [self.couponLabel setText:[NSString stringWithFormat:@" 劵 ¥%@ ", couponInfo]];
        }
        width = [self getWidthWithText:self.couponLabel.text height:14 font:12] + 1;
        self.couponViewW.constant = width;
    }else{
        [self.couponView setHidden:YES];
    }
    
    if ([self.couponView isHidden] == YES) {
        if ((model.couponEndTime != nil)&&(model.couponAfterPrice != nil)) {
               [self.couponView setHidden:NO];
               float couponAfterPrice = [model.couponAfterPrice floatValue];
               float zkFialPrice  = [model.zkFinalPrice floatValue];
               
               float price = ( zkFialPrice - couponAfterPrice);
            
            if (price == 0) {
                [self.couponView setHidden:YES];
            }else{
                
                NSString *newPire = [NSString stringWithFormat:@"¥%.2f",price];
                
                
                [self.couponLabel setText:[NSString stringWithFormat:@" 劵 %@ ", [self removeSuffix:newPire]]];
                CGFloat  width = [self getWidthWithText:self.couponLabel.text height:14 font:12] + 1;
                 self.couponViewW.constant = width;
            }
           }
    }
    
    NSInteger userType = [model.userType integerValue];
    
    if (userType == 1) {
        [self.storeIconImageView setImage:[UIImage imageNamed:@"tianmao"]];
    }else{
        [self.storeIconImageView setImage:[UIImage imageNamed:@"taobao"]];
    }
    
    if (model.couponAfterPrice.length > 0) {
        
        NSString *newPire = [NSString stringWithFormat:@"¥%.2f",[model.couponAfterPrice floatValue]];
        
        [self.voucherLabel setText:[self removeSuffix:newPire]];
        
        [self.instructionsLabel setText:@"劵后"];
    }else{
        
         NSString *newPire = [NSString stringWithFormat:@"¥%.2f",[model.zkFinalPrice floatValue]];
        [self.voucherLabel setText:[self removeSuffix:newPire]];
//        [self.voucherLabel setText:,se[model.zkFinalPrice]];
        
        [self.instructionsLabel setText:@"折扣价"];
    }
    
    if (model.couponInfo.length > 0 ||model.couponEndTime.length > 0) {
        
        if (model.couponAfterPrice.length == 0) {
            
            float  zkFinalPrice = [model.zkFinalPrice floatValue];
            float  coupon = [model.couponInfo floatValue];
            float couponPrice = zkFinalPrice - coupon;
            
            NSString *newPire = [NSString stringWithFormat:@"¥%.2f",couponPrice];
            
            [self.voucherLabel setText:[self removeSuffix:newPire]];
            
            [self.instructionsLabel setText:@"劵后"];
        }
    }
//        self.storeIconImageView sd_setImageWithURL:[NSURL URLWithString:model.]
    
    [self stroeIcon:model];
    
    if(userType == 3){
        [self.storeIconImageView setImage:[UIImage imageNamed:@"pdd"]];
    }else if(userType == 4){
        [self.storeIconImageView setImage:[UIImage imageNamed:@"jingdong"]];
    }else if(userType == 5){
        [self.storeIconImageView setImage:[UIImage imageNamed:@"chaoshi"]];
    }
}

- (NSString *)removeSuffix:(NSString *)numberStr{
    if (numberStr.length > 1) {
        
        if ([numberStr componentsSeparatedByString:@"."].count == 2) {
            NSString *last = [numberStr componentsSeparatedByString:@"."].lastObject;
            if ([last isEqualToString:@"00"]) {
                numberStr = [numberStr substringToIndex:numberStr.length - (last.length + 1)];
                return numberStr;
            }else{
                if ([[last substringFromIndex:last.length -1] isEqualToString:@"0"]) {
                    numberStr = [numberStr substringToIndex:numberStr.length - 1];
                    return numberStr;
                }
            }
        }
        return numberStr;
    }else{
        return nil;
    }
}

-(void)setDic:(NSDictionary *)dic{
    NSInteger userType = [dic[@"type"] integerValue];
    switch (userType) {
        case 0:{
            [self.storeIconImageView setImage:[UIImage imageNamed:@"pdd"]];
        }
            break;
        case 1:{
            [self.storeIconImageView setImage:[UIImage imageNamed:@"jd"]];
        }
            break;
        case 2:{
            [self.storeIconImageView setImage:[UIImage imageNamed:@"chaoshi"]];
        }
            break;
        case 3:{
            [self.storeIconImageView setImage:[UIImage imageNamed:@"taobao"]];
        }
            break;
        case 4:{
            [self.storeIconImageView setImage:[UIImage imageNamed:@"tianmao"]];
        }
            break;
        default:
            break;
    }
}

- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat )font{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width;
}

-(void)stroeIcon:(GoodsModel *)tem{
    

    NSInteger userType = [tem.userType integerValue];
    if (tem.isComm != nil) {
        
        NSInteger userType = [tem.isComm[@"type"] integerValue];
        switch (userType) {
            case 0:{
                [self.storeIconImageView setImage:[UIImage imageNamed:@"pdd"]];
            }
                break;
            case 1:{
                [self.storeIconImageView setImage:[UIImage imageNamed:@"jd"]];
            }
                break;
            case 2:{
                [self.storeIconImageView setImage:[UIImage imageNamed:@"chaoshi"]];
            }
                break;
            case 3:{
                [self.storeIconImageView setImage:[UIImage imageNamed:@"taobao"]];
            }
                break;
            case 4:{
                [self.storeIconImageView setImage:[UIImage imageNamed:@"tianmao"]];
            }
                break;
            default:
                break;
        }
        
    }else{
        if (userType == 1) {
            [self.storeIconImageView setImage:[UIImage imageNamed:@"tianmao"]];
        }else{
            [self.storeIconImageView setImage:[UIImage imageNamed:@"taobao"]];
        }
    }
    
    
    if (tem.nick != nil) {
        if ([tem.nick isEqualToString:@"天猫超市"]) {
            [self.storeIconImageView setImage:[UIImage imageNamed:@"chaoshi"]];
        }else if ([tem.nick  rangeOfString:@"天猫"].location != NSNotFound) {
            [self.storeIconImageView setImage:[UIImage imageNamed:@"tianmao"]];
        }
    }
}

-(void)setGoodsListModel:(PddGoodsListModel *)goodsListModel{
    _goodsListModel = goodsListModel;
    
    [self.goodsTitleLabel setText:goodsListModel.goodsName];
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsListModel.goodsImageUrl]];
    [self.storeTitleLabel setText:goodsListModel.mallName];
    [self.pinLabel setText:[NSString stringWithFormat:@"月销%@", goodsListModel.salesTip]];
    
    [self.prizeLabel setText:[NSString stringWithFormat:@"返¥%@", goodsListModel.couponAmount]];
    
    BOOL hasCoupon = [goodsListModel.hasCoupon boolValue];
    CGFloat width;
    float newPrice;
    if (hasCoupon == YES) {
        [self.couponView setHidden:NO];
        [self.couponLabel setText:[NSString stringWithFormat:@" 劵 ¥%@ ", goodsListModel.couponDiscount]];
        width = [self getWidthWithText:self.couponLabel.text height:14 font:12] + 1;
        self.couponViewW.constant = width;
        [self.instructionsLabel setText:@"拼团"];
        newPrice = [goodsListModel.minGroupPrice floatValue];
    }else{
        [self.couponView setHidden:YES];
        [self.instructionsLabel setText:@"单买价"];
        newPrice = [goodsListModel.minNormalPrice floatValue];

    }
    [self.storeIconImageView setImage:[UIImage imageNamed:@"pdd"]];
    
     NSString *newPire = [NSString stringWithFormat:@"¥%.2f",newPrice];
    
    [self.voucherLabel setText:[self removeSuffix:newPire]];
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if ([self.delegate respondsToSelector:@selector(tapGoodsListTableViewCell:)]) {
//        [self.delegate tapGoodsListTableViewCell:self.model];
//    }
//}

-(void)setDelegate:(id<GoodsListTableViewCellDelegate>)delegate{
    _delegate = delegate;
    if (self.delegate != nil) {
           UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchesView)];
           [self addGestureRecognizer:tap];
       }
}

-(void)touchesView{
     if ([self.delegate respondsToSelector:@selector(tapGoodsListTableViewCell:)]) {
            [self.delegate tapGoodsListTableViewCell:self.model];
        }
}

@end
