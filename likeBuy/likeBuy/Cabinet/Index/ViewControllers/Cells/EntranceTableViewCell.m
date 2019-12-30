//
//  EntranceTableViewCell.m
//  likeBuy
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "EntranceTableViewCell.h"

#import "ItemCollectionViewCell.h"

static NSString *const kItemCollectionViewCellIdentifier = @"ItemCollectionViewCell";

@interface EntranceTableViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation EntranceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.contentView setBackgroundColor:WHITE];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView setBackgroundColor:WHITE];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ItemCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kItemCollectionViewCellIdentifier];
    
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
    CGFloat width = ScreenWidth  - 40;
    return CGSizeMake(width / 5, 67);
//    return  CGSizeMake(150, 150);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ItemCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:kItemCollectionViewCellIdentifier forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(tableViewCell:selectItem:)]){
        [self.delegate tableViewCell:self selectItem:(indexPath.row +101)];
    }
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    [self.collectionView reloadData];
}

@end
