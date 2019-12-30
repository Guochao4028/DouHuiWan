//
//  DeadlineTableViewCell.m
//  likeBuy
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "DeadlineTableViewCell.h"

#import "DeadCollectionViewCell.h"

#import "UIView+Tool.h"


static NSString *const kDeadCollectionViewCell = @"DeadCollectionViewCell";

@interface DeadlineTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

- (IBAction)updataAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIView *bgView;

//@property(nonatomic, strong)NSArray *temArray;

//@property(nonatomic, assign)NSInteger number;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *atMoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *tiemTitleLabel;


@end

@implementation DeadlineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
     [self.contentView setBackgroundColor:WHITE];
    
    [UIView addShadow:self.bgView];
    
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
    if ([self.delegate respondsToSelector:@selector(deadlineTableCell:tapGoodsItem:)] == YES) {
        [self.delegate deadlineTableCell:self tapGoodsItem:modle];
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((CGRectGetWidth(collectionView.bounds) - 14)/3, 155);
}


#pragma mark -  action

- (IBAction)updataAction:(UIButton *)sender {
//    NSInteger quantity = self.number *3;
//    if (quantity < self.dataList.count) {
//        NSInteger sum = self.dataList.count;
//        if ((sum - quantity) > 3) {
//            self.temArray = [self.dataList subarrayWithRange:NSMakeRange(quantity, 3)];
//        }else{
//            self.temArray = [self.dataList subarrayWithRange:NSMakeRange(quantity, (sum - quantity))];
//        }
//        self.number ++;
//    }else{
//        self.temArray = [self.dataList subarrayWithRange:NSMakeRange(0, 3)];
//        self.number = 1;
//    }
//
//    [self.collectionView reloadData];
//    [self.collectionView layoutIfNeeded];
//    [self animateCollection];
//    [self.collectionView reloadData];
    
    if ([self.delegate respondsToSelector:@selector(deadlineTableCell:tapChange:)] == YES) {
        [self.delegate deadlineTableCell:self tapChange:self.type];
    }
    
    
}

-(void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    
//    self.temArray = [dataList subarrayWithRange:NSMakeRange(0, 3)];
    
//    self.number = 1;
    
    [self.collectionView reloadData];
//    [self.collectionView reloadData];
//    [self.collectionView layoutIfNeeded];
//    [self animateCollection];
}

-(void)animateCollection{
    NSArray *cells = self.collectionView.visibleCells;
    
    for (UICollectionViewCell *cell in cells.objectEnumerator) {
        cell.alpha = 1.0f;
        cell.transform = CGAffineTransformMakeTranslation(ScreenWidth, 0);
        NSUInteger index = [cells indexOfObject:cell];
        [UIView animateWithDuration:0.2f delay:0.05*index usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
            cell.transform =  CGAffineTransformMakeTranslation(0, 0);
        } completion:nil];
    }
}

-(void)setTitleStr:(NSString *)titleStr{
    [self.titleLabel setText:titleStr];
}

-(void)setAtMoreStr:(NSString *)atMoreStr{
    [self.atMoreLabel setText:atMoreStr];
}

-(void)setTimeArray:(NSArray *)timeArray{
    NSMutableArray *time = [NSMutableArray array];
    
    NSDictionary *min = [timeArray firstObject];
    
    NSString *fistTime = min[@"title"];
    
    for (NSDictionary *tem in timeArray) {
        [time addObject:[NSString stringWithFormat:@"%@", tem[@"title"]]];
    }
    
    NSString *text = [time componentsJoinedByString:@"    "];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];

    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, fistTime.length)];
    
    [self.tiemTitleLabel setAttributedText:str];
    
    
}

@end
