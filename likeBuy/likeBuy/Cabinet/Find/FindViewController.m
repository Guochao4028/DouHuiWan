//
//  FindViewController.m
//  likeBuy
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "FindViewController.h"

#import "DiscoverViewController.h"

#import "GroomViewController.h"

#import "XLPageViewController.h"

@interface FindViewController ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

@property (nonatomic, strong) XLPageViewController *pageViewController;

//配置信息
@property (nonatomic, strong) XLPageViewControllerConfig *config;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initUI{
    [self initPageViewController];
}

- (void)initPageViewController {
    self.pageViewController = [[XLPageViewController alloc] initWithConfig:self.config];
    CGFloat stateH = [[UIApplication sharedApplication] statusBarFrame].size.height;
    self.pageViewController.view.frame = CGRectMake(0, stateH, ScreenWidth, ScreenHeight - stateH);
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}


#pragma mark TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    
    if (index == 0) {
        DiscoverViewController *discoverVC = [[DiscoverViewController alloc]init];
        return discoverVC;
    }else if(index == 1){
        GroomViewController *groomVC = [[GroomViewController alloc]init];
        return groomVC;
    }
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

-(XLPageViewControllerConfig *)config{
    if (_config == nil) {
        _config = [XLPageViewControllerConfig defaultConfig];
        //隐藏分割线
        _config.separatorLineHidden = YES;
        _config.shadowLineHeight = 0;
        //字间距
        _config.titleSpace = 20;
        //选择的文字字体字号
        _config.titleSelectedFont = [UIFont fontWithName:MediumFont size:26];
        //未选择的文字字体字号
        _config.titleNormalFont = [UIFont fontWithName:RegularFont size:18];
        //滑动条
        _config.shadowLineColor = REDLINECOLOR;
        _config.titleViewInset = UIEdgeInsetsMake(5, 30, 5, 30);
    }
    return _config;
}

@end
