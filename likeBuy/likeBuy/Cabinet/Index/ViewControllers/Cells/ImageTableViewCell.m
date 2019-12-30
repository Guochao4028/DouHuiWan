//
//  ImageTableViewCell.m
//  likeBuy
//
//  Created by mac on 2019/12/4.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "ImageTableViewCell.h"

@interface ImageTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

@end

@implementation ImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setBackgroundColor:[UIColor whiteColor]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    if ([self.imageName isEqualToString:@"0YuanBanner"]) {
        if ([self.delegate respondsToSelector:@selector(tapImageTableViewCell)]) {
            [self.delegate tapImageTableViewCell];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(jumpPage:)]) {
            [self.delegate jumpPage:self.imageName];
        }
    }
    
}

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    UIImage *image = [UIImage imageNamed:imageName];
    [self.cellImageView setImage:image];
}

@end
