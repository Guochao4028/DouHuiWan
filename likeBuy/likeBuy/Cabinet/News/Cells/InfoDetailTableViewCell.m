//
//  InfoDetailTableViewCell.m
//  likeBuy
//
//  Created by mac on 2019/10/27.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "InfoDetailTableViewCell.h"
#import "InfoModel.h"

@interface InfoDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *neirongLabel;

@end

@implementation InfoDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDataModel:(InfoModel *)dataModel{
    
    [self.titleLabel setText:dataModel.title];
    
    
//    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[dataModel.message  dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//    self.neirongLabel.attributedText = attrStr;
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
    
        self.neirongLabel.attributedText = attStr;
    
//    [self.neirongLabel setText:dataModel.message];
    
    // 实例化NSDateFormatter
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    // 设置日期格式
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // NSDate形式的日期
    NSDate *date =[formatter1 dateFromString:dataModel.crTime];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"HH:mm"];
    NSString *dateString2 = [formatter2 stringFromDate:date ];
    NSLog(@"%@",dateString2);
    
    
    
    [self.timeLabel setText:dateString2];
    
}

@end
