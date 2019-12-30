//
//  FrequentlyQuestionsViewController.m
//  likeBuy
//
//  Created by mac on 2019/10/15.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "FrequentlyQuestionsViewController.h"
#import "NavigationView.h"
#import "XLPageViewController.h"

#import "QuestionsContentViewController.h"


@interface FrequentlyQuestionsViewController ()<NavigationViewDelegate,XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property(nonatomic, strong)NavigationView *navigationView;

@property (nonatomic, strong) XLPageViewController *pageViewController;

//配置信息
@property (nonatomic, strong) XLPageViewControllerConfig *config;

@end

@implementation FrequentlyQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}



-(void)initUI{
    
    [self.view addSubview:self.navigationView];
    [self.navigationView setTitleStr:@"常见问题"];
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
    
    QuestionsContentViewController *vc = [[QuestionsContentViewController alloc] init];
    vc.dataList = self.dataList;
    vc.index = index;
    
    return vc;
    
    
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
        _config.separatorLineHidden = NO;
        //字间距
        _config.titleSpace = (ScreenWidth -(49)-48 - (42+56+28))/3;
        //选择的文字字体字号
        _config.titleSelectedFont = [UIFont fontWithName:MediumFont size:14];
        //未选择的文字字体字号
        _config.titleNormalFont = [UIFont fontWithName:RegularFont size:14];
        //选中标签颜色
        _config.titleSelectedColor = REDLINECOLOR;
        //滑动条
        _config.shadowLineHidden = YES;
        //titleView居中
        _config.titleViewAlignment = XLPageTitleViewAlignmentCenter;
        
        _config.titleViewInset = UIEdgeInsetsMake(5, 48, 5, 48);
    }
    return _config;
}





@end
