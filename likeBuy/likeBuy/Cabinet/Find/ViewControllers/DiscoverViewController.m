//
//  DiscoverViewController.m
//  likeBuy
//
//  Created by mac on 2019/10/22.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "DiscoverViewController.h"
#import "RecommendModel.h"
#import "DiscoverTableViewCell.h"
#import "InstallmentWebViewController.h"
#import "WebViewController.h"
#import "LoginViewController.h"
#import "GoodsModel.h"
#import "DetailViewController.h"
#import "GoodsDetailModel.h"

#import "GKPhoto.h"

#import "GKPhotoBrowser.h"

#import "CWActionSheet.h"

#import <Photos/Photos.h>
#import "WebViewController.h"

static NSString *const kDiscoverTableViewCellIdentifier = @"DiscoverTableViewCell";

@interface DiscoverViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, DiscoverTableViewCellDelegate, GKPhotoBrowserDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic, strong)UITableView *jingXuanTabelView;

@property (nonatomic, strong)UITableView *haoHuoTabelView;

@property (nonatomic, assign) BOOL isSelectIndex;

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, strong)NSString *currentPage;

@property(nonatomic, copy)NSString *min_id;

@property(nonatomic, copy)NSString *shareString;

@property(nonatomic, strong)NSMutableArray *photos;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(renovate) name:RENOVATE object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    
    if (self.dataArray.count == 0 || self.dataArray == nil) {
        [self initData];
    }
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [super viewWillAppear:animated];
}

#pragma mark - data
-(void)initData{
    
    self.dataArray = [NSMutableArray array];
    
    [MBProgressHUD showActivityMessageInWindow:nil];
    
    self.currentPage = @"1";
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    User *user = [[DataManager shareInstance]getUser];
    if (user != nil) {
        [param setObject:user.appToken forKey:@"appToken"];
    }
    
    [param setObject:@"ios" forKey:@"deviceOs"];
    [param setObject:@"2" forKey:@"pageSize"];
    [param setObject:@"1" forKey:@"pageNo"];
    
    
    [[DataManager shareInstance]getFeaturedCpy:param callBack:^(NSObject *object) {
        
        [MBProgressHUD hideHUD];
        
        Message *tem = (Message *)object;
        
        NSInteger code =  [tem.code integerValue];
        if (code == 0) {
            self.dataArray = [NSMutableArray arrayWithArray:tem.modelList];
            self.min_id = tem.reason;
            [self.jingXuanTabelView reloadData];
        }else{
            if (code == 1) {
                //"请淘宝授权"
//                InstallmentWebViewController *webVC = [[InstallmentWebViewController alloc]init];
//                [self presentViewController:webVC animated:YES completion:nil];
                
                
                [[DataManager shareInstance]taobaobendiAuthorizationParentController:self callBack:^(NSObject *object) {
                    
                    if (object != nil) {
                        WebViewController* webVC = [[WebViewController alloc] init];
                            
                        [self presentViewController:webVC animated:YES completion:nil];
                    }
                }];
                
            }else if (code == 2) {
                //"用户未登录"
                LoginViewController *login = [[LoginViewController alloc]init];
                [login setIsPresent:YES];
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
                [self presentViewController:nav animated:YES completion:nil];
                
            }else if (code == 3) {
                // "未查询到数据"
                 [MBProgressHUD wj_showError:tem.reason];
            }
        }
    }];
}

#pragma mark - UI
-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.jingXuanTabelView];
    //    [self.scrollView addSubview:self.haoHuoTabelView];
}

-(void)loadingData{
    
    NSInteger cp = [self.currentPage integerValue];
    cp++;
    self.currentPage = [NSString stringWithFormat:@"%ld",(long)cp];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    User *user = [[DataManager shareInstance]getUser];
    if (user != nil) {
        [param setObject:user.appToken forKey:@"appToken"];
    }
    if (self.min_id != nil) {
        [param setObject:self.min_id forKey:@"pageNo"];
    }else{
        [param setObject:@"1" forKey:@"pageNo"];
    }
    
    [param setObject:@"ios" forKey:@"deviceOs"];
    [param setObject:@"2" forKey:@"pageSize"];
    
    [[DataManager shareInstance]getFeaturedCpy:param callBack:^(NSObject *object) {
        Message *tem = (Message *)object;
        NSInteger code =  [tem.code integerValue];
        if (code == 0) {
            [self.dataArray addObjectsFromArray:tem.modelList];
            [self.jingXuanTabelView reloadData];
            self.min_id = tem.reason;
        }else{
            if (code == 1) {
                //"请淘宝授权"
                [[DataManager shareInstance]taobaobendiAuthorizationParentController:self callBack:^(NSObject *object) {
                    NSLog(@"object : %@", object);
                }];
            }else if (code == 2) {
                //"用户未登录"
                LoginViewController *login = [[LoginViewController alloc]init];
                [login setIsPresent:YES];
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
                
                [self presentViewController:nav animated:YES completion:nil];
                
            }else if (code == 3) {
                // "未查询到数据"
                [MBProgressHUD wj_showError:tem.reason];
            }
        }
        
        [self.jingXuanTabelView.mj_footer endRefreshing];
    }];
}

#pragma mark -  UITableViewDelegate & UITableViewDataSource


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.jingXuanTabelView) {
        return self.dataArray.count;
    }
    return 10;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.jingXuanTabelView) {
        RecommendModel *model = self.dataArray[indexPath.row];
        return model.tableViewH;
    }
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDiscoverTableViewCellIdentifier];
    
    [cell setIndexPath:indexPath];
    
    [cell setDelegate:self];
    
    [cell setModel:self.dataArray[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendModel *model = self.dataArray[indexPath.row];
    
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    
    GoodsModel *goods = [[GoodsModel alloc]init];
    goods.numIid = model.itemid;
    goods.title = model.itemshorttitle;
    
    detailVC.model = goods;
    detailVC.isHomePage = YES;
    
    detailVC.flgs = @"1";
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    [self.tabBarController.tabBar setHidden:YES];
    
}

#pragma mark - DiscoverTableViewCellDelegate
-(void)tapView:(NSIndexPath *)indexPath{
    RecommendModel *model = self.dataArray[indexPath.row];
    
    User *user = [[DataManager shareInstance]getUser];
    NSString *appToken = user.appToken;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:model.itemid forKey:@"mid"];
    
    [dic setObject:@"ios" forKey:@"deviceOs"];
    if (appToken != nil) {
        [dic setObject:appToken forKey:@"appToken"];
    }
    if(model.tkrates != nil){
        [dic setObject:model.tkrates forKey:@"rebateAmount"];
    }
    [[DataManager shareInstance]getGoodsDetailsParame:dic callBack:^(NSObject *object) {
        
        if (object != nil) {
            if ([object isKindOfClass:[Message class]] == YES) {
            }else{
                GoodsDetailModel *temp = (GoodsDetailModel *)object;
                
                NSString *str = [model.cText stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
                
                NSMutableString *mutableStr = [[NSMutableString alloc]initWithFormat:@"%@\n", str];
                
                if (temp.title.length > 0) {
                    [mutableStr appendString:[NSString stringWithFormat:@"%@\n", temp.title]];
                }
                
                if (temp.itemDescription.length > 0) {
                    [mutableStr appendString:[NSString stringWithFormat:@"%@\n", temp.itemDescription]];
                }
                
                if (temp.zkFinalPrice.length > 0) {
                    [mutableStr appendString:[NSString stringWithFormat:@"【折扣价】%@元\n", temp.zkFinalPrice]];
                }
                
                if (temp.couponAfterPrice.length > 0) {
                    [mutableStr appendString:[NSString stringWithFormat:@"【券后价】%@元\n", temp.couponAfterPrice]];
                }
                
                [mutableStr appendString:@"-----------------\n"];
                   
                   [mutableStr appendString:[NSString stringWithFormat:@"请在APP商城搜索 【豆会玩】\n【邀请码】%@\n", user.selfResqCode]];
                    [mutableStr appendString:@"-----------------\n"];
                
                [mutableStr appendString:[NSString stringWithFormat:@"长按復·制这段描述，%@，打开【📱taobao】即可抢购",temp.couponTpwd]];
                
                
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = mutableStr;
                [MBProgressHUD wj_showSuccess:@"复制成功"];
            }
        }
    }];
}

-(void)tapGoodsImageWithGoodsItem:(NSIndexPath *)indexPath andTableViewCellIndexPath:(nonnull NSIndexPath *)cellIndexPath{
    
    
    self.photos = [NSMutableArray array];
    
    RecommendModel *model = [self.dataArray objectAtIndex:cellIndexPath.row];
    
    NSArray *images = model.pics;
    
    [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GKPhoto *photo = [[GKPhoto alloc]init];
        photo.url = [NSURL URLWithString:obj];
        [self.photos addObject:photo];
    }];
    
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:self.photos currentIndex:indexPath.row];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    browser.isAdaptiveSafeArea = YES;
    browser.delegate = self;
    [browser showFromVC:self];
}

#pragma mark -  GKPhotoBrowserDelegate
- (void)photoBrowser:(GKPhotoBrowser *)browser longPressWithIndex:(NSInteger)index{
    NSArray *title = @[@"保存图片"];
    CWActionSheet *sheet = [[CWActionSheet alloc] initWithTitles:title clickAction:^(CWActionSheet *sheet, NSIndexPath *indexPath) {
        [self saveBigPic:index];
    }];
    [sheet show];
}

-(void)saveBigPic:(NSInteger)index{
    GKPhoto *photo = self.photos[index];
    UIImage *tem = photo.image;
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
            {
                // 用户拒绝，跳转到自定义提示页面
                [MBProgressHUD wj_showError:@"您已拒绝，请开启权限"];
            }
            else if (status == PHAuthorizationStatusAuthorized)
            {
                // 用户授权，弹出相册对话框
                NSLog(@"用户同意");
                [[PHPhotoLibrary sharedPhotoLibrary]performChanges:^{
                    [PHAssetChangeRequest creationRequestForAssetFromImage:tem];
                } completionHandler:^(BOOL success, NSError * _Nullable error) {
                    if (error) {
                        //                                [MBProgressHUD wj_showError:@"保存失败"];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [MBProgressHUD showWarnMessage:@"保存失败"];
                        });
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [MBProgressHUD showWarnMessage:@"保存成功"];
                        });
                    }
                }];
            }
        });
    }];
    
    
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isSelectIndex = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 为了横向滑动的时候，外层的tableView不动
    if (!self.isSelectIndex) {
        //        self.tableView.scrollEnabled = NO;
    }
}


#pragma mark - DiscoverTitleViewDelegate
-(void)selectedItem:(NSUInteger)index{
    [self.scrollView setContentOffset:CGPointMake(index*ScreenWidth, 0) animated:YES];
}
#pragma mark - setter / getter

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        CGFloat stateH = [[UIApplication sharedApplication] statusBarFrame].size.height;

        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-(stateH+40))];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 1, _scrollView.frame.size.height);
    }
    return _scrollView;
}

-(UITableView *)jingXuanTabelView{
    if (_jingXuanTabelView == nil) {
        _jingXuanTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0 * ScreenWidth, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
        _jingXuanTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_jingXuanTabelView registerClass:[DiscoverTableViewCell class] forCellReuseIdentifier:kDiscoverTableViewCellIdentifier];
        [_jingXuanTabelView setDelegate:self];
        [_jingXuanTabelView setDataSource:self];
        
         [_jingXuanTabelView setBackgroundColor:WHITE];
        
        MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadingData)];
        
        _jingXuanTabelView.mj_footer = footer;
    }
    return _jingXuanTabelView;
}


-(void)renovate{
    [self initData];
}



@end
