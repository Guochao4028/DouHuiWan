//
//  InfoTableViewCell.m
//  likeBuy
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "InfoTableViewCell.h"

#import "InfoModel.h"

@interface InfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *neirongLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIView *redPoint;

@end

@implementation InfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setBackgroundColor:WHITE];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.redPoint.layer setMasksToBounds:YES];
    self.redPoint.layer.cornerRadius = 4;
    
    [self.redPoint setHidden:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setDataModel:(NSArray *)dataModel{
    
    NSDictionary *dic = [dataModel firstObject];
    
    NSArray *allKeys = [dic allKeys];
    NSString *key = [allKeys firstObject];
    NSArray *itemArray = dic[key];
    
    
    InfoModel *model = [itemArray firstObject];
    
     UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
      
      NSString *message = model.message;
      
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
      
    self.neirongLabel.attributedText = attStr;
    [self.timeLabel setText:model.crTime];
    
    
}

-(void)setTitle:(NSString *)title{
    _title = title;
    
     NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[title  dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont fontWithName:MediumFont size:16]} documentAttributes:nil error:nil];
    self.titleLabel.attributedText = attrStr;
    
    
//    [self.titleLabel setText:title];
}

-(void)setIcon:(NSString *)icon{
    _icon = icon;
    [self.iconImageView setImage:[UIImage imageNamed:icon]];
}

-(void)setIsRedView:(BOOL)isRedView{
    
    [self.redPoint setHidden:!isRedView];
}

@end
