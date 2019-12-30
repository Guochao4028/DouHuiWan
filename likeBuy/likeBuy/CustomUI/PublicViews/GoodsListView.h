//
//  GoodsListView.h
//  likeBuy
//
//  Created by mac on 2019/9/25.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class GoodsModel, PddGoodsListModel;
@protocol GoodsListViewDelegate <NSObject>

@optional

-(void)refresh:(UITableView *)tableView;

-(void)loadData:(UITableView *)tableView;

-(void)tapGoods:(GoodsModel *)model;

-(void)tapGoodsListModel:(PddGoodsListModel *)model;

@end

@interface GoodsListView : UIView

@property(nonatomic, strong)NSArray *dataList;

@property(nonatomic, assign)BOOL isViewImage;

@property(nonatomic, strong)NSDictionary *iconDic;

@property(nonatomic, assign)BOOL isUpdata;

@property(nonatomic, weak)id<GoodsListViewDelegate> delegate;

/**
 * 用于 区分 拼多多， 京东，正常
 * pdd，jd， nou
 */
@property(nonatomic, copy)NSString *viewType;


-(void)headerEndRefreshing;

-(void)footerEndRefreshing;

-(void)refreshingState:(MJRefreshState)state;

-(void)endRefreshingWithNoMoreData;

@end

NS_ASSUME_NONNULL_END
