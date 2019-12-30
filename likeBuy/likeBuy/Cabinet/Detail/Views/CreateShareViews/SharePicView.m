//
//  SharePicView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/18.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "SharePicView.h"

#import "SharePicCollectionViewCell.h"


#define kSharePicCollectionViewCell @"SharePicCollectionViewCell"

@interface SharePicView()<UICollectionViewDelegate, UICollectionViewDataSource, SharePicCollectionViewCellDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;
@property(nonatomic, strong)NSArray *imageList;

@end

@implementation SharePicView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"SharePicView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.contentView];
    [self.contentView setFrame:self.bounds];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SharePicCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kSharePicCollectionViewCell];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    [self.collectionView setShowsHorizontalScrollIndicator:YES];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}

#pragma mark - SharePicCollectionViewCellDelegate
-(void)selectitem:(NSIndexPath *)indexPath{
    NSMutableDictionary *dic = self.imageList[indexPath.row];
    BOOL isChange =  [dic[@"isChange"] boolValue];
    if (isChange == NO) {
        return;
    }
    
    BOOL isSelect = [dic[@"selected"] boolValue];
    [dic setObject:[NSString stringWithFormat:@"%d", !isSelect] forKey:@"selected"];
    [self.collectionView reloadData];
    
    
    NSInteger i = 0;
    for (NSMutableDictionary *dic in self.imageList) {
        BOOL isSelect = [dic[@"selected"] boolValue];
        if (isSelect == YES) {
            i ++;
        }
    }
    [self.selectLabel setText:[NSString stringWithFormat:@"已选%ld张",i]];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SharePicCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:kSharePicCollectionViewCell forIndexPath:indexPath];
    [cell setDelegate:self];
    
    [cell setIndexPath:indexPath];
    
    [cell setModel:self.imageList[indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(tapImage:)]) {
        [self.delegate tapImage:indexPath];
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(94, 167);
}


#pragma mark - setter / getter

-(void)setDataSoucreArray:(NSArray<UIImage *> *)dataSoucreArray{
    _dataSoucreArray = dataSoucreArray;
    NSMutableArray *tem = [NSMutableArray array];
    for (UIImage *image in dataSoucreArray) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:image forKey:@"img"];
        [dic setObject:@"0" forKey:@"selected"];
        [dic setObject:@"1" forKey:@"isChange"];
        [tem addObject:dic];
    }
    
    NSMutableDictionary *dic = [tem objectAtIndex:0];
    [dic setObject:@"0" forKey:@"isChange"];
    [dic setObject:@"1" forKey:@"selected"];
    
    [self.selectLabel setText:@"已选1张"];
    
    self.imageList = [NSArray arrayWithArray:tem];
    
     [self.collectionView reloadData];
}

-(NSArray *)selectImgList{
    
    NSMutableArray *imgArray = [NSMutableArray array];
    for (NSMutableDictionary *dic in self.imageList) {
        BOOL isSelect = [dic[@"selected"] boolValue];
        if (isSelect == YES) {
           [imgArray addObject:dic[@"img"]];
        }
    }
    
    return imgArray;
}



@end
