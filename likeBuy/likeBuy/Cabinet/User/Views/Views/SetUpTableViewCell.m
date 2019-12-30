//
//  SetUpTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "SetUpTableViewCell.h"

@interface SetUpTableViewCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *returnImageView;
@property (weak, nonatomic) IBOutlet UIImageView *heardImageView;
@property (weak, nonatomic) IBOutlet UITextField *weixinTextField;
@property (weak, nonatomic) IBOutlet UILabel *neirongLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *neirongR;

@end

@implementation SetUpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.contentView setBackgroundColor:WHITE];
    
    self.heardImageView.layer.cornerRadius = 28;
    self.heardImageView.clipsToBounds = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.weixinTextField setDelegate:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setModel:(NSDictionary *)model{
    _model = model;
    //@"title":@"头像", @"isReturn":@"1", @"isword":@"0", @"isImageView":@"1", @"isTextF":@"0"
    
    [self.titleLabel setText:model[@"title"]];
    BOOL isReturn = [model[@"isReturn"] boolValue];
    BOOL isword = [model[@"isword"] boolValue];
    BOOL isImageView = [model[@"isImageView"] boolValue];
    BOOL isTextF = [model[@"isTextF"] boolValue];
    
    if (isReturn == NO) {
        [self.returnImageView setHidden:YES];
    }
    if (isword == NO) {
        [self.neirongLabel setHidden:YES];
    }
    
    if (isImageView == NO) {
        [self.heardImageView setHidden:YES];
    }
    
    if (isTextF == NO) {
        [self.weixinTextField setHidden:YES];
    }
    
    if (isword == YES) {
        [self.neirongLabel setHidden:NO];
        self.neirongR.constant = 15;
        if (isReturn == YES) {
            [self.returnImageView setHidden:NO];
            self.neirongR.constant = 31;
        }
    }
}

-(void)setUser:(User *)user{
    
    NSString *str = self.model[@"type"];
    
    NSInteger type = [str integerValue];
    
    switch (type) {
        case 0:{
            if (user.avatar.length > 0) {
                [self.heardImageView sd_setImageWithURL:[NSURL URLWithString:user.avatar]];
            }else{
                [self.heardImageView setImage:[UIImage imageNamed:@"121"]];
            }
        }
            break;
        case 1:{
            [self.neirongLabel setText:user.shortName];
        }
            break;
        case 2:{
        }
            break;
        case 3:{
            [self.neirongLabel setText:user.telephone];
        }
            break;
            
        case 4:{
            NSString *str = user.wxPubOpenId;
            if (str.length > 0 || str != nil) {
                [self.neirongLabel setText:@"已绑定"];
            }else{
                [self.neirongLabel setText:@"未绑定"];
            }
        }
            break;
        case 6:{
            
            NSUInteger tmpSize = [[SDImageCache sharedImageCache] totalDiskSize];
            
            [self.neirongLabel setText:[NSString stringWithFormat:@"%.2f M",tmpSize /(1024.f*1024.f)]];
        }
            break;
        case 8:{
            
            [self.neirongLabel setText:@"v1.0"];
        }
            break;
        default:
            break;
    }
}

-(void)setImage:(UIImage *)image{
    
    if (image != nil) {
        NSString *str = self.model[@"type"];
        
        NSInteger type = [str integerValue];
        if (type == 0) {
            
            [self.heardImageView setImage:image];
        }
        
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}


@end
