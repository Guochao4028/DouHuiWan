//
//  DeadCollectionViewCell.m
//  likeBuy
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "DeadCollectionViewCell.h"
#import "NSString+Tool.h"
#import "GoodsModel.h"

@interface DeadCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *quanLabel;
@property (weak, nonatomic) IBOutlet UIView *couponView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *couponViewW;

@end

@implementation DeadCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
     [self.contentView setBackgroundColor:WHITE];
    
}

-(void)setModel:(GoodsModel *)model{
    [self.goodsTitleLabel setText:model.title];
    
    NSString *couponTab = model.couponInfo;
    
    if (model.couponAfterPrice.length == 0) {
        
        NSRange range = [couponTab rangeOfString:@"减"];
        if (range.location == NSNotFound) {
            float zkFinalPrice = [model.zkFinalPrice floatValue];
            float coupon = [model.couponInfo floatValue];
            model.couponAfterPrice = [NSString stringWithFormat:@"%f", zkFinalPrice - coupon];
        }
    }
   
    
    NSString *imageUrlStr = model.pictUrl;
    if ([imageUrlStr containsString:@"http://"] == YES || [imageUrlStr containsString:@"https://"] == YES) {
        [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
    }else{
        NSString *tem = [NSString stringWithFormat:@"http:%@",imageUrlStr];
        [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:tem]];
    }

    NSString *couponInfo = model.couponInfo;
    
    NSString *subString;
    if (couponInfo.length > 0) {
        [self.quanLabel setHidden:NO];
        NSRange range = [couponInfo rangeOfString:@"减"];
        if (range.location != NSNotFound) {
            subString = [couponInfo substringFromIndex:(range.location +1)];
            
            [self.quanLabel setText:[NSString stringWithFormat:@" 劵 ¥%@ ", subString]];
            CGFloat width = [self getWidthWithText:self.quanLabel.text height:14 font:12] + 1;
            
            self.couponViewW.constant = width;
        }else if ([NSString isNumber:couponInfo] == YES){
            [self.quanLabel setText:[NSString stringWithFormat:@" 劵 ¥%@ ", couponInfo]];
            CGFloat width = [self getWidthWithText:self.quanLabel.text height:14 font:12] + 1;
            self.couponViewW.constant = width;
        }else{
            [self.couponView setHidden:YES];
        }
    }else{
        [self.couponView setHidden:YES];
    }
    
    if (model.couponAfterPrice.length > 0) {
        NSString *newPire = [NSString stringWithFormat:@"¥%.2f",[model.couponAfterPrice floatValue]];
        [self.priceLabel setText:[self removeSuffix:newPire]];
    }else{
        NSString *newPire = [NSString stringWithFormat:@"¥%.2f",[model.zkFinalPrice floatValue]];
        [self.priceLabel setText:[self removeSuffix:newPire]];
    }
}

- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat )font{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width;
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


@end
