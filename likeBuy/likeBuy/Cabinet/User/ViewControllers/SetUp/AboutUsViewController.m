//
//  AboutUsViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/23.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AboutTableViewCell.h"
#import "AboutTitleView.h"
#import "NavigationView.h"

#import "LaunchViewController.h"

#import "AboutContentTableViewCell.h"

#import "ExplainViewController.h"

#import "HelpViewController.h"


static NSString *const kSetUpTableViewCellIdentifier = @"AboutTableViewCell";
static NSString *const kAboutContentTableViewCellIdentifier = @"AboutContentTableViewCell";

@interface AboutUsViewController ()<NavigationViewDelegate, UITableViewDataSource,UITableViewDelegate>

//导航
@property(nonatomic, strong)NavigationView *navigationView;

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)AboutTitleView *titleView;

@property(nonatomic, strong)NSArray *dataList;

//@property(nonatomic, strong)UpgradeView *upgradeView;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
    [self initData];
}

-(void)initUI{
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.navigationView];
    [self.navigationView setTitleStr:@"关于我们"];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.tableView];
}

-(void)initData{
    self.dataList = @[
        @{@"title":@"当前版本", @"isReturn":@"0", @"isword":@"1", @"neirong":@"v1.0"},
        @{@"title":@"隐私政策", @"isReturn":@"1", @"isword":@"0", @"isImageView":@"0", @"type":@"6"},
        @{@"title":@"用户注册服务协议", @"isReturn":@"1", @"isword":@"0", @"isImageView":@"0", @"type":@"6"},
        @{@"title":@"平台服务协议和交易规则", @"isReturn":@"1", @"isword":@"0", @"isImageView":@"0", @"type":@"6"},
        @{@"title":@"意见反馈", @"isReturn":@"1", @"isword":@"0", @"isImageView":@"0", @"type":@"6"},
        @{@"title":@"投诉", @"isReturn":@"1", @"isword":@"0", @"isImageView":@"0", @"type":@"1"}
    ];
    
    
    //    self.dataList = @[
    //           @{@"title":@"当前版本", @"isReturn":@"0", @"isword":@"1", @"neirong":@"v1.0"},
    //                             ];
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
    return self.dataList.count ;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSetUpTableViewCellIdentifier forIndexPath:indexPath];
    
    [cell setModel:[self.dataList objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.row  == 1) {
        ExplainViewController *explainVC = [[ExplainViewController alloc]init];
        [explainVC setTitleStr:@"隐私政策"];
        [explainVC setType:0];
        [self.navigationController pushViewController:explainVC animated:YES];
    }
    
    if (indexPath.row  == 2) {
        ExplainViewController *explainVC = [[ExplainViewController alloc]init];
        [explainVC setTitleStr:@"用户注册服务协议"];
        [explainVC setType:1];
        [self.navigationController pushViewController:explainVC animated:YES];
    }
    
    if (indexPath.row  == 3) {
        ExplainViewController *explainVC = [[ExplainViewController alloc]init];
        [explainVC setTitleStr:@"平台服务协议和交易规则"];
        [explainVC setType:0];
        [self.navigationController pushViewController:explainVC animated:YES];
    }
    
    if (indexPath.row  == 4) {
        HelpViewController *helpVC = [[HelpViewController alloc]init];
        [self.navigationController pushViewController:helpVC animated:YES];
        
    }
    
    if (indexPath.row  == 5) {
        HelpViewController *helpVC = [[HelpViewController alloc]init];
        [self.navigationController pushViewController:helpVC animated:YES];
    }
}


#pragma mark - NavigationViewDelegate
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter / setter
-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_navigationView setDelegate:self];
    }
    return _navigationView;
}

-(AboutTitleView *)titleView{
    if(_titleView == nil){
        
        CGFloat navigationY =  CGRectGetMaxY(self.navigationView.frame);
        
        _titleView = [[AboutTitleView alloc]initWithFrame:CGRectMake(0, navigationY, ScreenWidth, 100)];
    }
    return _titleView;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        
        CGFloat titleViewY =  CGRectGetMaxY(self.titleView.frame);
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, titleViewY, ScreenWidth, ScreenHeight - titleViewY) style:UITableViewStylePlain];
        
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AboutTableViewCell class]) bundle:nil] forCellReuseIdentifier:kSetUpTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AboutContentTableViewCell class]) bundle:nil] forCellReuseIdentifier:kAboutContentTableViewCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setBackgroundColor:WHITE];
        
        
        
    }
    return _tableView;
}


@end
