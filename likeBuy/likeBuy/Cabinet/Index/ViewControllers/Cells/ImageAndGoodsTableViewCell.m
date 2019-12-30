//
//  ImageAndGoodsTableViewCell.m
//  likeBuy
//
//  Created by mac on 2019/10/23.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "ImageAndGoodsTableViewCell.h"
#import "UIView+Tool.h"
#import "DeadCollectionViewCell.h"


static NSString *const kDeadCollectionViewCell = @"DeadCollectionViewCell";


@interface ImageAndGoodsTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *substanceView;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ImageAndGoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setBackgroundColor:[UIColor whiteColor]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    
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
    //return self.imageList.count;
    return self.dataList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DeadCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:kDeadCollectionViewCell forIndexPath:indexPath];
    
    [cell setModel:self.dataList[indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsModel *modle = self.dataList[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(imageAndGoodsTableViewCell:tapGoodsItem:)] == YES) {
        [self.delegate imageAndGoodsTableViewCell:self tapGoodsItem:modle];
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((CGRectGetWidth(collectionView.bounds) - 14)/3, 155);
}


#pragma mark - getter / setter

-(void)setTopType:(NSInteger)topType{
    UIImage *topImage;
    if (topType == 1) {
        topImage = [UIImage imageNamed:@"pinpai"];
    }else if(topType == 2){
        topImage = [UIImage imageNamed:@"shishi"];
    }
    [self.topImageView setImage:topImage];
}

-(void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    [self.collectionView reloadData];
}



@end
