//
//  StatementHomeViewController.m
//  likeBuy
//
//  Created by mac on 2019/11/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "StatementHomeViewController.h"
#import "NavigationView.h"
#import "XLPageViewController.h"

#import "StatementViewController.h"

@interface StatementHomeViewController ()<NavigationViewDelegate,XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>


@property(nonatomic, strong)NavigationView *navigationView;

@property (nonatomic, strong) XLPageViewController *pageViewController;

//配置信息
@property (nonatomic, strong) XLPageViewControllerConfig *config;
@end

@implementation StatementHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

-(void)initUI{
    
    [self.view addSubview:self.navigationView];
    [self.navigationView setTitleStr:@"收益报表"];
    [self initPageViewController];
}

- (void)initPageViewController {
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:self.config];
    self.pageViewController.view.frame = CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.navigationView.frame));
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark TableViewDelegate&DataSource

- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    
    StatementViewController *memntVC = [[StatementViewController alloc]init];
    [memntVC setIndex:index];
    return memntVC;
    
//    return [UIViewController new];
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return self.titles[index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return self.titles.count;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    NSLog(@"切换到了：%@",self.titles[index]);
}


#pragma mark - NavigationViewDelegate

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -  setter / getter

-(NavigationView *)navigationView{
    
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_navigationView setDelegate:self];
    }
    return _navigationView;
}

-(XLPageViewControllerConfig *)config{
    if (_config == nil) {
        _config = [XLPageViewControllerConfig defaultConfig];
        //隐藏分割线
        _config.separatorLineHidden = YES;
        //字间距
        _config.titleSpace = (ScreenWidth -(49)-48 - (42+56+28))/3;
        //选择的文字字体字号
        _config.titleSelectedFont = [UIFont fontWithName:MediumFont size:14];
        //未选择的文字字体字号
        _config.titleNormalFont = [UIFont fontWithName:RegularFont size:14];
        //选中标签颜色
        _config.titleSelectedColor = REDLINECOLOR;
        
        _config.shadowLineColor = REDLINECOLOR;
        
        _config.titleViewInset = UIEdgeInsetsMake(0, 48, 0, 48);
        _config.titleViewAlignment = XLPageTitleViewAlignmentCenter;
    }
    return _config;
}


@end
