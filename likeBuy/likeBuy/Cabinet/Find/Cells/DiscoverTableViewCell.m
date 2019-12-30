//
//  DiscoverTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "DiscoverTableViewCell.h"

#import "RecommendModel.h"

#import "DiscoverCellTitleView.h"

#import "DiscoverCellContentView.h"

@interface DiscoverTableViewCell ()<DiscoverCellContentViewDelegate>

@property(nonatomic, strong)DiscoverCellTitleView *titleView;

@property(nonatomic, strong)DiscoverCellContentView *cellContentView;

@end

@implementation DiscoverTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        [self initUI];
    }
    return self;
}

-(void)initUI{
//    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView setBackgroundColor:WHITE];
    [self.contentView addSubview:self.titleView];
    [self.contentView addSubview:self.cellContentView];
    
}

#pragma mark - DiscoverCellContentViewDelegate
-(void)tapView{
    if ([self.delegate respondsToSelector:@selector(tapView:)]) {
        [self.delegate tapView:self.indexPath];
    }
}

-(void)tapGoodsImageWith:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(tapGoodsImageWithGoodsItem:andTableViewCellIndexPath:)]) {
        
        [self.delegate tapGoodsImageWithGoodsItem:indexPath andTableViewCellIndexPath:self.indexPath];
    }
}


#pragma mark - getter / setter

-(void)setModel:(RecommendModel *)model{
    [self initUI];
    [self.titleView setModel:model];
    [self.cellContentView setModel:model];
}

-(DiscoverCellTitleView *)titleView{
    if (_titleView == nil) {
        _titleView = [[DiscoverCellTitleView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 68)];
    }
    return _titleView;
}

-(DiscoverCellContentView *)cellContentView{
    if (_cellContentView == nil) {
        _cellContentView = [[DiscoverCellContentView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), ScreenWidth, 500 - 68)];
        [_cellContentView setDelegate:self];
    }
    return _cellContentView;
}


@end
