//
//  BusinessCooperationViewController.m
//  likeBuy
//
//  Created by mac on 2019/12/3.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "BusinessCooperationViewController.h"
#import "AboutTitleView.h"
#import "NavigationView.h"
#import "CooperTableViewCell.h"



static NSString *const kCooperTableViewCellIdentifier = @"CooperTableViewCell";

@interface BusinessCooperationViewController ()<NavigationViewDelegate, UITableViewDataSource,UITableViewDelegate, CooperTableViewCellDelegate>

@property(nonatomic, strong)NavigationView *navigationView;

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)AboutTitleView *titleView;

@property(nonatomic, strong)NSArray *tabelArray;

@property(nonatomic, strong)UIButton *commitButton;

@property(nonatomic, strong)NSMutableArray *dataList;

@property(nonatomic, strong)NSMutableArray *savaWordList;


@end

@implementation BusinessCooperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initUI{
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.navigationView];
    [self.navigationView setTitleStr:@"商务合作"];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.commitButton];
}

-(void)initData{
    self.savaWordList = [NSMutableArray array];
    
    for (int i = 0; i < 5; i++) {
        [self.savaWordList addObject:@""];
    }
    
    self.dataList = [NSMutableArray array];
    self.tabelArray =@[
        
        @{@"name":@"品牌/公司", @"placeholder":@"请输入公司名称", @"isSeled":@"0", @"isXing":@"1"},
        @{@"name":@"姓名", @"placeholder":@"输入您的姓名", @"isSeled":@"0", @"isXing":@"1"},
        @{@"name":@"岗位", @"placeholder":@"请输入所在公司岗位", @"isSeled":@"0", @"isXing":@"0"},
        @{@"name":@"联系电话", @"placeholder":@"请输入您的联系电话", @"isSeled":@"0", @"isXing":@"1"},
        @{@"name":@"合作意向", @"placeholder":@"如：淘宝店推广", @"isSeled":@"1", @"isXing":@"1"},
    ];
}


#pragma mark -  UITableViewDelegate & UITableViewDataSource


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
    return self.tabelArray.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 54;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CooperTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:kCooperTableViewCellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dic = self.tabelArray[indexPath.row];
    [cell setDelegate:self];
    [cell setMdoel:dic];
    [cell setIndexPathRow:indexPath.row];
  
    return cell;
}


#pragma mark - CooperTableViewCellDelegate
-(void)cooperCell:(CooperTableViewCell *)cell loction:(NSInteger)row endInput:(NSString *)word{
    
   [self.savaWordList replaceObjectAtIndex:row withObject:word];
    
}



#pragma mark - NavigationViewDelegate
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - action

-(void)submitt{
    NSLog(@"submitt");
    
    User *user = [[DataManager shareInstance]getUser];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    if (user != nil) {
        [param setValue:user.appToken forKey:@"appToken"];
    }
    
    NSArray *title =  @[@"company", @"name", @"job", @"phone", @"copType"];
    
    
    for (int i = 0; i < title.count; i++) {
        [param setValue:self.savaWordList[i] forKey:title[i]];
    }
    
    [param setValue:@"0" forKey:@"copType"];
    
    [[DataManager shareInstance]businessAdd:param callback:^(NSObject *object) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
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
        
        //        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, titleViewY, ScreenWidth, ScreenHeight - titleViewY) style:UITableViewStylePlain];
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, titleViewY, ScreenWidth, 260) style:UITableViewStylePlain];
        
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        
        [_tableView setBackgroundColor:WHITE];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CooperTableViewCell class]) bundle:nil] forCellReuseIdentifier:kCooperTableViewCellIdentifier];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    }
    return _tableView;
}

-(UIButton *)commitButton{
    if (_commitButton == nil) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat y = CGRectGetMaxY(self.tableView.frame)+44;
        
        [_commitButton setFrame:CGRectMake(20, y, ScreenWidth - 40, 44)];
        [_commitButton setBackgroundColor:[UIColor colorWithHexString:@"FF5457"]];
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_commitButton setTitleColor:WHITE forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(submitt) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _commitButton;
}


@end
