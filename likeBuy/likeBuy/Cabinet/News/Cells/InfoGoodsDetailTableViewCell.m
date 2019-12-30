//
//  InfoGoodsDetailTableViewCell.m
//  likeBuy
//
//  Created by mac on 2019/12/12.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "InfoGoodsDetailTableViewCell.h"
#import "InfoModel.h"

@interface InfoGoodsDetailTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *goodsView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsNeiRongLabel;


@end

@implementation InfoGoodsDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.goodsView.layer.masksToBounds = YES;
    self.goodsView.layer.cornerRadius = 8;
    
    self.goodsImageView.layer.masksToBounds = YES;
    self.goodsImageView.layer.cornerRadius = 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDataModel:(InfoModel *)dataModel{
    [self.timeLabel setText:dataModel.crTime];
    
    [self.goodsTitleLabel setText:dataModel.title];
    
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
      
    NSString *message = dataModel.message;
      
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    //设置富文本
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    //设置段落格式
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 7;
    para.paragraphSpacing = 10;
    [attStr addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, attStr.length)];
    [attStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attStr.length)];
      
    self.goodsNeiRongLabel.attributedText = attStr;
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.url]];
}

@end
