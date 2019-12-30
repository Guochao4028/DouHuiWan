//
//  GoodsInfoTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/16.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "GoodsInfoTableViewCell.h"
#import "GoodsDetailModel.h"
#import "GoodsModel.h"
#import "DBManager.h"


@interface GoodsInfoTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *piceLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiangLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *xiaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *quanLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *uhquanView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stroeImageView;
@property (weak, nonatomic) IBOutlet UILabel *quanTitleLabel;


@end


@implementation GoodsInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView setBackgroundColor:WHITE];
    
    //self.title 加入长按
    [self.title setUserInteractionEnabled:YES];
    //长按手势
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    [self.title addGestureRecognizer:longPress];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setModel:(GoodsDetailModel *)model{
    
    [self stroeIcon:model];
    
    [self.piceLabel setText:[NSString stringWithFormat:@"￥%@", model.couponAfterPrice]];
    
    
    [self.jiangLabel setText:[NSString stringWithFormat:@" 返¥%@ ", model.commissionRate]];
    [self.jiangLabel setBackgroundColor:[UIColor colorWithHexString:@"FFEBD8"]];
    self.jiangLabel.layer.cornerRadius = 2;
    
    
    NSString *str = [NSString stringWithFormat:@"原价¥%@", model.zkFinalPrice];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, str.length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorWithHexString:@"9A9B9D"] range:NSMakeRange(0, str.length)];
    [self.yuanLabel setAttributedText:attri];
    
    [self.xiaoLabel setText:[NSString stringWithFormat:@"月销%@", model.volume]];
    [self.title setText:model.title];
    [self.quanLabel setText:[NSString stringWithFormat:@"%@元优惠券", model.coupon]];
    
    
    if (model.couponStartTime.length > 0 && model.couponEndTime.length > 0) {
        [self.timeLabel setText:[NSString stringWithFormat:@"使用期限：%@ - %@",model.couponStartTime, model.couponEndTime]];
    }else if (model.couponEndTime.length > 0){
        [self.timeLabel setText:[NSString stringWithFormat:@"截止期限 %@", model.couponEndTime]];
    }else{
        [self.timeLabel setText:[NSString stringWithFormat:@"使用期限： - "]];
    }
    
    
    
    if (model.couponEndTime.length == 0 && model.couponStartTime.length == 0) {
        [self.desLabel setText:@"折扣价"];
    }else{
        [self.desLabel setText:@"券后价"];
    }
    
    [self.timeLabel setAdjustsFontSizeToFitWidth:YES];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
    [self.uhquanView addGestureRecognizer:tap];
    
    
   BOOL isShowconfig = [DBManager shareInstance].isShowconfig;
    
    if (isShowconfig == YES) {
        [self.quanTitleLabel setText:@"立即购买"];
    }
}

-(void)tapView{
    if([self.delegate respondsToSelector:@selector(tapGoodsInfoView)]){
        [self.delegate tapGoodsInfoView];
    }
}

-(void)stroeIcon:(GoodsDetailModel *)tem{
    
   GoodsModel *t = tem.goodsModel;
    NSInteger userType = [tem.userType integerValue];
    if (t.isComm != nil) {
        
        NSInteger userType = [t.isComm[@"type"] integerValue];
        switch (userType) {
            case 0:{
                [self.stroeImageView setImage:[UIImage imageNamed:@"pdd"]];
            }
                break;
            case 1:{
                [self.stroeImageView setImage:[UIImage imageNamed:@"jd"]];
            }
                break;
            case 2:{
                [self.stroeImageView setImage:[UIImage imageNamed:@"chaoshi"]];
            }
                break;
            case 3:{
                [self.stroeImageView setImage:[UIImage imageNamed:@"taobao"]];
            }
                break;
            case 4:{
                [self.stroeImageView setImage:[UIImage imageNamed:@"tianmao"]];
            }
                break;
            default:
                break;
        }
        
    }else{
        if (userType == 1) {
            [self.stroeImageView setImage:[UIImage imageNamed:@"tianmao"]];
        }else{
            [self.stroeImageView setImage:[UIImage imageNamed:@"taobao"]];
        }
    }
    
    
    if (tem.nick != nil) {
        if ([tem.nick isEqualToString:@"天猫超市"]) {
            [self.stroeImageView setImage:[UIImage imageNamed:@"chaoshi"]];
        }else if ([tem.nick  rangeOfString:@"天猫"].location != NSNotFound) {
            [self.stroeImageView setImage:[UIImage imageNamed:@"tianmao"]];
        }
    }
    
     if ([tem.userType isEqualToString:@"3"]) {
           [self.stroeImageView setImage:[UIImage imageNamed:@"pdd"]];
       }else if ([tem.userType isEqualToString:@"4"]) {
           [self.stroeImageView setImage:[UIImage imageNamed:@"jd"]];
       }else if ([tem.userType isEqualToString:@"5"]) {
           [self.stroeImageView setImage:[UIImage imageNamed:@"chaoshi"]];
       }
}

#pragma mark - 长按功能实现， 长按title 弹出复制菜单
/** 长按方法 */
-(void)longPressAction:(UILongPressGestureRecognizer *)sender
{
    if (sender.state==UIGestureRecognizerStateBegan)
    {
        // 必须先是响应者 才能触发菜单
        [self becomeFirstResponder];
        UIMenuItem *copyItem=[[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copyAction:)];
        UIMenuController *menuC=[UIMenuController sharedMenuController];
        [menuC setMenuItems:@[copyItem]];
        [menuC setTargetRect:sender.view.frame inView:self.contentView];
        [menuC setMenuVisible:YES animated:YES];
    }
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action==@selector(copyAction:))
    {
        return YES;
    }
    return NO;
}

/** 复制标题到剪切板 */
-(void)copyAction:(UIMenuItem *)sender
{
    UIPasteboard *pasteBoard=[UIPasteboard generalPasteboard];
    pasteBoard.string=self.title.text;
    NSLog(@"%@",pasteBoard.string);
//    [SVProgressHUD showSuccessWithStatus:@"复制成功"];
    [MBProgressHUD wj_showSuccess];
}

/**
 * 这个必须加， 因为加了这句，
 *才能让不具成为响应者的成为响应者
 *
 */
-(BOOL)canBecomeFirstResponder{
    return YES;
}


@end
