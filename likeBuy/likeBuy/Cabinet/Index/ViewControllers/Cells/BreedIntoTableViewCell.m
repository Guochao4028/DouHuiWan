//
//  BreedIntoTableViewCell.m
//  likeBuy
//
//  Created by mac on 2019/10/22.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "BreedIntoTableViewCell.h"

#import "CategotyItemCollectionViewCell.h"

#import "CategoryModel.h"

#import "CategorySecondClassModel.h"

#define kCellIdentifier_CollectionView @"CollectionViewCell"

@interface BreedIntoTableViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation BreedIntoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setBackgroundColor:[UIColor whiteColor]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CategotyItemCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kCellIdentifier_CollectionView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = ScreenWidth  - 80;
    return CGSizeMake(width / 3-2, 100);
//    return  CGSizeMake(150, 150);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategotyItemCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_CollectionView forIndexPath:indexPath];
    
    cell.dataSource = self.dataArray[indexPath.row];
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(jumpClassify:)]) {
        [self.delegate jumpClassify:self.dataArray[indexPath.row]];
    }
}

#pragma mark - setter / getter
-(void)setDataArray:(NSArray<CategorySecondClassModel *> *)dataArray{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

@end
