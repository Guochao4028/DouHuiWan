//
//  GoodsListView.m
//  likeBuy
//
//  Created by mac on 2019/9/25.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "GoodsListView.h"

#import "GoodsListTableViewCell.h"

#import "GoodsModel.h"

#import "PddGoodsListModel.h"

static NSString *const kGoodsListTableViewCellIdentifier = @"GoodsListTableViewCell";

@interface GoodsListView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;



@end

@implementation GoodsListView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.tableView];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.tableView setFrame:self.bounds];
}


-(void)refreshData{
    if([self.delegate respondsToSelector:@selector(refresh:)]){
        [self.delegate refresh:self.tableView];
    }
}

-(void)loadMoreData{
    if([self.delegate respondsToSelector:@selector(loadData:)]){
        [self.delegate loadData:self.tableView];
    }
}

-(void)headerEndRefreshing{
    [self.tableView.mj_header endRefreshing];
}

-(void)footerEndRefreshing{
    [self.tableView.mj_footer endRefreshing];
}

-(void)refreshingState:(MJRefreshState)state{
    self.tableView.mj_footer.state = state;
}

-(void)endRefreshingWithNoMoreData{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

#pragma mark -  UITableViewDelegate & UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tableViewH = 140;
    return tableViewH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;// = [[UITableViewCell alloc]init];
    
    GoodsListTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:kGoodsListTableViewCellIdentifier];
    
    goodsCell.viewType = @"pdd";
    //判断是否是从拼多多来的数据
    
    if ([self.viewType isEqualToString:@"pdd"] == YES) {
        if (self.dataList.count > 0) {
                   id model = self.dataList[indexPath.row];
                   if ([model isKindOfClass:[PddGoodsListModel class]] == YES) {
                       [goodsCell setGoodsListModel:model];
                   }
               }
    }else if([self.viewType isEqualToString:@"jd"] == YES){
        
        if (self.dataList.count > 0) {
            id model = self.dataList[indexPath.row];
            if ([model isKindOfClass:[GoodsModel class]] == YES) {
                [goodsCell setModel:model];
            }
        }
        
        //    [goodsCell setModel:self.dataList[indexPath.row]];
        
        if (self.isViewImage == YES) {
            [goodsCell setDic:self.iconDic];
        }
        
    } else{
        if (self.dataList.count > 0) {
            id model = self.dataList[indexPath.row];
            if ([model isKindOfClass:[GoodsModel class]] == YES) {
                [goodsCell setModel:model];
            }
        }
        
        //    [goodsCell setModel:self.dataList[indexPath.row]];
        
        if (self.isViewImage == YES) {
            [goodsCell setDic:self.iconDic];
        }
    }
    
    cell = goodsCell;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转商品详情
    
    if ([self.viewType isEqualToString:@"pdd"] == YES) {
        
        if (self.dataList.count == 0) {
            return;
        }
        
        PddGoodsListModel *tem = self.dataList[indexPath.row];
        
        if([self.delegate respondsToSelector:@selector(tapGoodsListModel:)]){
            [self.delegate tapGoodsListModel:tem];
        }
        
    }else{
        if (self.dataList.count == 0) {
            return;
        }
        
        GoodsModel *tem = self.dataList[indexPath.row];
        if (self.iconDic != nil) {
            tem.isComm = self.iconDic;
        }
        
        if([self.delegate respondsToSelector:@selector(tapGoods:)]){
            [self.delegate tapGoods:tem];
        }
    }
}
 
#pragma mark - setter / getter

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView  = [[UITableView alloc]initWithFrame:self.bounds];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setBackgroundColor:[UIColor whiteColor]];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsListTableViewCell class]) bundle:nil] forCellReuseIdentifier:kGoodsListTableViewCellIdentifier];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"松手刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
        
        _tableView.mj_header = header;
        
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
        [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
        
        _tableView.mj_footer = footer;
        
//        _tableView.estimatedRowHeight = 0;
//               _tableView.estimatedSectionFooterHeight = 0;
//               _tableView.estimatedSectionHeaderHeight = 0;
    }
    return _tableView;
}

-(void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    
    [self.tableView reloadData];
    
    if (self.isUpdata == YES) {
        //滚动到其相应的位置
        //        [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
        
        if (dataList.count > 0) {
            
            [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
        }
    }
     
}




@end
