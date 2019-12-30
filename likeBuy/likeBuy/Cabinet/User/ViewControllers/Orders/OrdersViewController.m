//
//  FansOrdersViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "OrdersViewController.h"
#import "OrdeTableViewCell.h"
#import "NavigationView.h"
#import "XLPageViewController.h"
#import "FansOrderTableViewCell.h"

#import "OrdersDetailViewController.h"

static NSString *const kOrdeTableViewCellIdentifier = @"OrdeTableViewCell";

static NSString *const kFansOrderTableViewCellIdentifier = @"FansOrderTableViewCell";

@interface OrdersViewController ()<NavigationViewDelegate, XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property(nonatomic, strong)NavigationView *navigationView;

@property (nonatomic, strong) XLPageViewController *pageViewController;
//配置信息
@property (nonatomic, strong) XLPageViewControllerConfig *config;

@property(nonatomic, strong)User *userModel;


@end

@implementation OrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self initData];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"FAFAFA"]];
    [self.view addSubview:self.navigationView];
    [self initPageViewController];
}

- (void)initPageViewController {
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:self.config];
    
    CGFloat y = CGRectGetMaxY(self.navigationView.frame);
    
    self.pageViewController.view.frame = CGRectMake(0, y, ScreenWidth, ScreenHeight- y);
    
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}


#pragma mark  - TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    
    OrdersDetailViewController *ordersDetailVC = [[OrdersDetailViewController alloc]init];
    ordersDetailVC.orderType = self.orderType;
    ordersDetailVC.index = index;
    return ordersDetailVC;
    
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
    [self.tabBarController.tabBar setHidden:NO];
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

-(void)setOrderType:(NSString *)orderType{
    _orderType = orderType;
    
    if ([orderType isEqualToString:@"2"]) {
        [self.navigationView setTitleStr:@"粉丝订单"];
    }else{
        [self.navigationView setTitleStr:@"我的订单"];
    }
}


-(XLPageViewControllerConfig *)config{
    if (_config == nil) {
        _config = [XLPageViewControllerConfig defaultConfig];
        //隐藏分割线
        _config.separatorLineHidden = YES;
        
        _config.titleWidth = ScreenWidth / 4;
        //字间距
        _config.titleSpace = 0;
        //选择的文字字体字号
        _config.titleSelectedFont = [UIFont fontWithName:MediumFont size:14];
        _config.titleNormalColor = [UIColor blackColor];
        //未选择的文字字体字号
        _config.titleNormalFont = [UIFont fontWithName:RegularFont size:14];
        //滑动条
        _config.shadowLineColor = REDLINECOLOR;
        
        _config.titleSelectedColor = REDLINECOLOR;
        
        _config.titleViewAlignment = XLPageTitleViewAlignmentCenter;
        
        _config.titleViewBackgroundColor = WHITE;
        
    }
    return _config;
}

@end
