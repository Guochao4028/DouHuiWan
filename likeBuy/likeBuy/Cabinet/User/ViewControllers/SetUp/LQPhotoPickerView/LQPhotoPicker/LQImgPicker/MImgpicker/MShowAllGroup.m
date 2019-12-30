//
//  MShowAllGroup.m
//  QQImagePicker
//
//  Created by mark on 15/9/11.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MShowAllGroup.h"
#import "MGroupTableViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MImaLibTool.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
@interface MShowAllGroup ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *arrGroup;
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation MShowAllGroup

- (id)initWithArrGroup:(NSArray *)arrGroup arrSelected:(NSMutableArray *)arr {

    if (self = [super init]) {
        
        self.arrSeleted = arr;
        self.arrGroup = arrGroup;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"照片";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 90;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MGroupTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(actionRightBar)];
    self.navigationItem.rightBarButtonItem = rightBar;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
}

- (void)clickLeftBarBtnItemAction:(id)sender{

   [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)actionRightBar {

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrGroup.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ALAssetsGroup *froup = self.arrGroup[indexPath.row];
    cell.leftImg.image = [UIImage imageWithCGImage:froup.posterImage];
    cell.rightLab.text = [NSString stringWithFormat:@"%@(%ld)",[froup valueForProperty:ALAssetsGroupPropertyName],[froup numberOfAssets]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    _mvc = [[MShowGroupAllSet alloc] initWithGroup:self.arrGroup[indexPath.row] selectedArr:self.arrSeleted];
    _mvc.delegate = self;
    _mvc.arrSelected = _arrSeleted;
    _mvc.MaxCount = _maxCout;
    [self.navigationController pushViewController:_mvc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)finishSelectImg{
    [self.delegate finishSelectImg];
}

@end
