//
//  SetupViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/20.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "SetupViewController.h"
#import "NavigationView.h"
#import "BSFitdpiUtil.h"
#import "SetUpTableViewCell.h"
#import "ModifyPhoneViewController.h"
#import "AboutUsViewController.h"
#import "PhoneLoginViewController.h"
#import "InstallmentWebViewController.h"
#import "WebViewController.h"
#import <AssetsLibrary/ALAsset.h>
#import <AVFoundation/AVFoundation.h>
#import "UIImage+Tool.h"
#import "DBManager.h"

static NSString *const kSetUpTableViewCellIdentifier = @"SetUpTableViewCell";

@interface SetupViewController ()<UITableViewDelegate, UITableViewDataSource, NavigationViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    
    UIImageView * img;
}

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NavigationView *navigationView;

@property(nonatomic, strong)UIButton *logoutButton;

@property(nonatomic, strong)NSArray *dataList;

@property(nonatomic, strong)UIImage *pView;

@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishLogin:) name:NOTIFICATIONLOGIN object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    User *user = [[DataManager shareInstance]getUser];
    if (user != nil) {
        [[DataManager shareInstance]getCustomerInfo:@{@"appToken":user.appToken} callBack:^(NSObject *object) {
            [self.tableView reloadData];
        }];
    }
    [super viewWillAppear:animated];
}

#pragma mark - UI
-(void)initUI{
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"FAFAFA"]];
    [self.view addSubview:self.navigationView];
    [self.navigationView setTitleStr:@"设置"];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.logoutButton];
}

-(void)initData{
    
    BOOL isShowconfig = [DBManager shareInstance].isShowconfig;
    
    if (isShowconfig == YES) {
        self.dataList = @[
               @[
                   @{@"title":@"昵称", @"isReturn":@"0", @"isword":@"1", @"isImageView":@"0", @"isTextF":@"0", @"type":@"1",@"selecedType":@"1"},
                   @{@"title":@"绑定手机号", @"isReturn":@"1", @"isword":@"1", @"isImageView":@"0", @"isTextF":@"0", @"type":@"3",@"selecedType":@"2"},
                  // @{@"title":@"绑定微信号", @"isReturn":@"1", @"isword":@"1", @"isImageView":@"0", @"isTextF":@"0", @"type":@"4",@"selecedType":@"3"},
                   @{@"title":@"解绑淘宝授权", @"isReturn":@"1", @"isword":@"0", @"isImageView":@"0", @"isTextF":@"0", @"type":@"7",@"selecedType":@"4"}
               ],@[
                   @{@"title":@"关于我们", @"isReturn":@"1", @"isword":@"0", @"isImageView":@"0", @"isTextF":@"0", @"type":@"5",@"selecedType":@"5"},
                   @{@"title":@"清除缓存", @"isReturn":@"1", @"isword":@"1", @"isImageView":@"0", @"isTextF":@"0", @"type":@"6",@"selecedType":@"6"},
                   @{@"title":@"版本号", @"isReturn":@"0", @"isword":@"1", @"isImageView":@"0", @"isTextF":@"0", @"type":@"8",@"selecedType":@"7"}
               ]];
    }else{
        self.dataList = @[
               @[
                   @{@"title":@"头像", @"isReturn":@"1", @"isword":@"0", @"isImageView":@"1", @"isTextF":@"0",@"type":@"0", @"selecedType":@"0"},
                   @{@"title":@"昵称", @"isReturn":@"0", @"isword":@"1", @"isImageView":@"0", @"isTextF":@"0", @"type":@"1",@"selecedType":@"1"},
                   @{@"title":@"绑定手机号", @"isReturn":@"1", @"isword":@"1", @"isImageView":@"0", @"isTextF":@"0", @"type":@"3",@"selecedType":@"2"},
                   @{@"title":@"绑定微信号", @"isReturn":@"1", @"isword":@"1", @"isImageView":@"0", @"isTextF":@"0", @"type":@"4",@"selecedType":@"3"},
                   @{@"title":@"解绑淘宝授权", @"isReturn":@"1", @"isword":@"0", @"isImageView":@"0", @"isTextF":@"0", @"type":@"7",@"selecedType":@"4"}
               ],@[
                   @{@"title":@"关于我们", @"isReturn":@"1", @"isword":@"0", @"isImageView":@"0", @"isTextF":@"0", @"type":@"5",@"selecedType":@"5"},
                   @{@"title":@"清除缓存", @"isReturn":@"1", @"isword":@"1", @"isImageView":@"0", @"isTextF":@"0", @"type":@"6",@"selecedType":@"6"},
                   @{@"title":@"版本号", @"isReturn":@"0", @"isword":@"1", @"isImageView":@"0", @"isTextF":@"0", @"type":@"8",@"selecedType":@"7"}
               ]];
    }
   
}


#pragma mark -  UITableViewDelegate & UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 22;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 22;
    }
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *tem = self.dataList[section];
    
    return tem.count;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tableViewH = 60;
    return tableViewH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *modelArray = [self.dataList objectAtIndex:indexPath.section];
    
    SetUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSetUpTableViewCellIdentifier forIndexPath:indexPath];
    
    User *user = [[DataManager shareInstance]getUser];
    [cell setModel:[modelArray objectAtIndex:indexPath.row]];
    [cell setUser:user];
    [cell setImage:self.pView];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *tem = self.dataList[indexPath.section];
    NSDictionary *dic = tem[indexPath.row];
    NSString *selecedTypeStr = dic[@"selecedType"];
    NSInteger selecedType = [selecedTypeStr integerValue];
    
    switch (selecedType) {
        case 0:{
            UIAlertController *sheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                          
                          UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                          
                          UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                              AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                              
                              UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                              UIImagePickerController *  pickController = [[UIImagePickerController alloc]init];
                              if(authStatus == 2)
                              {
                                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请打开 设置-隐私-相机 来启用访问" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                                  [alertView show];
                              }else{
                                  if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
                                      pickController.editing = YES;
                                      pickController.allowsEditing = YES;
                                      pickController.delegate = self;
                                      pickController.sourceType = sourceType;
                                      
                                      [self presentViewController:pickController animated:YES completion:nil];
                                      
                                  }else{
                                      NSLog(@"相机功能不可用");
                                  }
                              }
                          }];
                          
                          UIAlertAction *potoAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                              
                              UIImagePickerController *  pickController = [[UIImagePickerController alloc]init];
                              pickController.editing = YES;
                              pickController.allowsEditing = YES;
                              
                              pickController.delegate = self;
                              pickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                              
                              [self presentViewController:pickController animated:YES completion:nil];
                          }];
                          
                          [sheetController addAction:okAction];
                          [sheetController addAction:potoAction];
                          [sheetController addAction:cancelAction];
                          [self presentViewController:sheetController animated:YES completion:nil];
        }
            break;
        case 1:{
            
        }
            break;
        case 2:{
            ModifyPhoneViewController *modifyPhoneVC = [[ModifyPhoneViewController alloc]init];
                          
                          [self.navigationController pushViewController:modifyPhoneVC animated:YES];
        }
            break;
        case 3:{

            User *user = [[DataManager shareInstance]getUser];
            if (user.wxPubOpenId == nil || user.wxPubOpenId.length == 0) {
                SendAuthReq* req =[[SendAuthReq alloc ] init];
                req.scope = @"snsapi_userinfo" ;
                req.state = @"123" ;
                [WXApi sendReq:req];
            }
        }
            break;
        case 4:{
            ModifyPhoneViewController *modifyPhoneVC = [[ModifyPhoneViewController alloc]init];
                           modifyPhoneVC.isUnbundling = YES;
                           
                           [self.navigationController pushViewController:modifyPhoneVC animated:YES];
        }
            break;
        case 5:{
            AboutUsViewController *aboutVC = [[AboutUsViewController alloc]init];
                           [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        case 6:{
            [MBProgressHUD showActivityMessageInWindow:nil];
            [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
                [MBProgressHUD hideHUD];
                [self.tableView reloadData];
            }];
        }
            break;
        case 7:{
            
        }
            break;
            
        default:
            break;
    }
    
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    UIImage *originalImage =  info[UIImagePickerControllerOriginalImage];
    
    
    CGSize size = CGSizeMake(640, 480);
    
    NSData *data;
    if (selectedImage !=nil) {
        //1:保存图片到本地
        self.pView = selectedImage;
        
        
        UIImage * compressImage = [UIImage compressImage:selectedImage scaleToSize:size];
        
        data = UIImageJPEGRepresentation(compressImage, 1.0);
        
        
    }else{
        
        UIImage * compressImage = [UIImage compressImage:originalImage scaleToSize:size];
        
        data = UIImageJPEGRepresentation(compressImage, 1.0);
        
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
    //发送到服务器
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [[DataManager shareInstance] uploadIcon:data callback:^(Message *message) {
        
        [hud hide:YES];
        
        if (message.isSuccess) {
            
            //2:更新界面
            MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
            //
            hud.mode = MBProgressHUDModeText;
            hud.labelText = message.reason;
            
            [hud hide:YES afterDelay:SHOWTIME];
            
            //更新用户数据
            User *user = [[DataManager shareInstance]getUser];
            [[DataManager shareInstance]getCustomerInfo:@{@"appToken":user.appToken} callBack:^(NSObject *object) {
                [self.tableView reloadData];
            }];
            
        }else{
            MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            //
            hud.mode = MBProgressHUDModeText;
            hud.labelText = message.reason;
            
            [hud hide:YES afterDelay:SHOWTIME];
        }
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



-(void)editedImage:(UIImage *)image
{
    self.pView = image;
    [self.tableView reloadData];
}


#pragma mark - NavigationViewDelegate

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - getter / setter

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, NavigatorHeight,ScreenWidth, 408) style:UITableViewStyleGrouped];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SetUpTableViewCell class]) bundle:nil] forCellReuseIdentifier:kSetUpTableViewCellIdentifier];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    }
    return _tableView;
}

-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_navigationView setDelegate:self];
    }
    return _navigationView;
}


-(UIButton *)logoutButton{
    if (_logoutButton == nil) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutButton setFrame:CGRectMake(15, CGRectGetMaxY(self.tableView.frame)+17, ScreenWidth - 34, 44)];
        [_logoutButton setBackgroundColor:[UIColor colorWithHexString:@"FB5754"]];
        [_logoutButton addTarget:self action:@selector(logout) forControlEvents:(UIControlEventTouchUpInside)];
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    }
    return _logoutButton;
}

-(void)logout{
    BOOL flag = [[DataManager shareInstance]clearUser];
    if (flag == YES) {
        [self.navigationController popViewControllerAnimated:YES];
        [self.tabBarController.tabBar setHidden:NO];
    }
}


-(void)finishLogin:(NSNotification *) notification{
    NSDictionary *dic = notification.userInfo;
    
    [[DataManager shareInstance]weixinAuthorization:dic callBack:^(NSDictionary *result) {
        NSString *str = result[@"type"];
        if ([str isEqualToString:@"message"] == YES) {
            Message *model = result[@"model"];
            
            if ([model.code isEqualToString:@"1"] == YES) {
                PhoneLoginViewController *phoneLoginVC = [[PhoneLoginViewController alloc]init];
                [self.navigationController pushViewController:phoneLoginVC animated:YES];
            }else{
                [MBProgressHUD wj_showError:model.reason toView:self.view];
            }
            
        }else if([str isEqualToString:@"user"] == YES){
            User *model = result[@"model"];
            if (model.tbUserId.length == 0 || model.relationId.length == 0) {
                //                InstallmentWebViewController *webVC = [[InstallmentWebViewController alloc]init];
                //                [self.navigationController pushViewController:webVC animated:YES];
                [[DataManager shareInstance]taobaobendiAuthorizationParentController:self callBack:^(NSObject *object) {
                    
                    if (object != nil) {
                        WebViewController* webVC = [[WebViewController alloc] init];
                        
                        [self presentViewController:webVC animated:YES completion:nil];
                    }
                }];
            }else{
                [self.tabBarController.tabBar setHidden:NO];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }else{
            [MBProgressHUD wj_showError:@"服务器连接失败"];
        }
    }];
    
}
- (void)dealloc {
    //移除所有观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
