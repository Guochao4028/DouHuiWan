//
//  ControlPanelTableViewCell.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "ControlPanelTableViewCell.h"

#import "ControlItemCell.h"


static NSString *kCollectionViewHeaderIdentifier = @"kCollectionViewHeaderIdentifier";

@interface ControlPanelTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *collectionView;

@property(nonatomic, strong)NSArray *dataList;

@end

@implementation ControlPanelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        [self initData];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    
    return self;
}

#pragma mark - ui
-(void)initUI{
    [self.contentView addSubview:self.collectionView];
    
    self.contentView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.contentView.layer.cornerRadius = 30;
    self.contentView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    self.contentView.layer.shadowOffset = CGSizeMake(0,0);
    self.contentView.layer.shadowOpacity = 1;
    self.contentView.layer.shadowRadius = 6;
    
}

-(void)initData{
    
    NSString *code = [[NSUserDefaults standardUserDefaults]objectForKey:SHOWCONFIG];
    BOOL codeBool = [code boolValue];
    if (codeBool) {
        
        self.dataList = @[
                @{
                    @"data":@[
                               @{@"name":@"我的订单", @"icon":@"wding",@"type":@"0"},
//                               @{@"name":@"我的钱包", @"icon":@"qianbao",@"type":@"1"},
//                               @{@"name":@"收益报表", @"icon":@"baobiao",@"type":@"2"},
//                               @{@"name":@"团队粉丝", @"icon":@"tfensi",@"type":@"3"},
//                               @{@"name":@"粉丝订单", @"icon":@"fdingdan",@"type":@"4"},
                              // @{@"name":@"邀请成员", @"icon":@"yaoqin",@"type":@"5"},
                               @{@"name":@"我的收藏", @"icon":@"shoucan",@"type":@"6"},
                               @{@"name":@"我的足迹", @"icon":@"zuji",@"type":@"7"},
                               @{@"name":@"订单找回", @"icon":@"wding",@"type":@"17"}]
//                               @{@"name":@"会员升级", @"icon":@"hui",@"type":@"8"}]
                },
                @{
                    @"data":@[
                            @{@"name":@"常见问题", @"icon":@"changjian",@"type":@"9"},
                            @{@"name":@"推广原则", @"icon":@"tuiguang",@"type":@"10"},
//                            @{@"name":@"物料领取", @"icon":@"wuliao",@"type":@"11"},
                            @{@"name":@"新手指引", @"icon":@"xinshou",@"type":@"12"},
                            @{@"name":@"商务合作", @"icon":@"hezuo",@"type":@"13"},
                            @{@"name":@"关于我们", @"icon":@"guanyu",@"type":@"14"},
//                            @{@"name":@"地址管理", @"icon":@"dizhi",@"type":@"15"},
//                            @{@"name":@"联系人管理", @"icon":@"lianxiren",@"type":@"16"}
                    ]
                }
            ];
    }else{
        self.dataList = @[
                @{
                    @"data":@[ @{@"name":@"我的订单", @"icon":@"wding",@"type":@"0"},
                               @{@"name":@"我的钱包", @"icon":@"qianbao",@"type":@"1"},
                               @{@"name":@"收益报表", @"icon":@"baobiao",@"type":@"2"},
                               @{@"name":@"团队粉丝", @"icon":@"tfensi",@"type":@"3"},
                               @{@"name":@"粉丝订单", @"icon":@"fdingdan",@"type":@"4"},
                               @{@"name":@"邀请成员", @"icon":@"yaoqin",@"type":@"5"},
                               @{@"name":@"我的收藏", @"icon":@"shoucan",@"type":@"6"},
                               @{@"name":@"我的足迹", @"icon":@"zuji",@"type":@"7"},
                               @{@"name":@"会员升级", @"icon":@"hui",@"type":@"8"},
                               @{@"name":@"订单找回", @"icon":@"wding",@"type":@"17"}]
                },
                @{
                    @"data":@[
                            @{@"name":@"常见问题", @"icon":@"changjian",@"type":@"9"},
                            @{@"name":@"推广原则", @"icon":@"tuiguang",@"type":@"10"},
//                            @{@"name":@"物料领取", @"icon":@"wuliao",@"type":@"11"},
                            @{@"name":@"新手指引", @"icon":@"xinshou",@"type":@"12"},
                            @{@"name":@"商务合作", @"icon":@"hezuo",@"type":@"13"},
                            @{@"name":@"关于我们", @"icon":@"guanyu",@"type":@"14"},
//                            @{@"name":@"地址管理", @"icon":@"dizhi",@"type":@"15"},
//                            @{@"name":@"联系人管理", @"icon":@"lianxiren",@"type":@"16"}
                    ]
                }
            ];
    }
    
    
//    self.dataList = @[
//        @{
//            @"data":@[ @{@"name":@"我的订单", @"icon":@"wding",@"type":@"0"},
//                       @{@"name":@"我的钱包", @"icon":@"qianbao",@"type":@"1"},
//                       @{@"name":@"收益报表", @"icon":@"baobiao",@"type":@"2"},
//                       @{@"name":@"团队粉丝", @"icon":@"tfensi",@"type":@"3"},
//                       @{@"name":@"粉丝订单", @"icon":@"fdingdan",@"type":@"4"},
//                       @{@"name":@"邀请成员", @"icon":@"yaoqin",@"type":@"5"},
//                       @{@"name":@"我的收藏", @"icon":@"shoucan",@"type":@"6"},
//                       @{@"name":@"我的足迹", @"icon":@"zuji",@"type":@"7"},
//                       @{@"name":@"会员升级", @"icon":@"hui",@"type":@"8"}]
//        },
////        @{
////            @"data":@[
////                    @{@"name":@"常见问题", @"icon":@"changjian",@"type":@"9"},
////                    @{@"name":@"推广原则", @"icon":@"tuiguang",@"type":@"10"},
////                    @{@"name":@"物料领取", @"icon":@"wuliao",@"type":@"11"},
////                    @{@"name":@"新手指引", @"icon":@"xinshou",@"type":@"12"},
////                    @{@"name":@"商务合作", @"icon":@"hezuo",@"type":@"13"},
////                    @{@"name":@"关于我们", @"icon":@"guanyu",@"type":@"14"},
////                    @{@"name":@"地址管理", @"icon":@"dizhi",@"type":@"15"},
////                    @{@"name":@"联系人管理", @"icon":@"lianxiren",@"type":@"16"}
////            ]
////        }
//    ];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataList.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSDictionary *dic = self.dataList[section];
    
    NSArray *list = dic[@"data"];
    
    return list.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ControlItemCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *dic = self.dataList[indexPath.section];
    
    NSArray *list = dic[@"data"];
    
    NSDictionary *tem = list[indexPath.row];
    [cell setModel:tem];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.dataList[indexPath.section];
    
    NSArray *list = dic[@"data"];
    
    NSDictionary *tem = list[indexPath.row];
    
    NSInteger type = [tem[@"type"] integerValue];
    
    if([self.delegate respondsToSelector:@selector(tapItem:)]){
        [self.delegate tapItem:type];
    }
}



- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return (ScreenWidth - (60 *3) - (48*2))/3;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kCollectionViewHeaderIdentifier forIndexPath:indexPath];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 14, ScreenWidth, 10)];
    [bgView setBackgroundColor:RGB(251, 251, 253)];
//    [bgView setBackgroundColor:WHITE];
    [view addSubview:bgView];
    
    return view;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(self.frame.size.width, 24);
    }else{
        return CGSizeZero;
    }
}

#pragma mark - gettet/ setter

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat width = 60;
        CGFloat higth = 73;
        layout.itemSize = CGSizeMake(width, higth);
        layout.minimumLineSpacing = 15;
        
        if (ScreenWidth < IPHONE6WIDTH) {
            layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
        }else{
            layout.sectionInset = UIEdgeInsetsMake(0, 48, 0, 48);
        }
        
        _collectionView = [[UICollectionView alloc]initWithFrame: CGRectMake(0, 0, ScreenWidth, 644) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ControlItemCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter  withReuseIdentifier:kCollectionViewHeaderIdentifier];
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView setScrollEnabled:YES];
        
    }
    return _collectionView;
}

@end
