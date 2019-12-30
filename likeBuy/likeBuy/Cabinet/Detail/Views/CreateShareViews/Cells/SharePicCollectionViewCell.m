//
//  SharePicCollectionViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/18.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "SharePicCollectionViewCell.h"


@interface SharePicCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

@end

@implementation SharePicCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.selectedImageView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectItem)];
 
    [self.selectedImageView addGestureRecognizer:tap];
}

-(void)selectItem{
    if ([self.delegate respondsToSelector:@selector(selectitem:)]) {
        [self.delegate selectitem:self.indexPath];
    }
}

-(void)setModel:(NSDictionary *)model{
    
    BOOL isSelect = [model[@"selected"] boolValue];
    
    if (isSelect == YES) {
        [self.selectedImageView setImage:[UIImage imageNamed:@"success_fill"]];
    }else{
        [self.selectedImageView setImage:[UIImage imageNamed:@"succs2"]];
    }
    
//    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model[@"img"]]];
    
    [self.bgImageView setImage:model[@"img"]];
}


@end
