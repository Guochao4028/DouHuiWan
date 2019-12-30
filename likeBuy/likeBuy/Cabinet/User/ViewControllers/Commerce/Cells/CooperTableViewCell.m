//
//  CooperTableViewCell.m
//  likeBuy
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "CooperTableViewCell.h"
#import "NSString+Tool.h"

@interface CooperTableViewCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *biaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *wordTextField;

@end

@implementation CooperTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.biaoLabel setHidden:YES];
    
    self.backgroundColor = WHITE;
    self.contentView.backgroundColor = WHITE;
    
//    self.wordTextField.attributedPlaceholder = [NSString attributedPlaceholder:@"请输入手机号" inView:self.wordTextField];
    
    [self.wordTextField setDelegate:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textField : %@",textField.text);
    
    if ([self.delegate respondsToSelector:@selector(cooperCell:loction:endInput:)]) {
        [self.delegate cooperCell:self loction:self.indexPathRow endInput:textField.text];
    }
    
}

#pragma mark - setter / getter

-(void)setMdoel:(NSDictionary *)mdoel{
    NSString *isXingStr = mdoel[@"isXing"];
//    NSString *isSeledStr = mdoel[@"isSeled"];
    
    BOOL isXing = [isXingStr boolValue];
//    BOOL isSeled = [isSeledStr boolValue];
    
    [self.biaoLabel setHidden:!isXing];
    
    [self.titleLabel setText:mdoel[@"name"]];
    
    self.wordTextField.attributedPlaceholder = [NSString attributedPlaceholder:mdoel[@"placeholder"] inView:self.wordTextField];
}








@end
