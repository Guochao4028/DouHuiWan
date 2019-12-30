//
//  LQPhotoPickerViewController.m
//  LQPhotoPicker
//
//  Created by lawchat on 15/9/22.
//  Copyright (c) 2015年 Fillinse. All rights reserved.
//

#import "LQPhotoPickerViewController.h"
#import "LQPhotoViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "LQImgPickerActionSheet.h"
#import "JJPhotoManeger.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface LQPhotoPickerViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LQImgPickerActionSheetDelegate,JJPhotoDelegate>
{
    NSString *pushImgName;
    //添加图片提示
    UILabel *addImgStrLabel;
}

@property(nonatomic,strong) LQImgPickerActionSheet *imgPickerActionSheet;
@property(nonatomic,strong) UICollectionView *pickerCollectionView;
@property(nonatomic,assign) CGFloat collectionFrameY;
//图片选择器
@property(nonatomic,strong) UIViewController *showActionSheetViewController;

@end

@implementation LQPhotoPickerViewController

static NSString * const reuseIdentifier = @"LQPhotoViewCell";

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (!_showActionSheetViewController) {
            _showActionSheetViewController = self;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)LQPhotoPicker_initPickerView{
    
    _showActionSheetViewController = self;
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((ScreenWidth - 50) / 4, (ScreenWidth - 50) / 4);
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    
    self.pickerCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 120) collectionViewLayout:layout];
    [_LQPhotoPicker_superView addSubview:self.pickerCollectionView];


    self.pickerCollectionView.delegate = self;
    self.pickerCollectionView.dataSource = self;
    self.pickerCollectionView.backgroundColor = [UIColor whiteColor];
    
    if(_LQPhotoPicker_smallImageArray.count == 0)
    {
        _LQPhotoPicker_smallImageArray = [NSMutableArray array];
    }
    if(_LQPhotoPicker_bigImageArray.count == 0)
    {
        _LQPhotoPicker_bigImageArray = [NSMutableArray array];
    }
    pushImgName = @"plus.png";
    
    _pickerCollectionView.scrollEnabled = NO;
    
    if (_LQPhotoPicker_imgMaxCount <= 0) {
        _LQPhotoPicker_imgMaxCount = 10;
    }
    
    //添加图片提示
//    addImgStrLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 70, 20)];
//    addImgStrLabel.text = @"添加图片";
//    addImgStrLabel.font = [UIFont systemFontOfSize:14];
//    addImgStrLabel.textColor = [Utilities getColor:@"666666"];
//    addImgStrLabel.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.82 alpha:1];
//    [self.pickerCollectionView addSubview:addImgStrLabel];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _LQPhotoPicker_smallImageArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    // Register nib file for the cell
    UINib *nib = [UINib nibWithNibName:@"LQPhotoViewCell" bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"LQPhotoViewCell"];
    // Set up the reuse identifier
    LQPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"LQPhotoViewCell" forIndexPath:indexPath];

    if (indexPath.row == _LQPhotoPicker_smallImageArray.count) {
        [cell.profilePhoto setImage:[UIImage imageNamed:pushImgName]];
        cell.closeButton.hidden = YES;
        
        //没有任何图片
        if (_LQPhotoPicker_smallImageArray.count == 0) {
            addImgStrLabel.hidden = NO;
        }
        else{
            addImgStrLabel.hidden = YES;
        }
    }
    else{
        [cell.profilePhoto setImage:_LQPhotoPicker_smallImageArray[indexPath.item]];
        cell.closeButton.hidden = NO;
    }
    [cell setBigImgViewWithImage:nil];
    cell.profilePhoto.tag = [indexPath item];
    
    //添加图片cell点击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    cell.profilePhoto.userInteractionEnabled = YES;
    [cell.profilePhoto  addGestureRecognizer:singleTap];
    

    cell.closeButton.tag = [indexPath item];
    [cell.closeButton addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    
    [self changeCollectionViewHeight];
    return cell;
}


#pragma mark - 图片cell点击事件
- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer{
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    
    if (index == (_LQPhotoPicker_smallImageArray.count)) {
        [self.view endEditing:YES];
        //添加新图片
        [self addNewImg];
    }
    else{
        //点击放大查看
        LQPhotoViewCell *cell = (LQPhotoViewCell*)[_pickerCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        if (!cell.BigImgView || !cell.BigImgView.image) {

            [cell setBigImgViewWithImage:[self getBigIamgeWithALAsset:_LQPhotoPicker_selectedAssetArray[index]]];
        }
        
        JJPhotoManeger *mg = [JJPhotoManeger maneger];
        mg.delegate = self;
        [mg showLocalPhotoViewer:@[cell.BigImgView] selecImageindex:0];
    }
}

#pragma mark - 选择图片
- (void)addNewImg{
    
    if (_LQPhotoPicker_smallImageArray.count == _LQPhotoPicker_imgMaxCount) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                             
                                                      message:@"选择图片数量已达上限"
                             
                                                     delegate:nil
                             
                                            cancelButtonTitle:@"知道了"
                             
                                            otherButtonTitles:nil];  
        
        [alert show];
        return;
    }
    
    if (!_imgPickerActionSheet) {
        
        _imgPickerActionSheet = [[LQImgPickerActionSheet alloc] init];
        _imgPickerActionSheet.delegate = self;
    }
    
    if (_LQPhotoPicker_selectedAssetArray) {
        _imgPickerActionSheet.arrSelected = _LQPhotoPicker_selectedAssetArray;
    }
    
    _imgPickerActionSheet.maxCount = _LQPhotoPicker_imgMaxCount;
    
    [_imgPickerActionSheet showImgPickerActionSheetInView:_showActionSheetViewController];
}

#pragma mark - 删除照片
- (void)deletePhoto:(UIButton *)sender{
    
    [_LQPhotoPicker_smallImageArray removeObjectAtIndex:sender.tag];
    [_LQPhotoPicker_selectedAssetArray removeObjectAtIndex:sender.tag];

    
    [self.pickerCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]]];
    
    for (NSInteger item = sender.tag; item <= _LQPhotoPicker_smallImageArray.count; item++) {
        LQPhotoViewCell *cell = (LQPhotoViewCell*)[self.pickerCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0]];
        cell.closeButton.tag--;
        cell.profilePhoto.tag--;
    }
    //没有任何图片
    if (_LQPhotoPicker_smallImageArray.count == 0) {
        addImgStrLabel.hidden = NO;
    }
    else{
        addImgStrLabel.hidden = YES;
    }
    [self changeCollectionViewHeight];
}

#pragma mark - LQImgPickerActionSheetDelegate (返回选择的图片：缩略图，压缩原长宽比例大图)
- (void)getSelectImgWithALAssetArray:(NSArray*)ALAssetArray thumbnailImgImageArray:(NSArray*)thumbnailImgArray{
    
    //（ALAsset）类型 Array
    _LQPhotoPicker_selectedAssetArray = [NSMutableArray arrayWithArray:ALAssetArray];
    //正方形缩略图 Array
    _LQPhotoPicker_smallImageArray = [NSMutableArray arrayWithArray:thumbnailImgArray] ;
    
    [self.pickerCollectionView reloadData];
}

#pragma mark - 改变view，collectionView高度
- (void)changeCollectionViewHeight{
    
    if (_collectionFrameY) {
        _pickerCollectionView.frame = CGRectMake(0, _collectionFrameY, ScreenWidth, (((float)[UIScreen mainScreen].bounds.size.width-4.0) /4.0)* ((int)(_LQPhotoPicker_selectedAssetArray.count)/4 +1));
    }
    else{
        _pickerCollectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (((float)[UIScreen mainScreen].bounds.size.width-4.0) /4.0)* ((int)(_LQPhotoPicker_selectedAssetArray.count)/4 +1));
    }
    if (_LQPhotoPicker_delegate && [_LQPhotoPicker_delegate respondsToSelector:@selector(LQPhotoPicker_pickerViewFrameChanged)]) {
        [_LQPhotoPicker_delegate LQPhotoPicker_pickerViewFrameChanged];
    }
}

- (void)LQPhotoPicker_updatePickerViewFrameY:(CGFloat)Y{
    
    _collectionFrameY = Y;
    _pickerCollectionView.frame = CGRectMake(0, Y, [UIScreen mainScreen].bounds.size.width, (((float)[UIScreen mainScreen].bounds.size.width-4.0) /4.0)* ((int)(_LQPhotoPicker_selectedAssetArray.count)/4 +1)+20.0);
}

#pragma mark - 防止奔溃处理
-(void)photoViwerWilldealloc:(NSInteger)selecedImageViewIndex
{
    NSLog(@"最后一张观看的图片的index是:%zd",selecedImageViewIndex);
}

- (NSData*)getBigIamgeDataWithALAsset:(ALAsset*)set{
    UIImage *img = [UIImage imageWithCGImage:set.defaultRepresentation.fullResolutionImage
                                       scale:set.defaultRepresentation.scale
                                 orientation:(UIImageOrientation)set.defaultRepresentation.orientation];
    
    return UIImageJPEGRepresentation(img, 0.5);
}
- (UIImage*)getBigIamgeWithALAsset:(ALAsset*)set{
    //压缩
    // 需传入方向和缩放比例，否则方向和尺寸都不对
    NSData *imageData = [self getBigIamgeDataWithALAsset:set];
    
    [_LQPhotoPicker_bigImgDataArray addObject:imageData];
    
    return [UIImage imageWithData:imageData];
}

- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}



#pragma mark - 获得选中图片各个尺寸
- (NSMutableArray*)LQPhotoPicker_getALAssetArray{
    return _LQPhotoPicker_selectedAssetArray;
}

- (NSMutableArray*)LQPhotoPicker_getBigImageArray{
    
    if (_LQPhotoPicker_bigImageArray.count <= 0) {
        _LQPhotoPicker_bigImageArray = [NSMutableArray array];
        _LQPhotoPicker_bigImgDataArray = [NSMutableArray array];
        for (ALAsset *set in _LQPhotoPicker_selectedAssetArray) {
            [_LQPhotoPicker_bigImageArray addObject:[self getBigIamgeWithALAsset:set]];
        }
    }
    return _LQPhotoPicker_bigImageArray;
}

- (NSMutableArray*)LQPhotoPicker_getBigImageDataArray{
    if (_LQPhotoPicker_bigImgDataArray<=0) {
        _LQPhotoPicker_bigImageArray = [NSMutableArray array];
        _LQPhotoPicker_bigImgDataArray = [NSMutableArray array];
        for (ALAsset *set in _LQPhotoPicker_selectedAssetArray) {
            [_LQPhotoPicker_bigImageArray addObject:[self getBigIamgeWithALAsset:set]];
        }
    }

    return _LQPhotoPicker_bigImgDataArray;
}

- (NSMutableArray*)LQPhotoPicker_getSmallImageArray{
    return _LQPhotoPicker_smallImageArray;
}
- (NSMutableArray*)LQPhotoPicker_getSmallDataImageArray{
    if (_LQPhotoPicker_smallDataImageArray.count<=0) {
        _LQPhotoPicker_smallDataImageArray = [NSMutableArray array];
        for (UIImage *smallImg in _LQPhotoPicker_smallImageArray) {
            NSData *smallImgData = UIImagePNGRepresentation(smallImg);
            [_LQPhotoPicker_smallDataImageArray addObject:smallImgData];
        }
    }
    return _LQPhotoPicker_smallDataImageArray;
}
- (CGRect)LQPhotoPicker_getPickerViewFrame{
    return self.pickerCollectionView.frame;
}
@end
