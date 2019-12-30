//
//  QuestionCollectionViewCell.m
//  likeBuy
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "QuestionCollectionViewCell.h"

@interface QuestionCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation QuestionCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setStr:(NSString *)str{
    _str = str;
    [self.titleLabel setText:str];
}

@end
