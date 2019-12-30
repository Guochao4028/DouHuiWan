//
//  GoodsImageDetailsViewCollectionViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/17.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "GoodsImageDetailsViewCollectionViewCell.h"

@interface GoodsImageDetailsViewCollectionViewCell ()

@property(nonatomic, strong)UIImageView *goodsImageView;

@end

@implementation GoodsImageDetailsViewCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self.goodsImageView setFrame:self.contentView.bounds];
    [self.contentView addSubview:self.goodsImageView];
}

-(void)setImageURL:(NSString *)imageURL{
    
    NSURL *url = [NSURL URLWithString:imageURL];
    
    if (url != nil) {
        
        
        [self.goodsImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultChart"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            if (cacheType == SDImageCacheTypeNone) {
//                [UIFactory addAnimationWithLayer:self.goodsImageView.layer];
//            }
        }];
        //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //
        //            UIImageView *temp = [[UIImageView alloc]init];
        //            [temp sd_setImageWithURL:url];
        //
        //            if (temp.image != nil) {
        //                dispatch_async(dispatch_get_main_queue(), ^{
        //                    [self.goodsImageView setImage:temp.image];
        //                });
        //            }
        //        });
    }
}

#pragma mark - setter

-(UIImageView *)goodsImageView{
    
    if (_goodsImageView == nil) {
        _goodsImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
        _goodsImageView.layer.masksToBounds = YES;
    }
    
    return _goodsImageView;
}

@end
