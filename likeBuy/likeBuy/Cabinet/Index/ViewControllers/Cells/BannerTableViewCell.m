//
//  BannerTableViewCell.m
//  likeBuy
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "BannerTableViewCell.h"

#import "BannerModel.h"

#import <SDCycleScrollView.h>


@interface BannerTableViewCell ()<SDCycleScrollViewDelegate>

@property (strong, nonatomic)  SDCycleScrollView *bannerView;

@property(nonatomic, strong)NSArray *imgArray;

@end

@implementation BannerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//         [self.contentView setBackgroundColor:WHITE];
        [self.contentView setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)initUI{
    [self.contentView addSubview:self.bannerView];
    self.bannerView.imageURLStringsGroup = self.imgArray;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    //[self.delegate pushToOtherViewControllerwithHomeItem:item];
    
    if ([self.delegate respondsToSelector:@selector(pushToOtherViewControllerwithHomeItem:)]) {
        [self.delegate pushToOtherViewControllerwithHomeItem:self.dataSource[index]];
    }
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
}

-(void)initData{
    NSMutableArray *temList = [NSMutableArray array];
    for (BannerModel *banner in self.dataSource) {
        [temList addObject:banner.imgUrl];
    }
    self.imgArray = temList;
}

//根据偏移量计算设置banner背景颜色
- (void)handelBannerBgColorWithOffset:(NSInteger )offset {
    
    if (1 == self.dataSource.count) return;
    NSInteger offsetCurrent = offset % (int)self.bannerView.bounds.size.width ;
    float rate = offsetCurrent / self.bannerView.bounds.size.width ;
    NSInteger currentPage = offset / (int)self.bannerView.bounds.size.width;
    UIColor *startPageColor;
    UIColor *endPageColor;
    if (currentPage == self.dataSource.count - 1) {
        
        BannerModel *startModel = self.dataSource[currentPage];
        startPageColor = [UIColor colorWithHexString:startModel.colour];
        BannerModel *endModel = self.dataSource[currentPage];
        endPageColor = [UIColor colorWithHexString:endModel.colour];
    } else {
        if (currentPage  == self.dataSource.count) {
            return;
        }
        BannerModel *startModel = self.dataSource[currentPage];
        BannerModel *endModel = self.dataSource[currentPage+1];
        
        startPageColor = [UIColor colorWithHexString:startModel.colour];
        endPageColor = [UIColor colorWithHexString:endModel.colour];
        
    }
    UIColor *currentToLastColor = [UIColor getColorWithColor:startPageColor andCoe:rate andEndColor:endPageColor];
        
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATIONCHANGE object:nil userInfo:@{@"bgColor":currentToLastColor}];
}

#pragma mark - setter / getter

-(void)setDataSource:(NSArray<BannerModel *> *)dataSource{
    _dataSource = dataSource;
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    [self setBackgroundColor:[UIColor clearColor]];
    
    if (dataSource.count > 0) {
        BannerModel *model = dataSource[0];
        UIColor *bgColor = [UIColor colorWithHexString:model.colour];
         [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATIONCHANGE object:nil userInfo:@{@"bgColor":bgColor}];
    }
    
    [self initData];
    [self initUI];
    
}

-(SDCycleScrollView *)bannerView{
    if (_bannerView == nil) {
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(20, 15, ScreenWidth - 40, 144) delegate:self placeholderImage:nil];
        _bannerView.layer.masksToBounds = YES;
        _bannerView.layer.cornerRadius = 8;
        _bannerView.hidesForSinglePage = YES;
        _bannerView.showPageControl = YES;
        _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        
        __weak typeof(self) weakSelf = self;;
        _bannerView.cycleScrollViewBlock = ^(NSInteger offset) {
            [weakSelf handelBannerBgColorWithOffset:offset];
        };
    }
    return _bannerView;
}


@end
