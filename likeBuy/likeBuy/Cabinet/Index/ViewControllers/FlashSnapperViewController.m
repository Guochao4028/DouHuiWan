//
//  FlashSnapperViewController.m
//  likeBuy
//
//  Created by mac on 2019/10/8.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "FlashSnapperViewController.h"

#import "ResultsListViewController.h"

#import "XLPageViewController.h"

#import "CustomPageTitleCell.h"

#import "NavigationView.h"

@interface FlashSnapperViewController ()<NavigationViewDelegate, XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>


@property(nonatomic, strong)NavigationView *navigationView;

@property (nonatomic, strong) XLPageViewController *pageViewController;

//配置信息
@property (nonatomic, strong) XLPageViewControllerConfig *config;

//标题组
@property (nonatomic, strong, nonnull) NSArray *titles;


@property (nonatomic, copy, nonnull) NSString *currItem;

@end

@implementation FlashSnapperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self initUI];
    
    [self initData];
}

-(void)initUI{
    [self.view addSubview:self.navigationView];
    [self initPageViewController];
}

-(void)initData{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSInteger hours = [currentTimeString integerValue];
    
    if (hours < 10) {
        self.pageViewController.selectedIndex = 0;
        self.currItem = @"6";
         
    }else if (hours >= 10 && hours < 12){
        self.pageViewController.selectedIndex = 1;
        self.currItem = @"7";
         
    }else if (hours >= 12 && hours < 15){
        self.pageViewController.selectedIndex = 2;
        self.currItem = @"8";
         
    }else if (hours >= 15 && hours < 20){
        self.pageViewController.selectedIndex = 3;
        self.currItem = @"9";
         
    }else{
        self.pageViewController.selectedIndex = 4;
         self.currItem = @"10";
         
    }
    
    [self.pageViewController reloadData];
    
}

- (void)initPageViewController {
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:self.config];
    self.pageViewController.view.frame = CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.navigationView.frame));
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    [self.pageViewController registerClass:[CustomPageTitleCell class] forTitleViewCellWithReuseIdentifier:@"CustomPageTitleViewCell"];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark - NavigationViewDelegate
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)jumpSearchView{
    [self.tabBarController setSelectedIndex:2];
    [self.navigationController popViewControllerAnimated:NO];
    
}

#pragma mark TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    ResultsListViewController *vc = [[ResultsListViewController alloc] init];
    [vc setVcType:self.vcType];
    
    NSDictionary *dic =   self.titles[index];
    NSString *subTitles = dic[@"subTitles"];
    if ([subTitles isEqualToString:@"即将开始"]) {
        vc.isBuy = NO;
    }else{
        vc.isBuy = YES;
    }
    [vc setIndex:index];
    return vc;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    NSDictionary *dic = self.titles[index];
    return dic[@"title"];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return self.titles.count;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    NSLog(@"切换到了：%@",self.titles[index]);
}


- (XLPageTitleCell *)pageViewController:(XLPageViewController *)pageViewController titleViewCellForItemAtIndex:(NSInteger)index {
    CustomPageTitleCell *cell = [pageViewController dequeueReusableTitleViewCellWithIdentifier:@"CustomPageTitleViewCell" forIndex:index];
    
    cell.model = [self titles][index];
    return cell;
}
#pragma mark - getter / setter

-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationHasGlassView];
        [_navigationView setDelegate:self];
        
    }
    return _navigationView;
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    [self.navigationView setTitleStr:titleStr];
}

-(XLPageViewControllerConfig *)config{
    if (_config == nil) {
        _config = [XLPageViewControllerConfig defaultConfig];
        //隐藏分割线
        _config.separatorLineHidden = YES;
        //字间距
        _config.titleSpace = 20;
        //滑动条
        _config.shadowLineColor = REDLINECOLOR;
        _config.titleWidth = 60;
        _config.titleViewHeight = 45;
        _config.titleViewInset = UIEdgeInsetsMake(5, 19, 5, 19);
    }
    return _config;
}

#pragma mark -
#pragma mark 标题数据
- (NSArray *)titles {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSInteger hours = [currentTimeString integerValue];
    
    if (hours < 10) {
        return @[@{@"title":@"00:00", @"subTitles":@"抢购中"},
                 @{@"title":@"10:00", @"subTitles":@"即将开始"},
                 @{@"title":@"12:00", @"subTitles":@"即将开始"},
                 @{@"title":@"15:00", @"subTitles":@"即将开始"},
                 @{@"title":@"20:00", @"subTitles":@"即将开始"},];
    }else if (hours >= 10 && hours < 12){
        return @[@{@"title":@"00:00", @"subTitles":@"已开抢"},
                 @{@"title":@"10:00", @"subTitles":@"抢购中"},
                 @{@"title":@"12:00", @"subTitles":@"即将开始"},
                 @{@"title":@"15:00", @"subTitles":@"即将开始"},
                 @{@"title":@"20:00", @"subTitles":@"即将开始"},];
    }else if (hours >= 12 && hours < 15){
        return @[@{@"title":@"00:00", @"subTitles":@"已开抢"},
                 @{@"title":@"10:00", @"subTitles":@"已开抢"},
                 @{@"title":@"12:00", @"subTitles":@"抢购中"},
                 @{@"title":@"15:00", @"subTitles":@"即将开始"},
                 @{@"title":@"20:00", @"subTitles":@"即将开始"},];
    }else if (hours >= 15 && hours < 20){
        return @[@{@"title":@"00:00", @"subTitles":@"已开抢"},
                 @{@"title":@"10:00", @"subTitles":@"已开抢"},
                 @{@"title":@"12:00", @"subTitles":@"已开抢"},
                 @{@"title":@"15:00", @"subTitles":@"抢购中"},
                 @{@"title":@"20:00", @"subTitles":@"即将开始"},];
    }else{
        return @[@{@"title":@"00:00", @"subTitles":@"即将开始"},
                 @{@"title":@"10:00", @"subTitles":@"已开抢"},
                 @{@"title":@"12:00", @"subTitles":@"已开抢"},
                 @{@"title":@"15:00", @"subTitles":@"已开抢"},
                 @{@"title":@"20:00", @"subTitles":@"抢购中"},];
    }
    
    
    return @[@{@"title":@"00:00", @"subTitles":@"即将开始"},
             @{@"title":@"10:00", @"subTitles":@"已开抢"},
             @{@"title":@"12:00", @"subTitles":@"已开抢"},
             @{@"title":@"15:00", @"subTitles":@"已开抢"},
             @{@"title":@"20:00", @"subTitles":@"抢购中"},];
}


@end
