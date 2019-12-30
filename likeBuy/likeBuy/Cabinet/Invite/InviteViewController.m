//
//  InviteViewController.m
//  likeBuy
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "InviteViewController.h"
#import "CWActionSheet.h"
#import "ShareModel.h"
#import "NavigationView.h"
#import "UIImage+Tool.h"
#import "InviteDetailView.h"

@interface InviteViewController ()<NavigationViewDelegate>

@property(nonatomic, strong)UIImageView *imageView;

@property(nonatomic, strong)InviteDetailView *inviteDetailView;

@property(nonatomic, strong)NavigationView *navigationView;

@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [self initData];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}


#pragma mark - UI
-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.inviteDetailView];
    
    NSString *string = [[NSUserDefaults standardUserDefaults]objectForKey:@"qrcode"];
    [self.inviteDetailView setCodeStr:string];
    
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongChick:)];
    
    [self.inviteDetailView addGestureRecognizer:longPress];
    
    [self.navigationView setTitleStr:@"邀请"];
}

-(void)initData{
    User *user = [[DataManager shareInstance]getUser];
    [self.inviteDetailView setYaoqingmaStr:user.selfResqCode];
    
    
}

-(void)share:(NSInteger)number{
    UIImage *temp = [UIImage snapshotWithView:self.inviteDetailView];
//    UIImage *img = [UIImage compressImage:temp toByte:32678];
    NSData *imageData = [temp newCompressImage:temp toByte:32678];
    
    if (number == 0) {
        NSLog(@"点击了分享到朋友圈");
        [ShareModel shareToWeChatToTimeline:imageData];
    }else{
        NSLog(@"点击了分享邀请海报");
        [ShareModel shareToWeChatToSession:imageData];
    }
}



#pragma mark - action

-(void)LongChick:(UILongPressGestureRecognizer*)sender{
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSArray *title = @[@"分享到朋友圈", @"分享邀请海报"];
        CWActionSheet *sheet = [[CWActionSheet alloc] initWithTitles:title clickAction:^(CWActionSheet *sheet, NSIndexPath *indexPath) {
            [self share:indexPath.row];
        }];
        [sheet show];
    }
}

#pragma mark - NavigationViewDelegate

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - getter/setter



-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_navigationView setDelegate:self];
    }
    return _navigationView;
}

-(void)setIsPush:(BOOL)isPush{
    _isPush = isPush;
    if (isPush == YES) {
        [self.view addSubview:self.navigationView];
        [self.inviteDetailView setFrame:CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.navigationView.frame))];
    }
}

-(InviteDetailView *)inviteDetailView{
    if (_inviteDetailView == nil) {
        CGFloat height = [[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? [[UIApplication sharedApplication] statusBarFrame].size.height : 0;
        
        CGFloat barFrameHeight = [[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49;
        
        _inviteDetailView = [[InviteDetailView alloc]initWithFrame:CGRectMake(0, height, ScreenWidth, ScreenHeight - height - barFrameHeight)];
        
    }
    return _inviteDetailView;
}

@end
