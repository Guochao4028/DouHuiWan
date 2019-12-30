//
//  NewAddViewController.m
//  likeBuy
//
//  Created by mac on 2019/10/23.
//  Copyright © 2019 Beans. All rights reserved.
//  品牌清仓 实时热销

#import "NewAddViewController.h"

#import "NavigationView.h"

#import "ResultsListViewController.h"


#import "XLPageViewController.h"

@interface NewAddViewController ()<NavigationViewDelegate, XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property(nonatomic, strong)NavigationView *navigationView;

@property(nonatomic, strong)UIImageView *heardImageView;

@property (nonatomic, strong) XLPageViewController *pageViewController;

//配置信息
@property (nonatomic, strong) XLPageViewControllerConfig *config;

@end

@implementation NewAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initUI{
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.heardImageView];
    [self initPageViewController];
}


- (void)initPageViewController {
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:self.config];
    
    self.pageViewController.view.frame = CGRectMake(0, CGRectGetMaxY(self.heardImageView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.navigationView.frame));
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark - NavigationViewDelegate
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    ResultsListViewController *vc = [[ResultsListViewController alloc] init];
//    vc.model = self.categoryModelArray[index];
    [vc setTitles:self.titles];
    [vc setVcType:self.vcType];
    [vc setIndex:index];
    return vc;
    
    return [UIViewController new];
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


#pragma mark - getter / setter
-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_navigationView setDelegate:self];
        
    }
    return _navigationView;
}

-(UIImageView *)heardImageView{
    if (_heardImageView == nil) {
        CGFloat y = CGRectGetMaxY(self.navigationView.frame);
        _heardImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, y, ScreenWidth, 132)];
    }
    return _heardImageView;
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
        //选择的文字字体字号
        _config.titleSelectedFont = [UIFont fontWithName:MediumFont size:14];
        //未选择的文字字体字号
        _config.titleNormalFont = [UIFont fontWithName:RegularFont size:14];
        //滑动条
        _config.shadowLineColor = REDLINECOLOR;
        _config.titleViewInset = UIEdgeInsetsMake(5, 30, 5, 30);
        
        _config.titleViewAlignment = XLPageTitleViewAlignmentCenter;

    }
    return _config;
}

-(void)setType:(NSInteger)type{
    
    if (type == 1) {
        [self.heardImageView setImage:[UIImage imageNamed:@"pinpai"]];
    }else if (type == 2){
        [self.heardImageView setImage:[UIImage imageNamed:@"shishi"]];
    }
}
@end
