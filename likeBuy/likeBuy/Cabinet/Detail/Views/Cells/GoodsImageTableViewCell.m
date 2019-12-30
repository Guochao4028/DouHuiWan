//
//  GoodsImageTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/17.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "GoodsImageTableViewCell.h"
#import "GoodsImageDetailsViewCollectionViewCell.h"

@interface GoodsImageTableViewCell()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *collectionDatas;


@end

@implementation GoodsImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
        
      
    }
    return self;
}

#pragma mark - UI
-(void)initUI{
    [self.contentView addSubview:self.collectionView];
    
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSoucreArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsImageDetailsViewCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell setImageURL:[self.dataSoucreArray objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - setter / getter
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat width = ScreenWidth - 66;
        CGFloat higth = 247;
        layout.itemSize = CGSizeMake(width, higth);
        layout.minimumLineSpacing = 24;
        layout.sectionInset = UIEdgeInsetsMake(14, 0, 0, 0);
        _collectionView = [[UICollectionView alloc]initWithFrame: self.contentView.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        [_collectionView registerClass:[GoodsImageDetailsViewCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView setScrollEnabled:YES];
    }
    return _collectionView;
}

-(void)setDataSoucreArray:(NSArray<NSString *> *)dataSoucreArray{
    _dataSoucreArray = dataSoucreArray;
    [self.collectionView setFrame:self.contentView.bounds];
    [self.collectionView reloadData];
}

@end
