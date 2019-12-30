//
//  CreateShareViewController.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/17.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "CreateShareViewController.h"
#import "GoodsDetailModel.h"
#import "NavigationView.h"
#import "UIImage+Tool.h"

#import "CreateShareHeardView.h"
#import "ShareCopyView.h"
#import "SharePicView.h"
#import "SharetoTextView.h"
#import "GenerateImageView.h"

#import "ShareModel.h"

#import <Photos/Photos.h>

#import "GKPhoto.h"

#import "GKPhotoBrowser.h"

#import "CWActionSheet.h"


@interface CreateShareViewController ()<NavigationViewDelegate, SharetoTextViewDelegate, SharePicViewDelegate, GKPhotoBrowserDelegate>

@property(nonatomic, strong)NavigationView *navigationView;

@property(nonatomic, strong)CreateShareHeardView *createShareHeardView;
@property(nonatomic, strong)ShareCopyView *shareCopyView;
@property(nonatomic, strong)SharePicView *sharePicView;
@property(nonatomic, strong)SharetoTextView *sharetoTextView;
@property(nonatomic, strong)GenerateImageView *generateImageView;

@property(nonatomic, strong)NSMutableArray *photos;

@property(nonatomic, strong)UIScrollView *scrollView;

@end

@implementation CreateShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.navigationView];
    [self.navigationView setTitleStr:@"创建分享"];
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.createShareHeardView];
    [self.scrollView addSubview:self.shareCopyView];
    [self.scrollView addSubview:self.sharePicView];
    [self.scrollView addSubview:self.sharetoTextView];
    
}

-(void)initData{
    
//    self.photos = [NSMutableArray array];
    
//    NSArray *images = self.model.smallImages;
//
//    [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        GKPhoto *photo = [[GKPhoto alloc]init];
//        photo.url = [NSURL URLWithString:obj];
//        [self.photos addObject:photo];
//    }];
}

-(NSArray *)getPic:(NSArray *)picStringArray{
//    NSMutableArray *array = [NSMutableArray array];
//    for (NSString *str in picStringArray) {
//        @autoreleasepool {
//            UIImageView *c = [[UIImageView alloc]init];
//            [c sd_setImageWithURL:[NSURL URLWithString:str]];
//            UIImage *temp = [UIImage compressImage:c.image toByte:32768 ];
//            [array addObject:temp];
//        }
//    }
    return picStringArray;
}

#pragma mark - NavigationViewDelegate
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SharetoTextViewDelegate
-(void)tapSavePic{
    NSArray *picArray = [self getPic:self.sharePicView.selectImgList];
    
    for (UIImage *image in picArray) {
        @autoreleasepool {
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
                            [PHAssetChangeRequest creationRequestForAssetFromImage:image];
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
    }
}

-(void)tapSendWeiXin{
    
    //微信只能分享一张图片所以取到图片数组时需要判断
    //如果是一张时，正常调微信分享
    //如果是多张，先合成一张图，调用微信分享
    
    NSArray *picArray = [self getPic:self.sharePicView.selectImgList];
    UIImage *img;
    if(picArray.count == 1){
        img = [picArray lastObject];
//        img = [UIImage compressImage:img toByte:32768];
        NSData *imageData = [img newCompressImage:img toByte:32768];
        [ShareModel shareToWeChatToSession:imageData];
    }else{
//        [self.generateImageView setModel:self.model];
//        UIImage *temp = [UIImage snapshotWithView:self.generateImageView];
//        img = [UIImage compressImage:temp toByte:32768];
        [self tapSavePic];
    }
    
    
    
}

-(void)tapSendPengyouquan{
    
    NSArray *picArray = [self getPic:self.sharePicView.selectImgList];
    UIImage *img;
    if(picArray.count == 1){
        img = [picArray lastObject];
//        img = [UIImage compressImage:img toByte:32768];
        NSData *imageData = [img newCompressImage:img toByte:32768];
        [ShareModel shareToWeChatToTimeline:imageData];
    }else{
//        [self.generateImageView setModel:self.model];
//        UIImage *temp = [UIImage snapshotWithView:self.generateImageView];
//        img = [UIImage compressImage:temp toByte:32768];
        [self tapSavePic];
    }
    
    
}

-(void)tapSendQQ{
    NSLog(@"tap qq");
}

-(void)tapSendQQZ{
    NSLog(@"tap qqz");

}

-(void)tapImage:(NSIndexPath *)indexPath{
    // 图片游览器
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

//保存放大图片
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

#pragma mark - getter / setter
-(NavigationView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigatorHeight) type:NavigationNormalView];
        [_navigationView setDelegate:self];
    }
    return _navigationView;
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.navigationView.frame))];
        _scrollView.pagingEnabled = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(ScreenWidth, 1130 - ScreenHeight);
        
    }
    return _scrollView;
}

-(CreateShareHeardView *)createShareHeardView{
    if (_createShareHeardView == nil) {
        _createShareHeardView = [[CreateShareHeardView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    }
    return _createShareHeardView;
}

-(ShareCopyView *)shareCopyView{
    if (_shareCopyView == nil) {
        _shareCopyView = [[ShareCopyView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.createShareHeardView.frame), ScreenWidth, 160)];
    }
    return _shareCopyView;
}

-(SharePicView *)sharePicView{
    if (_sharePicView == nil) {
        _sharePicView = [[SharePicView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shareCopyView.frame), ScreenWidth, 251)];
        [_sharePicView setDelegate:self];
    }
    return _sharePicView;
}

-(SharetoTextView *)sharetoTextView{
    if (_sharetoTextView == nil) {
        _sharetoTextView = [[SharetoTextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sharePicView.frame), ScreenWidth, 152)];
        [_sharetoTextView setDelegate:self];
    }
    return _sharetoTextView;
}

-(void)setModel:(GoodsDetailModel *)model{
    _model = model;
    
    self.photos = [NSMutableArray array];
    
    [self.createShareHeardView setShareHeardString:[NSString stringWithFormat:@"分享奖励¥%@", model.commissionRate]];
    
    NSMutableArray *tem = [NSMutableArray array];
    
    for (NSString *str in model.smallImages) {
        NSLog(@"str : %@", str);
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:str] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if (image != nil) {
                [tem addObject:image];
            }
        }];
    }
    [self.generateImageView setModel:model];
    
     UIImage *temp = [UIImage snapshotWithView:self.generateImageView];
    [tem insertObject:temp atIndex:0];
    
//    [self.sharePicView setDataSoucreArray:model.smallImages];
    [self.sharePicView setDataSoucreArray:tem];
    
    [self.photos removeAllObjects];
    
    [tem enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GKPhoto *photo = [[GKPhoto alloc]init];
        photo.image = obj;//[NSURL URLWithString:obj];
        [self.photos addObject:photo];
    }];
    
}

-(void)setShareString:(NSString *)shareString{
    [self.shareCopyView setLinkString:shareString];
}

-(GenerateImageView *)generateImageView{
    if(_generateImageView == nil){
        
        _generateImageView = [[GenerateImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 534)];
    }
    return _generateImageView;
}


@end
