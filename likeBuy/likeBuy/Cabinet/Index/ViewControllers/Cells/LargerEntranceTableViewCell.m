//
//  LargerEntranceTableViewCell.m
//  likeBuy
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "LargerEntranceTableViewCell.h"

#import "UIView+Tool.h"

#import "UIImage+Tool.h"

#import "GoodsModel.h"

@interface LargerEntranceTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *baokuanView;
@property (weak, nonatomic) IBOutlet UIView *baicaiView;
@property (weak, nonatomic) IBOutlet UIImageView *top1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *top2ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *baicaiImageView;
@property (weak, nonatomic) IBOutlet UIImageView *baicai2ImageView;




@end

@implementation LargerEntranceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
     [self.contentView setBackgroundColor:WHITE];
    
    [self.baokuanView setUserInteractionEnabled:YES];
    [self.baicaiView setUserInteractionEnabled:YES];
    
    [UIView addShadow:self.baokuanView];
    
    [UIView addShadow:self.baicaiView];
    
    UITapGestureRecognizer *baokuanTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapItmeAction:)];
    [self.baokuanView addGestureRecognizer:baokuanTap];
    
    UITapGestureRecognizer *baicaiTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapItmeAction:)];
    [self.baicaiView addGestureRecognizer:baicaiTap];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - action
- (void)tapItmeAction:(UITapGestureRecognizer *)sender {
    UIView *view = sender.view;
    if([self.delegate respondsToSelector:@selector(tableViewCell:tapItem:)]){
        [self.delegate tableViewCell:self tapItem:view.tag];
    }
}

#pragma mark - getter / setter

-(void)setBaiCaiArray:(NSArray *)baiCaiArray{
    _baiCaiArray = baiCaiArray;
    
    if (baiCaiArray != nil) {
        if (baiCaiArray.count > 2) {
            GoodsModel *tem1 = baiCaiArray[0];
            NSString *tem1Str = tem1.pictUrl;
            [self.baicaiImageView sd_setImageWithURL:[NSURL URLWithString:tem1Str]];
            
            
            GoodsModel *tem2 = baiCaiArray[1];
            NSString *tem2Str = tem2.pictUrl;
            [self.baicai2ImageView  sd_setImageWithURL:[NSURL URLWithString:tem2Str]];
        }
    }
}

-(void)setTop100Array:(NSArray *)top100Array{
    _top100Array = top100Array;
    
    if (top100Array != nil) {
        if (top100Array.count > 2) {
            GoodsModel *tem1 = top100Array[0];
            NSString *tem1Str = tem1.pictUrl;
            [self.top1ImageView sd_setImageWithURL:[NSURL URLWithString:tem1Str]];
            
            GoodsModel *tem2 = top100Array[1];
            NSString *tem2Str = tem2.pictUrl;
            [self.top2ImageView  sd_setImageWithURL:[NSURL URLWithString:tem2Str]];
        }
    }
    
}


@end
