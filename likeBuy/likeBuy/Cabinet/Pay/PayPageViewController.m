//
//  PayPageViewController.m
//  likeBuy
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "PayPageViewController.h"
#import "PayTableViewCell.h"
#import "PayPageTitleView.h"
#import "PaymentSuccessViewController.h"


static NSString *const kPayTableViewCellIdentifier = @"PayTableViewCell";

@interface PayPageViewController ()<PayPageTitleViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)PayPageTitleView *titleView;

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSArray *dataArray;

@property(nonatomic, strong)UIButton *commitButton;

@end

@implementation PayPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
    [self initData];
}

-(void)initUI{
    [self.view addSubview:self.titleView];
    [self.titleView setModel:self.model];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.commitButton];
}

-(void)initData{
    self.dataArray = @[
    
        @{@"title":@"支付宝", @"icon":@"zhifubao", @"isSelecd":@"1"},
        @{@"title":@"微信", @"icon":@"weixin", @"isSelecd":@"0"},
        @{@"title":@"银联支付", @"icon":@"yinlian-3", @"isSelecd":@"0"}
    ];
}

#pragma mark -  PayPageTitleViewDelegate
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  UITableViewDelegate & UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 0.01;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tableViewH = 65;
    return tableViewH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    PayTableViewCell *payCell = [tableView dequeueReusableCellWithIdentifier:kPayTableViewCellIdentifier forIndexPath:indexPath];
    payCell.model = self.dataArray[indexPath.row];
        
    return payCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *tem = [NSMutableArray array];
    
    for (NSDictionary *dic in self.dataArray) {
        NSMutableDictionary *temDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [temDic setObject:[NSString stringWithFormat:@"%d", 0] forKey:@"isSelecd"];
        [tem addObject:temDic];
    }
    NSMutableDictionary *dic = tem[indexPath.row];
      
    BOOL isSelect = [dic[@"isSelecd"] boolValue];
    [dic setObject:[NSString stringWithFormat:@"%d", !isSelect] forKey:@"isSelecd"];
    
    self.dataArray = [NSArray arrayWithArray:tem];
    [self.tableView reloadData];
}

#pragma mark - action
-(void)tapButtonAction{
    
    NSString *title;
    for (NSDictionary *dic in self.dataArray) {
         BOOL isSelect = [dic[@"isSelecd"] boolValue];
        
        if (isSelect == YES) {
            title = dic[@"title"];
        }
    }
    
    
   MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"付款中...";
    hud.minShowTime = 3.5f;
    [hud showAnimated:YES whileExecutingBlock:^{
       
    } completionBlock:^{
        PaymentSuccessViewController *paySuccessVC = [[PaymentSuccessViewController alloc]init];
        paySuccessVC.payName = title;
        paySuccessVC.model = self.model;
        [self.navigationController pushViewController:paySuccessVC animated:YES];
        [hud removeFromSuperview];
    }];
    
    
    
}

#pragma mark -  setter / getter

-(PayPageTitleView *)titleView{
    if (_titleView == nil) {
        _titleView = [[PayPageTitleView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
        [_titleView setDelegate:self];
    }
    return _titleView;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGFloat y = CGRectGetMaxY(self.titleView.frame);
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, y, ScreenWidth, ScreenHeight - y)];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setBackgroundColor:[UIColor colorWithHexString:@"F7F7F7"]];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PayTableViewCell class]) bundle:nil] forCellReuseIdentifier:kPayTableViewCellIdentifier];
         _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(UIButton *)commitButton{
    if (_commitButton == nil) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commitButton setFrame:CGRectMake(20, (ScreenHeight - 80 - 44), ScreenWidth - 40, 44)];
        [_commitButton setBackgroundColor:[UIColor colorWithHexString:@"257EE6"]];
        _commitButton.layer.cornerRadius = 10;
        _commitButton.layer.masksToBounds = YES;
        [_commitButton setTitle:@"确认支付" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(tapButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _commitButton;
}

@end
