//
//  NavigationView.m
//  likeBuy
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "NavigationView.h"
#import "DBManager.h"

@interface NavigationView ()

@property(nonatomic, assign)NavigationType navigationType;
@property (strong, nonatomic) IBOutlet UIView *normalNavigationView;
@property (weak, nonatomic) IBOutlet UIImageView *glassImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)backAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *glassButton;
@property (strong, nonatomic) IBOutlet UIView *capitalView;
@property (weak, nonatomic) IBOutlet UILabel *capitalLabel;
@property (weak, nonatomic) IBOutlet UIView *redPoint;
@property (weak, nonatomic) IBOutlet UIImageView *meaggeImageView;


- (IBAction)messageAction:(UIButton *)sender;

@property (weak, nonatomic) UIView *baseView;

@property(nonatomic, assign)BOOL isViewRed;

@end

@implementation NavigationView

-(instancetype)initWithFrame:(CGRect)frame type:(NavigationType)type{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"NavigationView" owner:self options:nil];
        self.backgroundColor = [UIColor whiteColor];
        self.navigationType = type;
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    switch (self.navigationType) {
        case NavigationNormalView:
            self.baseView = self.normalNavigationView;
            break;
        case NavigationDaXie:
            self.baseView = self.capitalView;
            break;
        default:
            self.baseView = self.normalNavigationView;
            break;
    }
    
    [self.baseView  setFrame:self.bounds];
    [self addSubview:self.baseView];
    
    if (self.navigationType != NavigationHasGlassView) {
        [self.glassImageView setHidden:YES];
        [self.glassButton setHidden:YES];
    }else{
        [self.glassImageView setHidden:NO];
        [self.glassButton setHidden:NO];
        [self.glassButton addTarget:self action:@selector(tapGlassAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.redPoint.layer setMasksToBounds:YES];
    self.redPoint.layer.cornerRadius = 4;
     NSString *isRedView = [[DBManager shareInstance]isRedView];
    if (isRedView != nil) {
           BOOL isRedFlag = [isRedView boolValue];
           [self.redPoint setHidden:!isRedFlag];
       }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isRedPoint:) name:NOTIFICATIONREDPOINT object:nil];
    
}

#pragma mark - action

- (IBAction)backAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(back)]) {
        [self.delegate back];
    }
}

-(void)tapGlassAction{
    if([self.delegate respondsToSelector:@selector(jumpSearchView)]){
        [self.delegate jumpSearchView];
    }
}

- (IBAction)messageAction:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(jumpMessageView)]){
        [self.delegate jumpMessageView];
    }
}

-(void)isRedPoint:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    NSString *redPoint = dic[@"isRedPoint"];
    [[DBManager shareInstance]setIsRedView:redPoint];
    BOOL isRedPoint = [redPoint boolValue];
    [self.redPoint setHidden:!isRedPoint];
}

#pragma mark - getter / setter
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    [self.titleLabel setText:titleStr];
}

-(void)setDaxieTitleStr:(NSString *)daxieTitleStr{
    _daxieTitleStr = daxieTitleStr;
    [self.capitalLabel setText:daxieTitleStr];
}

-(void)setIsClearColor:(BOOL)isClearColor{
    if (isClearColor == YES) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self.baseView setBackgroundColor:[UIColor clearColor]];
    }
}

-(void)setIsViewMeage:(BOOL)isViewMeage{
    
    _isViewMeage = isViewMeage;
    
    [self.meaggeImageView setHidden:!isViewMeage];
    [self.redPoint setHidden:!isViewMeage];
}

//-(void)dealloc{}

@end
