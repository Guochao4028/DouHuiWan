//
//  DiscoverCollectionViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "DiscoverCollectionViewCell.h"

@interface DiscoverCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@end

@implementation DiscoverCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setPicStr:(NSString *)picStr{
    _picStr = picStr;
    NSURL *url = [NSURL URLWithString:picStr];
    [self.picImageView sd_setImageWithURL:url];
    
}

@end
