//
//  QuestionsContentViewController.m
//  likeBuy
//
//  Created by mac on 2019/12/9.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "QuestionsContentViewController.h"
#import "LJCollectionViewFlowLayout.h"
#import "QuestionModel.h"
#import "LeftTableViewCell.h"
#import "QuestionCollectionViewCell.h"
#import "QuestionListDataModel.h"
#import "LJCollectionViewFlowLayout.h"
#import "QuestionPushViewController.h"


static float kLeftTableViewWidth = 90.f;
static float kCollectionViewMargin = 10.f;

static NSString *const kQuestionCollectionViewCellIdentifier =  @"QuestionCollectionViewCell";

@interface QuestionsContentViewController ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property(nonatomic, strong)UITableView *leftTableView;
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)LJCollectionViewFlowLayout *flowLayout;
@property(nonatomic, strong)NSArray *leftArray;

@property(nonatomic, strong)NSArray *collectionDatas;


@end

@implementation QuestionsContentViewController
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}

- (void)viewDidLoad {
    
    _selectIndex = 0;
    _isScrollDown = YES;

    
    [super viewDidLoad];
    [self initUI];
}


-(void)initUI{
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.collectionView];
}



-(void)loadData:(QuestionModel *)model{
    
    [[DataManager shareInstance]searchDirc:@{@"group":model.group} callback:^(NSArray *result) {
        self.leftArray = result;
        
        QuestionModel *tem = [self.leftArray firstObject];
        
        NSDictionary *dic = @{@"typePlateform":model.code, @"typeProblem":tem.code};
        
        
        [[DataManager shareInstance]queryFrequentlyQuestions:dic callback:^(NSArray *result) {
            self.collectionDatas = result;
            [self.collectionView reloadData];
            [self reloadData];
        }];
        
        [self.leftTableView reloadData];
    }];
    
}


-(void)reloadData{
    [self.leftTableView reloadData];
    [self.collectionView reloadData];
    if (self.leftArray.count > 0) {
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

#pragma mark -  UITableViewDelegate & UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leftArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftTableViewCell"];
    QuestionModel * model = self.leftArray[indexPath.row];
    [cell.name setText:model.title];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndex = indexPath.row;
    [self scrollToTopOfSection:_selectIndex animated:YES];
    [self.leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    
    QuestionModel *model = self.dataList[self.index];
    
    [[DataManager shareInstance]searchDirc:@{@"group":model.group} callback:^(NSArray *result) {
         self.leftArray = result;
         
         QuestionModel *tem = self.leftArray[_selectIndex];
         
         NSDictionary *dic = @{@"typePlateform":model.code, @"typeProblem":tem.code};
         
         
         [[DataManager shareInstance]queryFrequentlyQuestions:dic callback:^(NSArray *result) {
             self.collectionDatas = result;
             [self.collectionView reloadData];
         }];
         
     }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 56;
}

#pragma mark - 解决点击 TableView 后 CollectionView 的 Header 遮挡问题

- (void)scrollToTopOfSection:(NSInteger)section animated:(BOOL)animated
{
    CGRect headerRect = [self frameForHeaderForSection:section];
    CGPoint topOfHeader = CGPointMake(0, headerRect.origin.y - _collectionView.contentInset.top);
    [self.collectionView setContentOffset:topOfHeader animated:animated];
}

- (CGRect)frameForHeaderForSection:(NSInteger)section
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
    return attributes.frame;
}


#pragma mark - UICollectionView DataSource Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kQuestionCollectionViewCellIdentifier forIndexPath:indexPath];
    QuestionListDataModel *model = self.collectionDatas[indexPath.row];
    [cell setStr:model.title];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    QuestionListDataModel *model = self.collectionDatas[indexPath.row];
    QuestionPushViewController *pushVC = [[QuestionPushViewController alloc]init];
    pushVC.model = model;
    [self.navigationController pushViewController:pushVC animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ScreenWidth - kLeftTableViewWidth -kCollectionViewMargin;
    return CGSizeMake(width , 40);
}




// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    // 当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollDown && (collectionView.dragging || collectionView.decelerating))
    {
        [self selectRowAtIndexPath:indexPath.section];
    }
}

// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (_isScrollDown && (collectionView.dragging || collectionView.decelerating))
    {
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}

// 当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark - setter / getter

-(UITableView *)leftTableView{
    
    if (_leftTableView == nil) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kLeftTableViewWidth, (CGRectGetHeight(self.view.bounds) - TabbarHeight))];
        [_leftTableView setDelegate:self];
        [_leftTableView setDataSource:self];
        [_leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:@"LeftTableViewCell"];
        _leftTableView.showsHorizontalScrollIndicator  = NO;
        _leftTableView.showsVerticalScrollIndicator = NO;
        [_leftTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_leftTableView setBackgroundColor:RGB(247, 247, 247)];
    }
    
    return _leftTableView;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kCollectionViewMargin + kLeftTableViewWidth, 0, ScreenWidth - kLeftTableViewWidth -kCollectionViewMargin, CGRectGetHeight(self.view.bounds) - 90 - TabbarHeight) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:RGB(254, 254, 254)];
        
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QuestionCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kQuestionCollectionViewCellIdentifier];
//        //注册分区头标题
//        [_collectionView registerClass:[CollectionViewHeaderView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionViewHeaderView"];
//
//        [_collectionView registerClass:[CollectionViewHeaderView class]forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CollectionViewFooterView"];
        
    }
    return _collectionView;
}


-(void)setIndex:(NSInteger)index{
    _index = index;
    QuestionModel *model = self.dataList[index];
    [self loadData:model];
}

- (LJCollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout)
    {
        _flowLayout = [[LJCollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.minimumInteritemSpacing = 2;
        _flowLayout.minimumLineSpacing = 2;
    }
    return _flowLayout;
}

@end
