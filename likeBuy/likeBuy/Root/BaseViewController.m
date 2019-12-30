//
//  BaseViewController.m
//  likeBuy
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UINavigationBarDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:WHITE];
}

-(void)viewWillAppear:(BOOL)animated{
    self.fd_prefersNavigationBarHidden = YES;
//    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillAppear:animated];
   
    self.navigationController.delegate = self;
}

-(void)initUI{
    
}

-(void)initData{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (UIStatusBarStyle)preferredStatusBarStyle {
   
   if (@available(iOS 13.0, *)) {
      return UIStatusBarStyleDarkContent;
   }
   
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
 
    if(navigationController.viewControllers.count == 1){
        [self.tabBarController.tabBar setHidden:NO];
    }else{
        [self.tabBarController.tabBar setHidden:YES];
    }
}


@end
