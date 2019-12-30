//
//  SearchViewController.m
//  likeBuy
//
//  Created by mac on 2019/9/24.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "SearchViewController.h"

#import "SearchListViewController.h"

#import "NavigationView.h"

#import "TipMeunView.h"

#import "SearchTopView.h"

#import "ModelTool.h"


@interface SearchViewController ()<TipMeunViewDelegate, UITableViewDelegate, UITableViewDataSource, SearchTopViewDelegate>

@property(nonatomic, strong)NavigationView *navigationView;

@property(nonatomic, strong)SearchTopView *searchTopView;

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)TipMeunView *meunView;

@property(nonatomic, strong)NSArray *dataList;

@property(nonatomic, assign)BOOL isTapSearchIcon;

@property(nonatomic, assign)MeunSelectType type;

//搜索历史
@property (nonatomic, strong) NSMutableArray *historyArray;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initUI{
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.searchTopView];
    [self.view addSubview:self.meunView];
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self initData];
    [super viewWillAppear:animated];
}

-(void)initData{
    self.dataList = @[@"女装", @"小白鞋", @"墨镜", @"打底衫", @"牛仔裤"];
    self.historyArray = [ModelTool getSearchHistoryArrayFromLocal];
    
    self.searchTopView.inTextStr = @"";
    
    [self.tableView reloadData];
    
}

- (void)addHistoryString:(NSString *)historyString {
    
    NSLog(@"historyString : %@", historyString);
    if ([self.historyArray containsObject:historyString]) {
        [self.historyArray removeObject:historyString];
    }
    [self.historyArray insertObject:historyString atIndex:0];
    
    if (self.historyArray.count > 6) {
        [self.historyArray removeLastObject];
    }
    
    [ModelTool saveSearchHistoryArrayToLocal:self.historyArray];
    
    [self.tableView reloadData];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchTopView endInput];
}

-(void)endInput{
    [self.searchTopView endInput];
}

#pragma mark - TipMeunViewDelegate
-(void)selectedMeunType:(MeunSelectType)type{
    [self.meunView setHidden:YES];
    self.type = type;
    [self.searchTopView setType:type];
    self.isTapSearchIcon = NO;
    CGFloat searchViewMaxY = CGRectGetMaxY(self.searchTopView.frame);
    [UIView animateWithDuration:0.35 animations:^{
        self.tableView.mj_y = searchViewMaxY;
    }];
    
}

#pragma mark -  UITableViewDelegate & UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.historyArray.count > 0) {
        return 2;
    }
    return 1;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.historyArray.count > 0) {
        if (section == 1) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor clearColor];
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(21, 26, 72, 25)];
            [titleLabel setFont:[UIFont fontWithName:MediumFont size:18]];
            [titleLabel setTextColor:[UIColor blackColor]];
            NSString *str = @"热门搜索";
            [titleLabel setText:str];
            [view addSubview:titleLabel];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endInput)];
            
            [view addGestureRecognizer:tap];
            
            return view;
        }else if (section == 0){
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor clearColor];
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(21, 26, 72, 25)];
            [titleLabel setFont:[UIFont fontWithName:MediumFont size:18]];
            [titleLabel setTextColor:[UIColor blackColor]];
            NSString *str = @"历史搜索";
            [titleLabel setText:str];
            [view addSubview:titleLabel];
            
            UIButton *tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [tapButton setFrame:CGRectMake(ScreenWidth -40 , 26, 40, 37)];
            [tapButton setImage:[UIImage imageNamed:@"sousuo_icon_del"] forState:UIControlStateNormal];
            [tapButton addTarget:self action:@selector(clearList) forControlEvents:UIControlEventTouchUpInside];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endInput)];
            
            [view addGestureRecognizer:tap];
            
            [view addSubview:tapButton];
            return view;
        }
    }else{
        if (section == 0) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor clearColor];
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(21, 26, 72, 25)];
            [titleLabel setFont:[UIFont fontWithName:MediumFont size:18]];
            [titleLabel setTextColor:[UIColor blackColor]];
            NSString *str = @"热门搜索";
            [titleLabel setText:str];
            [view addSubview:titleLabel];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endInput)];
            
            [view addGestureRecognizer:tap];
            return view;
        }
    }
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (self.historyArray.count > 0) {
        if (section == 0) {
            return 10;
        }else{
            return 0.01;
        }
    }else{
        if (section == 0) {
            return 0.01;
        }else{
            return 0.01;
        }
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 64;
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.historyArray.count > 0) {
        if (section == 0) {
            return 1 ;
        }else{
            return self.dataList.count;
        }
    }else{
        return self.dataList.count;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.historyArray.count > 0) {
        
        if (indexPath.section == 0) {
            if (self.historyArray.count <= 3) {
                return (((1) * 30)+18) + 10*(0 +1) +10;
            }else if (self.historyArray.count >= 4) {
                return (((1 +1) * 30)+18) + 10*(1 +1) +10;
            }else{
                return 0;
            }
        }else{
            CGFloat tableViewH = 0;
            tableViewH = 64;
            return tableViewH;
        }
    }else{
        CGFloat tableViewH = 0;
        tableViewH = 64;
        return tableViewH;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (self.historyArray.count > 0) {
        if (indexPath.section == 1) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(21, 0, ScreenWidth, 64)];
            [label setText:self.dataList[indexPath.row]];
            [label setTextColor:[UIColor blackColor]];
            [cell.contentView addSubview:label];
            [cell.contentView setBackgroundColor:WHITE];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (indexPath.section == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"historycell" forIndexPath:indexPath];
            [cell.contentView setBackgroundColor:WHITE];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            for (UIView *tem in [cell.contentView subviews]) {
                [tem removeFromSuperview];
            }
            
            for (int i=0; i<self.historyArray.count; i++) {
                
                UILabel *historyLabel=[[UILabel alloc] init];
                historyLabel.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
                historyLabel.clipsToBounds = YES;
                historyLabel.layer.cornerRadius = 10;
                historyLabel.font = [UIFont fontWithName:RegularFont size:14];
                historyLabel.textColor = [UIColor colorWithHexString:@"666666"];
                [historyLabel setTextAlignment:NSTextAlignmentCenter];
                historyLabel.text = [NSString stringWithFormat:@" %@ ",self.historyArray[i]];
                int num = (i/3);
                int y = ((num * 30)+18) + 10* num;
                
                CGFloat width = (ScreenWidth - 40 - 34)/3;
                CGFloat x;
                if (i > 2) {
                    x = 20+((width+17) * (i - 3));
                }else{
                    x = 20+((width+17) * i);
                }
                
                [historyLabel setFrame:CGRectMake( x ,y , width, 30)];
                [historyLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
                historyLabel.userInteractionEnabled=YES;
                [cell.contentView addSubview:historyLabel];
            }
        }
    }else{
        
        if (indexPath.section == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(21, 0, ScreenWidth, 64)];
            [label setText:self.dataList[indexPath.row]];
            [label setTextColor:[UIColor blackColor]];
            [cell.contentView addSubview:label];
            [cell.contentView setBackgroundColor:WHITE];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.historyArray.count > 0) {
        if (indexPath.section == 0) {
            
        }else{
            //取消输入
            [self.searchTopView endInput];
            //搜索
            SearchListViewController *searchListVC = [[SearchListViewController alloc]init];
            searchListVC.meunType = self.type;
            searchListVC.keyString= self.dataList[indexPath.row];
            [self addHistoryString:self.dataList[indexPath.row]];
            [self.navigationController pushViewController:searchListVC animated:YES];
        }
    }else{
        //取消输入
        [self.searchTopView endInput];
        //搜索
        SearchListViewController *searchListVC = [[SearchListViewController alloc]init];
        
        searchListVC.meunType = self.type;
        searchListVC.keyString= self.dataList[indexPath.row];
        [self addHistoryString:self.dataList[indexPath.row]];
        
        [self.navigationController pushViewController:searchListVC animated:YES];
    }
}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
}


-(void)tagDidCLick:(UITapGestureRecognizer *)sender
{
    UILabel *label=(UILabel *)sender.view;
    
    NSString *text =  [label.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [self searchTextField:text];
}

-(void)clearList{
    
    [self.historyArray removeAllObjects];
    
    [ModelTool saveSearchHistoryArrayToLocal:self.historyArray];
    
    [self.tableView reloadData];
}

#pragma mark - SearchTopViewDelegate
-(void)searchTextField:(NSString *)word{
    if (word.length > 0) {
        SearchListViewController *searchListVC = [[SearchListViewController alloc]init];
        
        [self addHistoryString:word];
        
        NSString *str;
        switch (self.type) {
            case MeunSelectPDDType:{
                str = @"拼多多";
            }
                break;
            case MeunSelectJDType:{
                str = @"京东";
            }
                break;
            case MeunSelectCHAOSHIType:{
                str = @"天猫超市";
            }
                break;
            case MeunSelectTAOBAOType:{
                str = @"淘宝";
            }
                break;
            case MeunSelectTIANMAOType:{
                str = @"天猫";
            }
                break;
                
            default:
                break;
        }
        searchListVC.tabString= str;
        searchListVC.meunType = self.type;
        searchListVC.keyString= word;
        [self.navigationController pushViewController:searchListVC animated:YES];
    }else{
        [MBProgressHUD wj_showError:@"请输入关键字或宝贝标题"];
    }
}

-(void)selectMeunAction{
    
    [self.meunView setType:self.type];
    
    self.isTapSearchIcon = !self.isTapSearchIcon;
    
    if(self.isTapSearchIcon == YES){
        [self.meunView setHidden:NO];
        [UIView animateWithDuration:0.35 animations:^{
            self.tableView.mj_y = CGRectGetMaxY(self.meunView.frame);
        }];
    }else{
        [self.meunView setHidden:YES];
        CGFloat searchViewMaxY = CGRectGetMaxY(self.searchTopView.frame);
        [UIView animateWithDuration:0.35 animations:^{
            self.tableView.mj_y = searchViewMaxY;
        }];
    }
}

#pragma mark - getter / setter

-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        
        CGFloat stateH = [[UIApplication sharedApplication] statusBarFrame].size.height;
        
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0,stateH, ScreenWidth, 64) type:NavigationDaXie];
        [_navigationView setIsViewMeage:NO];
        [_navigationView setDaxieTitleStr:@"搜索"];
    }
    return _navigationView;
}

-(SearchTopView *)searchTopView{
    if (_searchTopView == nil) {
        CGFloat navigationMaxY = CGRectGetMaxY(self.navigationView.frame);
        
        _searchTopView = [[SearchTopView alloc]initWithFrame:CGRectMake(0, navigationMaxY, ScreenWidth, 64)];
        [_searchTopView setDelegate:self];
        [_searchTopView setIsViewBack:YES];
        
        self.type = MeunSelectTAOBAOType;
    }
    return _searchTopView;
}

-(TipMeunView *)meunView{
    if (_meunView == nil) {
        CGFloat searchViewMaxY = CGRectGetMaxY(self.searchTopView.frame);
        
        _meunView = [[TipMeunView alloc]initWithFrame:CGRectMake(0, searchViewMaxY, ScreenWidth, 104)];
        [_meunView setDelegate:self];
        [_meunView setHidden:YES];
    }
    return _meunView;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        
        CGFloat searchViewMaxY = CGRectGetMaxY(self.searchTopView.frame);
        
        _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, searchViewMaxY,ScreenWidth, ScreenHeight - searchViewMaxY) style:UITableViewStyleGrouped];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setBackgroundColor:[UIColor whiteColor]];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"historycell"];
    }
    return _tableView;
}




@end
