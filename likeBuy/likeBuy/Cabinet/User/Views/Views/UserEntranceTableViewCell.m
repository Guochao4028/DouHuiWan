//
//  UserEntranceTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "UserEntranceTableViewCell.h"

@interface UserEntranceTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *ordeView;
@property (weak, nonatomic) IBOutlet UIView *qianbaoView;
@property (weak, nonatomic) IBOutlet UIView *shouyiView;

@end


@implementation UserEntranceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UITapGestureRecognizer *tapOrde = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOrde)];
    [self.ordeView addGestureRecognizer:tapOrde];
    
    UITapGestureRecognizer *tapQianban = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapQianban)];
    [self.qianbaoView addGestureRecognizer:tapQianban];
    
    UITapGestureRecognizer *tapShouyiView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShouyiView)];
    [self.shouyiView addGestureRecognizer:tapShouyiView];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)tapOrde{
    if([self.delegate respondsToSelector:@selector(tapOrde)]){
        [self.delegate tapOrde];
    }
}

-(void)tapQianban{
    if([self.delegate respondsToSelector:@selector(tapQianban)]){
        [self.delegate tapQianban];
    }
}

-(void)tapShouyiView{
    if([self.delegate respondsToSelector:@selector(tapShouyiView)]){
        [self.delegate tapShouyiView];
    }
}

@end
