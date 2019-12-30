//
//  GoodsHeadTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/16.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "GoodsHeadTableViewCell.h"
#import "SDCycleScrollView.h"
#import "GoodsDetailModel.h"

@interface GoodsHeadTableViewCell()<SDCycleScrollViewDelegate>

@property (strong, nonatomic)  SDCycleScrollView *bannerView;

@property(nonatomic, strong)NSArray *imgArray;

@property (nonatomic,strong)NSArray  *dataSource;

@end


@implementation GoodsHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initUI{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView setBackgroundColor:WHITE];
    
    [self.contentView addSubview:self.bannerView];
    
    [self.bannerView setFrame:self.bounds];
    self.bannerView.delegate = self;
    self.bannerView.imageURLStringsGroup = self.imgArray;
    [self.bannerView setAutoScroll:NO];
    [self.bannerView setShowPageControl:YES];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    //[self.delegate pushToOtherViewControllerwithHomeItem:item];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
//    self.pageControl.currentPage = index;
}



#pragma  mark - getter / setter

-(void)setModel:(GoodsDetailModel *)model{
    _model = model;
    if (model.smallImages.count > 0) {
        self.dataSource = model.smallImages;
    }else{
        NSString *picUrl = model.pictUrl;
        if (picUrl != nil) {
            self.dataSource = [NSArray arrayWithObject:picUrl];
        }
    }
}

-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    self.imgArray = dataSource;
    [self initUI];
}

-(SDCycleScrollView *)bannerView{
    if (_bannerView == nil) {
        _bannerView = [[SDCycleScrollView alloc]initWithFrame:self.bounds];
        
    }
    return _bannerView;
}

@end
