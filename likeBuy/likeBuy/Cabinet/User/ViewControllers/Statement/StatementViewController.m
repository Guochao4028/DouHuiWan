//
//  StatementViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "StatementViewController.h"
#import "StatementInfoTableViewCell.h"
#import "StatementTodayTableViewCell.h"

static NSString *const kStatementInfoTableViewCellIdentifier = @"StatementInfoTableViewCell";

static NSString *const kStatementTodayTableViewCellIdentifier = @"StatementTodayTableViewCell";

@interface StatementViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSDictionary *dataDic;


@property(nonatomic, copy)NSString *token;

@end

@implementation StatementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tableView];
}




-(void)loadDataFeeType:(NSInteger)type{
    NSDictionary *dic = @{ @"appToken":self.token, @"feeType":@(type)};
    [[DataManager shareInstance]getFeeDetail:dic callBack:^(NSDictionary *result) {
        self.dataDic = result;
        [self.tableView reloadData];
    }];
}

#pragma mark -  UITableViewDelegate & UITableViewDataSource

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
        return 0.01;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 0.01;
    }
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tableViewH = 0;
    if (indexPath.row == 0) {
        return 335;
    }
    
    if (indexPath.row == 1) {
        return 150;
    }
    
    if (indexPath.row == 2) {
        return 150;
    }
    
    return tableViewH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        StatementInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStatementInfoTableViewCellIdentifier forIndexPath:indexPath];
        [cell setModel:self.dataDic];
        return cell;
        
    }
    
    if (indexPath.row == 1) {
        StatementTodayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStatementTodayTableViewCellIdentifier forIndexPath:indexPath];
        [cell setTitle:@"今天"];
        [cell setModel:self.dataDic];
        return cell;
    }
    
    if (indexPath.row == 2) {
        StatementTodayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStatementTodayTableViewCellIdentifier forIndexPath:indexPath];
        [cell setTitle:@"昨天"];
        [cell setModel:self.dataDic];
        return cell;
    }
    
    return nil;
}


#pragma mark - NavigationViewDelegate
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - getter / setter

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavigatorHeight)];
        
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([StatementInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:kStatementInfoTableViewCellIdentifier];
        
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([StatementTodayTableViewCell class]) bundle:nil] forCellReuseIdentifier:kStatementTodayTableViewCellIdentifier];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView setBackgroundColor:[UIColor colorWithHexString:@"FAFAFA"]];
        
    }
    
    return _tableView;
}

-(void)setIndex:(NSInteger)index{
    _index = index;
    
    [self loadDataFeeType:(index + 1)];
    
}


-(NSString *)token{
    User *user = [[DataManager shareInstance]getUser];
    if (user == nil) {
        return @"";
    }
    return user.appToken;
    
}


@end
