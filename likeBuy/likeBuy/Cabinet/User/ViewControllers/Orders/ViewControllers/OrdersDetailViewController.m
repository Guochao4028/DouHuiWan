//
//  OrdersDetailViewController.m
//  likeBuy
//
//  Created by mac on 2019/11/23.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "OrdersDetailViewController.h"
#import "OrdeTableViewCell.h"
#import "OrderModel.h"
#import "Message.h"
#import "FansOrderTableViewCell.h"
#import "WebViewController.h"

static NSString *const kOrdeTableViewCellIdentifier = @"OrdeTableViewCell";

static NSString *const kFansOrderTableViewCellIdentifier = @"FansOrderTableViewCell";

@interface OrdersDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, copy)NSString *currentPage;

@property(nonatomic, copy)NSString *token;


@end

@implementation OrdersDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFinish) name:LOGFINISH object:nil];
}

-(void)initUI{
    [self.view setBackgroundColor:WHITE];
    [self.view addSubview:self.tableView];
}


-(void)initOrdersData:(NSInteger)index{
    NSDictionary *dic;
    switch (index) {
        case 0:{
            //全部
            dic = @{@"orderType":self.orderType, @"pageNo":@"1", @"pageSize":@"10", @"appToken":self.token};
        }
            break;
        case 1:{
            //已付款
            dic = @{@"orderType":self.orderType, @"pageNo":@"1", @"pageSize":@"10", @"appToken":self.token, @"tbStatus":@"12"};
        }
            break;
        case 2:{
            //已结算
          dic = @{@"orderType":self.orderType, @"pageNo":@"1", @"pageSize":@"10", @"appToken":self.token, @"tbStatus":@"3"};
        }
            break;
        case 3:{
            //已失效
           dic = @{@"orderType":self.orderType, @"pageNo":@"1", @"pageSize":@"10", @"appToken":self.token, @"tbStatus":@"13"};
        }
            break;
            
        default:
            break;
    }
    
    [[DataManager shareInstance]customerOrders:dic callBack:^(NSArray *result) {
        
        NSInteger resultCount =  result.count;
        
        if (resultCount > 1) {
            self.dataArray = [NSMutableArray arrayWithArray:result];
            [self.tableView reloadData];
        }
        
        if (resultCount == 1) {
            
            id obj = [result lastObject];
            
            if ([obj isKindOfClass:[OrderModel class]] == YES) {
                self.dataArray = [NSMutableArray arrayWithArray:result];
                [self.tableView reloadData];
            }
            
            if ([obj isKindOfClass:[Message class]] == YES) {
                [[DataManager shareInstance]taobaobendiAuthorizationParentController:self callBack:^(NSObject *object) {
                    
                    if (object != nil) {
                        WebViewController* webVC = [[WebViewController alloc] init];
                        
                        [self presentViewController:webVC animated:YES completion:nil];
                    }
                }];
            }
        }
        
    }];
    
}

-(void)loadingData{
    
    NSDictionary *dic;
    NSInteger cp = [self.currentPage integerValue];
    cp++;
    self.currentPage = [NSString stringWithFormat:@"%ld",(long)cp];
    
       switch (self.index) {
           case 0:{
               //全部
               dic = @{@"orderType":self.orderType, @"pageNo":self.currentPage, @"pageSize":@"10", @"appToken":self.token};
           }
               break;
           case 1:{
               //已付款
               dic = @{@"orderType":self.orderType, @"pageNo":self.currentPage, @"pageSize":@"10", @"appToken":self.token, @"tbStatus":@"12"};
           }
               break;
           case 2:{
               //已结算
             dic = @{@"orderType":self.orderType, @"pageNo":self.currentPage, @"pageSize":@"10", @"appToken":self.token, @"tbStatus":@"3"};
           }
               break;
           case 3:{
               //已失效
              dic = @{@"orderType":self.orderType, @"pageNo":self.currentPage, @"pageSize":@"10", @"appToken":self.token, @"tbStatus":@"13"};
           }
               break;
               
           default:
               break;
       }
       
      [[DataManager shareInstance]customerOrders:dic callBack:^(NSArray *result) {
           
           [self.dataArray addObjectsFromArray:result];
           
           [self.tableView reloadData];
           
           [self.tableView.mj_footer endRefreshing];
       }];
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 14;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 14;
    }
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tableViewH = 0;
    if ([self.orderType isEqualToString:@"1"] == YES) {
        tableViewH = 140;
    }else{
        tableViewH = 190;
    }
    return tableViewH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.orderType isEqualToString:@"1"] == YES) {
        OrdeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kOrdeTableViewCellIdentifier];
        [cell setOrderType:self.orderType];
        [cell setModel: [self.dataArray objectAtIndex:indexPath.row]];
        return cell;
    }else{
        
        FansOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFansOrderTableViewCellIdentifier];
        
        [cell setModel: [self.dataArray objectAtIndex:indexPath.row]];
        
        return cell;
    }
}

#pragma mark -  action

-(void)loginFinish{
    [self initOrdersData:self.index];
}

#pragma mark - getter / setter

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -  (NavigatorHeight +40))];
        
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrdeTableViewCell class]) bundle:nil] forCellReuseIdentifier:kOrdeTableViewCellIdentifier];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FansOrderTableViewCell class]) bundle:nil] forCellReuseIdentifier:kFansOrderTableViewCellIdentifier];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView setBackgroundColor:[UIColor colorWithHexString:@"#FAFAFA"]];
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadingData)];
        _tableView.mj_footer = footer;
    }
    return _tableView;
}

-(void)setIndex:(NSInteger)index{
    _index = index;
    self.currentPage = @"1";
    [self initOrdersData:index];
}

-(NSString *)token{
    User *user = [[DataManager shareInstance]getUser];
    if (user != nil) {
        return user.appToken;
    }
    return @"";
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
