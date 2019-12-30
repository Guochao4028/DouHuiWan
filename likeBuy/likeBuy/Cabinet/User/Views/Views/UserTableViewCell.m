//
//  UserTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "UserTableViewCell.h"



@interface UserTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *noLoginView;

@property (weak, nonatomic) IBOutlet UIView *loginView;

@property (weak, nonatomic) IBOutlet UIImageView *noLoginHeardImageView;

@property (weak, nonatomic) IBOutlet UIImageView *loginHeardImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yaoqingLabel;
@property (weak, nonatomic) IBOutlet UILabel *leveLabel;
@property (weak, nonatomic) IBOutlet UIView *fuzhiView;

@end


@implementation UserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.loginView setHidden:YES];
    
    self.noLoginHeardImageView.layer.cornerRadius = 23;
    self.loginHeardImageView.layer.cornerRadius = 23;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(User *)model{
    _model = model;
    if (model != nil) {
        [self.loginView setHidden:NO];
        [self.noLoginView setHidden:YES];
    }else{
        [self.loginView setHidden:YES];
        [self.noLoginView setHidden:NO];
    }
    
    [self.titleLabel setText:model.shortName];
    
    
    [self.loginHeardImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]placeholderImage:[UIImage imageNamed:@"121"]];
    [self.yaoqingLabel setText:[NSString stringWithFormat:@"邀请码：%@",model.selfResqCode]];
    [self.leveLabel setText:model.grade];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(copyAction)];;
    [self.fuzhiView addGestureRecognizer:tap];
    
}

-(void)copyAction{
    
    if(self.model.selfResqCode.length > 1){
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.model.selfResqCode;
//        [SVProgressHUD showSuccessWithStatus:@"复制成功"];
        [MBProgressHUD showSuccessMessage:@"复制成功"];
        
    }else{
//        [SVProgressHUD showSuccessWithStatus:@"复制失败"];
        [MBProgressHUD showSuccessMessage:@"复制失败"];
    }
    
}

@end
