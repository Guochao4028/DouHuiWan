//
//  DiscoverCellContentView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "DiscoverCellContentView.h"

#import "RecommendModel.h"

#import "DiscoverCellRemarkView.h"

#import "DiscoverCollectionViewCell.h"



@interface DiscoverCellContentView ()<DiscoverCellRemarkViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)UILabel *goodsContentLabel;

@property(nonatomic, strong)UIView *contentView;

@property(nonatomic, strong)DiscoverCellRemarkView *remarkView;

@property(nonatomic, assign)CGFloat maxImageY;

@property(nonatomic, strong)NSMutableArray *saveArray;

@property(nonatomic, strong)UICollectionView *collectionView;

@end

@implementation DiscoverCellContentView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
    [self.contentView addSubview:self.goodsContentLabel];
}



#pragma mark - private

-(void)sudokuWithMargin:(CGFloat)margin width:(CGFloat)width height:(CGFloat)height{
    
    
    if (self.saveArray.count > 0) {
        for (int i = 0; i < self.saveArray.count; i++) {
            UIImageView *tem = self.saveArray[i];
            [tem removeFromSuperview];
            [self.saveArray removeObject:tem];
        }
    }
    
    for (int i = 0; i < self.model.pics.count ; i++) {
        int row = i/3;
        int col = i%3;
        UIImageView * imageView = [[UIImageView alloc]init];
        
        imageView.frame = CGRectMake(70+col*(width+margin), self.goodsContentLabel.mj_h +20+row*(height+margin), width, height);
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.pics[i]]];
        
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        
        [self.saveArray addObject:imageView];
        
        self.maxImageY = CGRectGetMaxY(imageView.frame);
        [self.contentView addSubview:imageView];
    }
}

#pragma mark - DiscoverCellRemarkViewDelegate
-(void)tapView{
    if ([self.delegate respondsToSelector:@selector(tapView)]) {
        [self.delegate tapView];
    }
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.pics.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    [cell setPicStr:self.model.pics[indexPath.row]];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate  respondsToSelector:@selector(tapGoodsImageWith:)]) {
        
        [self.delegate tapGoodsImageWith:indexPath];
    }
}

#pragma mark - setter / getter

-(UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _contentView;
}

-(UILabel *)goodsContentLabel{
    if (_goodsContentLabel == nil) {
        _goodsContentLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [_goodsContentLabel setFont:[UIFont fontWithName:RegularFont size:14]];
        [_goodsContentLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
        [_goodsContentLabel setNumberOfLines:0];
        
        [_goodsContentLabel setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
        
        [self.goodsContentLabel addGestureRecognizer:tap];
        
    }
    return _goodsContentLabel;
}

-(DiscoverCellRemarkView *)remarkView{
    if (_remarkView == nil) {
        _remarkView = [[DiscoverCellRemarkView alloc]initWithFrame:CGRectZero];
        [_remarkView setDelegate:self];
    }
    return _remarkView;
}

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat width = 75 * WIDTHTPROPROTION;
        CGFloat higth = 75 * WIDTHTPROPROTION;
        layout.itemSize = CGSizeMake(width, higth);
        layout.minimumLineSpacing = 10;
        
        _collectionView = [[UICollectionView alloc]initWithFrame: CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DiscoverCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView setScrollEnabled:YES];
    }
    return _collectionView;
}

-(void)setModel:(RecommendModel *)model{
    _model = model;
    
    CGFloat labelWidth = (ScreenWidth - 70 - 21);
    
    [self.goodsContentLabel setFrame:CGRectMake(70, 10, labelWidth, MAXFLOAT)];
    
    NSString *displayStr = [model.cText stringByAppendingString:@"\n"];
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[displayStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
 
    self.goodsContentLabel.attributedText = attrStr;
    
    
    [self.goodsContentLabel setFont:[UIFont fontWithName:RegularFont size:14]];
    
    //5.计算富文本的size
    CGSize size = [attrStr boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT)options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics
                                        context:nil].size;
    
    [self.goodsContentLabel sizeToFit];
    /* 最后的10 是自己加 的 */
    self.goodsContentLabel.mj_h = size.height +20 + 15 + 10;
    
    if (model.pics.count > 1) {
        CGFloat imageH = 0;
        for (int i = 0; i < model.pics.count ; i++) {
            int row = i/3;
            imageH = 20 +row *((75* WIDTHTPROPROTION)+10)+(75* WIDTHTPROPROTION);
        }
        
        [self addSubview:self.collectionView];
        
        [self.collectionView setFrame:CGRectMake(69, CGRectGetMaxY(self.goodsContentLabel.frame)+10, (ScreenWidth - 69 - 34), imageH)];
        self.maxImageY = CGRectGetMaxY(self.collectionView.frame);
        
        [self.collectionView reloadData];
        
    }else{
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(70, self.goodsContentLabel.mj_h + 20, 178, 178)];
        
        [self.contentView addSubview:imageView];
        
        self.maxImageY = CGRectGetMaxY(imageView.frame);
    }
    
    [self.contentView addSubview: self.remarkView];
    
    
    [self.remarkView setFrame:CGRectMake(70, self.maxImageY +10, ScreenWidth - 70 - 21, 109)];
    
    
}

-(NSMutableArray *)saveArray{
    if (_saveArray == nil) {
        _saveArray = [NSMutableArray array];
    }
    return _saveArray;
}


@end
