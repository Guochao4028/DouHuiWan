//
//  GuessLikeTableViewCell.m
//  likeBuy
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "GuessLikeTableViewCell.h"

#import "DeadCollectionViewCell.h"

static NSString *const kDeadCollectionViewCell = @"DeadCollectionViewCell";

@interface GuessLikeTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation GuessLikeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     [self.contentView setBackgroundColor:WHITE];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
//    layout.sectionInset = UIEdgeInsetsMake(0, 30, 0, 30);
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DeadCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kDeadCollectionViewCell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mamrk - UICollectionViewDelegate & UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DeadCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:kDeadCollectionViewCell forIndexPath:indexPath];
    [cell setModel: self.dataList[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsModel *modle = self.dataList[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(guessLikeTableViewCell:tapGoodsItem:)] == YES) {
        [self.delegate guessLikeTableViewCell:self tapGoodsItem:modle];
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(107, 162);
}


-(void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    [self.collectionView reloadData];
}

@end
