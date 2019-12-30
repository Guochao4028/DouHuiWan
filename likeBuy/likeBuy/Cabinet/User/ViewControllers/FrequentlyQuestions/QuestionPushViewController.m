//
//  QuestionPushViewController.m
//  likeBuy
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "QuestionPushViewController.h"
#import "NavigationView.h"
#import "QuestionsView.h"
#import "QuestionListDataModel.h"



@interface QuestionPushViewController ()<NavigationViewDelegate>

@property(nonatomic, strong)NavigationView *navigationView;

@property(nonatomic, strong)QuestionsView *qusertionsView;


@end

@implementation QuestionPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self initUI];
}

-(void)initUI{
    
    [self.view addSubview:self.navigationView];
    [self.navigationView setTitleStr:@"常见问题"];
    
    [self.view addSubview:self.qusertionsView];
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

-(QuestionsView *)qusertionsView{
    if (_qusertionsView == nil) {
        
        CGFloat y = CGRectGetMaxY(self.navigationView.frame);
        
        _qusertionsView = [[QuestionsView alloc]initWithFrame:CGRectMake(0, y, ScreenWidth, ScreenHeight - y)];
    }
    return _qusertionsView;
}

-(void)setModel:(QuestionListDataModel *)model{
    
    [self.qusertionsView setModel:model];
    
}

@end
