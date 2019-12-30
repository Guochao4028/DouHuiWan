//
//  GoodsDetailView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/16.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "GoodsDetailView.h"
#import "GoodsDetailModel.h"
#import "GoodsHeadTableViewCell.h"
#import "GoodsInfoTableViewCell.h"
#import "StoreInfoTableViewCell.h"
#import "GoodsImageTitleTableViewCell.h"
#import "GoodsImageTableViewCell.h"

static NSString *const kGoodsHeadTableViewCellIdentifier = @"GoodsHeadTableViewCell";
static NSString *const kGoodsInfoTableViewCellIdentifier = @"GoodsInfoTableViewCell";
static NSString *const kStoreInfoTableViewCellIdentifier = @"StoreInfoTableViewCell";
static NSString *const kGoodsImageTitleTableViewCellIdentifier = @"GoodsImageTitleTableViewCell";

static NSString *const kGoodsImageTableViewCellIdentifier = @"GoodsImageTableViewCell";


@interface GoodsDetailView()<UITableViewDelegate, UITableViewDataSource, GoodsInfoTableViewCellDelegate>

@property(nonatomic, strong)UITableView *tableView;


@end

@implementation GoodsDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.tableView];
}

#pragma mark -  UITableViewDelegate & UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
        return 10;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 0.01;
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.layer.backgroundColor = [UIColor colorWithRed:250/255.0 green:251/255.0 blue:253/255.0 alpha:1.0].CGColor;
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if(section == 1) {
        return 1;
    }else{
        
        return 2;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tableViewH = 0;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                //banner
                tableViewH = 360;
            }
                break;
            case 1:
            {
                
                tableViewH = 209;
            }
                break;
        }
    }else if(indexPath.section == 1){
        tableViewH = 93;
    }else{
        if(indexPath.row == 0){
            tableViewH = 51;
        }else{
            tableViewH = 295 * self.model.smallImages.count;
        }
        
    }

    return tableViewH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;// = [[UITableViewCell alloc]init];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                //banner
                GoodsHeadTableViewCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:kGoodsHeadTableViewCellIdentifier forIndexPath:indexPath];
                if(self.model != nil){
                    bannerCell.model = self.model;
                }
                
                cell = bannerCell;
            }
                break;
            case 1:{
                GoodsInfoTableViewCell *goodsInfoCell = [tableView dequeueReusableCellWithIdentifier:kGoodsInfoTableViewCellIdentifier forIndexPath:indexPath];
                if(self.model != nil){
                    [goodsInfoCell setModel:self.model];
                }
                
                [goodsInfoCell setDelegate:self];
                cell = goodsInfoCell;
                
            }
                break;
        }
    }else if(indexPath.section == 1){
       
        StoreInfoTableViewCell *storeInfoCell = [tableView dequeueReusableCellWithIdentifier:kStoreInfoTableViewCellIdentifier forIndexPath:indexPath];
        if(self.model != nil){
            [storeInfoCell setModel:self.model];
        }
        
        cell = storeInfoCell;
    }else{
        if(indexPath.row == 0){
            GoodsImageTitleTableViewCell *goodsImageTitleCell = [tableView dequeueReusableCellWithIdentifier:kGoodsImageTitleTableViewCellIdentifier forIndexPath:indexPath];
            cell = goodsImageTitleCell;
        }else{
            GoodsImageTableViewCell *goodsImageTableViewCell = [tableView dequeueReusableCellWithIdentifier:kGoodsImageTableViewCellIdentifier forIndexPath:indexPath];
            
            if(self.model != nil){
                goodsImageTableViewCell.dataSoucreArray = self.model.smallImages;
            }
            cell = goodsImageTableViewCell;
        }
    }
    return cell;
}


#pragma mark - GoodsInfoTableViewCellDelegate
-(void)tapGoodsInfoView{
    if ([self.delegate respondsToSelector:@selector(tapGoodsInfoView)]) {
        [self.delegate tapGoodsInfoView];
    }
}

#pragma mark - getter / setter

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView  = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setBackgroundColor:[UIColor whiteColor]];
        
        [_tableView registerClass:[GoodsHeadTableViewCell class] forCellReuseIdentifier:kGoodsHeadTableViewCellIdentifier];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:kGoodsInfoTableViewCellIdentifier];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([StoreInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:kStoreInfoTableViewCellIdentifier];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([StoreInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:kStoreInfoTableViewCellIdentifier];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsImageTitleTableViewCell class]) bundle:nil] forCellReuseIdentifier:kGoodsImageTitleTableViewCellIdentifier];
        
        [_tableView registerClass:[GoodsImageTableViewCell class] forCellReuseIdentifier:kGoodsImageTableViewCellIdentifier];
        
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

-(void)setModel:(GoodsDetailModel *)model{
    _model = model;
    [self.tableView reloadData];
}

@end
