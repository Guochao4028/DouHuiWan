//
//  HomePageViewController.m
//  likeBuy
//
//  Created by mac on 2019/10/22.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "HomePageViewController.h"

#import "ClassifyViewController.h"

#import "SearchBarView.h"

#import "NewsView.h"

#import "IndexViewController.h"

#import "LoginViewController.h"

#import "BreedViewController.h"

#import "InfoViewController.h"

#import "SPPageMenu.h"



@interface HomePageViewController ()<SPPageMenuDelegate, UIScrollViewDelegate>

@property(nonatomic, strong)SearchBarView *barVeiw;

@property(nonatomic, strong)NewsView *newsView;

@property (nonatomic, strong)SPPageMenu *pageMenu;

@property (nonatomic, strong) UIScrollView *scrollView;

/**
 *存储 改变的颜色
 */
@property(nonatomic, strong)UIColor *changColor;

/**记录 显示的高度*/
@property(nonatomic, assign)CGFloat viewFrame;
/***
 *记录 保存 子viewcontrollers
 */
@property (nonatomic, strong) NSMutableArray *childViewControllers;

/**
 *通知开关
 */
@property(nonatomic, assign)BOOL notificationEndFlag;

@property(nonatomic, strong)UIView *tempView;


@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}


-(void)initData{
    
    self.notificationEndFlag = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColors:) name:NOTIFICATIONCHANGE object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColorsEnd:) name:NOTIFICATIONCHANGEEND object:nil];
}

-(void)beginColor{
    [self initData];
}


-(void)initUI{
    [self.view addSubview:self.tempView];
    [self.view addSubview:self.barVeiw];
    [self.view addSubview:self.newsView];
    
    CGFloat y = CGRectGetMaxY(self.barVeiw.frame);
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, y, ScreenWidth, 40) trackerStyle:SPPageMenuTrackerStyleLine];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.titles selectedItemIndex:0];
    pageMenu.showFuntionButton = YES;
    [pageMenu setFunctionButtonContent:[UIImage imageNamed:@"bai"] forState:UIControlStateNormal];
    // 设置代理
    pageMenu.delegate = self;
    
    pageMenu.bridgeScrollView = self.scrollView;
    
    pageMenu.selectedItemTitleFont = [UIFont fontWithName:MediumFont size:16];
    
    pageMenu.unSelectedItemTitleFont = [UIFont fontWithName:RegularFont size:16];
    [pageMenu.dividingLine setHidden:YES];
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
    
    [self.view addSubview:self.scrollView];
    for (int i = 0; i < self.titles.count; i++) {
        if (i == 0) {
            IndexViewController *indexVC = [[IndexViewController alloc] init];
            [self addChildViewController:indexVC];
            [self.childViewControllers addObject:indexVC];
        }else{
            
            BreedViewController *controller =  [[BreedViewController alloc]init];
            controller.index = i;
            controller.keyString = self.titles[i];
            controller.classifyArray = self.classifyArray;
            controller.title = self.titles[i];
            
            [self addChildViewController:controller];
            [self.childViewControllers addObject:controller];
        }
    }
    if (self.pageMenu.selectedItemIndex < self.childViewControllers.count) {
        UIViewController *viewController = self.childViewControllers[self.pageMenu.selectedItemIndex];
        [self.scrollView addSubview:viewController.view];
        viewController.view.frame = CGRectMake(ScreenWidth*self.pageMenu.selectedItemIndex, 0, ScreenWidth, self.viewFrame);
        self.scrollView .contentOffset = CGPointMake(ScreenWidth*self.pageMenu.selectedItemIndex, 0);
        self.scrollView .contentSize = CGSizeMake(self.titles.count*ScreenWidth, 0);
    }
}

- (UIButton *)channelManageButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button addTarget:self action:@selector(jumpClassify) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"unfold"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(5, 7, 5, 7)];
    return button;
}

#pragma mark - SPPageMenu的代理方法

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    NSLog(@"%zd",index);
}

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSLog(@"%zd------->%zd",fromIndex,toIndex);
    // 如果该代理方法是由拖拽self.scrollView而触发，说明self.scrollView已经在用户手指的拖拽下而发生偏移，此时不需要再用代码去设置偏移量，否则在跟踪模式为SPPageMenuTrackerFollowingModeHalf的情况下，滑到屏幕一半时会有闪跳现象。闪跳是因为外界设置的scrollView偏移和用户拖拽产生冲突
    if (!self.scrollView.isDragging) { // 判断用户是否在拖拽scrollView
        // 如果fromIndex与toIndex之差大于等于2,说明跨界面移动了,此时不动画.
        if (labs(toIndex - fromIndex) >= 2) {
            [self.scrollView setContentOffset:CGPointMake(ScreenWidth * toIndex, 0) animated:NO];
        } else {
            [self.scrollView setContentOffset:CGPointMake(ScreenWidth * toIndex, 0) animated:YES];
        }
    }
    
    
    if (toIndex != 0) {
        //移除所有观察者
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self.pageMenu setBackgroundColor:[UIColor whiteColor]];
        self.pageMenu.unSelectedItemTitleColor = [UIColor blackColor];
        self.pageMenu.selectedItemTitleColor = [UIColor blackColor];
        [self.tempView setBackgroundColor:WHITE];
        [self.barVeiw setBgColor:WHITE];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATIONCHANGEEND object:nil userInfo:nil];
        [self.pageMenu.dividingLine setHidden:NO];
        [pageMenu setFunctionButtonContent:[UIImage imageNamed:@"fenlei"] forState:UIControlStateNormal];
    }else{
        
        if (self.notificationEndFlag == NO) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATIONCHANGEBEGIN object:nil userInfo:nil];
            
            [pageMenu setFunctionButtonContent:[UIImage imageNamed:@"baikuang"] forState:UIControlStateNormal];
        }
        [self.pageMenu.dividingLine setHidden:YES];
    }
    
    
    if (self.childViewControllers.count <= toIndex) {return;}
    
    UIViewController *targetViewController = self.childViewControllers[toIndex];
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;
    
    targetViewController.view.frame = CGRectMake(ScreenWidth * toIndex, 0, ScreenWidth, self.viewFrame);
    [_scrollView addSubview:targetViewController.view];
    
}

- (void)pageMenu:(SPPageMenu *)pageMenu functionButtonClicked:(UIButton *)functionButton {
    [self.tabBarController setSelectedIndex:1];
}

#pragma mark - action
/**
 *跳转分类
 */
-(void)jumpClassify{
    [self.tabBarController setSelectedIndex:1];
}

-(void)jumpSearchPage{
    [self.tabBarController setSelectedIndex:2];
}

-(void)jumpInfoPage{
    //跳转消息页面
    User * user = [[DataManager shareInstance] getUser];
    if (user == nil || user.loginState == NO) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        InfoViewController *infoVC = [[InfoViewController alloc]init];
        [self.navigationController pushViewController:infoVC animated:YES];
    }
}

#pragma mark - action

-(void)changeColors:(NSNotification *)notification{
    
    NSDictionary *dic = notification.userInfo;
    UIColor *currColor = dic[@"bgColor"];
    self.pageMenu.unSelectedItemTitleColor = [UIColor whiteColor];
    self.pageMenu.backgroundColor = currColor;
    self.pageMenu.selectedItemTitleColor = [UIColor whiteColor];
    
    [self.barVeiw setBgColor:currColor];
    
    [self.tempView setBackgroundColor:currColor];
    
    [self.pageMenu setFunctionButtonContent:[UIImage imageNamed:@"baikuang"] forState:UIControlStateNormal];
    
}

-(void)changeColorsEnd:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    
    self.notificationEndFlag = YES;
    [self.pageMenu setFunctionButtonContent:[UIImage imageNamed:@"fenlei"] forState:UIControlStateNormal];
    //移除所有观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //
    UIColor *currColor = dic[@"bgColor"];
    self.pageMenu.backgroundColor = currColor;
    self.pageMenu.unSelectedItemTitleColor = [UIColor blackColor];
    self.pageMenu.selectedItemTitleColor = [UIColor blackColor];
    [self.tempView setBackgroundColor:WHITE];
    [self.barVeiw setBgColor:WHITE];
}



#pragma mark - getter / setter


-(SearchBarView *)barVeiw{
    if (_barVeiw == nil) {
        CGFloat stateH = [[UIApplication sharedApplication] statusBarFrame].size.height;
        _barVeiw = [[SearchBarView alloc]initWithFrame:CGRectMake(0, stateH, ScreenWidth  - 53, 33)];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpSearchPage)];
        [_barVeiw addGestureRecognizer:tap];
    }
    return _barVeiw;
}

-(NewsView *)newsView{
    if (_newsView == nil) {
        
        CGFloat y = CGRectGetMinY(self.barVeiw.frame);
        CGFloat x = CGRectGetMaxX(self.barVeiw.frame);
        _newsView = [[NewsView alloc]initWithFrame:CGRectMake(x+11, y+3, 22, 22)];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpInfoPage)];
        [_newsView addGestureRecognizer:tap];
    }
    return _newsView;
}

- (NSMutableArray *)childViewControllers {
    if (_childViewControllers == nil) {
        _childViewControllers = [NSMutableArray array];
    }
    return _childViewControllers;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        
        CGFloat y = CGRectGetMaxY(self.barVeiw.frame);
        self.viewFrame =ScreenHeight -(y+40);
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40+y, ScreenWidth, self.viewFrame)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return  _scrollView;
}

-(UIView *)tempView{
    if (_tempView == nil) {
        CGFloat stateH = [[UIApplication sharedApplication] statusBarFrame].size.height;
        _tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, stateH+33)];
    }
    return _tempView;
}


@end
