//
//  ScreeningView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "ScreeningView.h"



@interface ScreeningView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *zongheLabel;
@property (weak, nonatomic) IBOutlet UIImageView *zongheImageView;
@property (weak, nonatomic) IBOutlet UILabel *xiaoliangLabel;
@property (weak, nonatomic) IBOutlet UIImageView *xiaoliangImageView;
@property (weak, nonatomic) IBOutlet UILabel *jiageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *jiageImageView;
@property (weak, nonatomic) IBOutlet UIView *zongheView;
@property (weak, nonatomic) IBOutlet UIView *xiaoliangView;
@property (weak, nonatomic) IBOutlet UIView *jiageView;

@end

@implementation ScreeningView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"ScreeningView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.contentView];
    [self.contentView  setFrame:self.bounds];
    
    UITapGestureRecognizer *zongheTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapZongHe)];
    [self.zongheView addGestureRecognizer:zongheTap];
    
    UITapGestureRecognizer *xiaoliangTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapXiaoLiang)];
    [self.xiaoliangView addGestureRecognizer:xiaoliangTap];
    
    UITapGestureRecognizer *jiageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapJiaGe)];
    [self.jiageView addGestureRecognizer:jiageTap];
    
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}

-(void)tapZongHe{
    if([self.delegate respondsToSelector:@selector(tapZongHe:)]){
        [self.delegate tapZongHe:self.type];
    }
}

-(void)tapXiaoLiang{
   
    if([self.delegate respondsToSelector:@selector(tapXiaoLiang:)]){
        [self.delegate tapXiaoLiang:self.type];
    }
}

-(void)tapJiaGe{
    
    if([self.delegate respondsToSelector:@selector(tapJiaGe:)]){
        [self.delegate tapJiaGe:self.type];
    }
}

-(void)setType:(ListType)type{
    _type = type;
    switch (type) {
        case ListZongHeType:{
            [self.zongheLabel setTextColor:[UIColor colorWithHexString:@"FB5754"]];
            [self.zongheImageView setImage:[UIImage imageNamed:@"xingx"]];
            
        
            [self.xiaoliangLabel setTextColor:[UIColor colorWithHexString:@"9A9B9D"]];
            [self.xiaoliangImageView setImage:[UIImage imageNamed:@"shangxia"]];
            
            [self.jiageLabel setTextColor:[UIColor colorWithHexString:@"9A9B9D"]];
            [self.jiageImageView setImage:[UIImage imageNamed:@"shangxia"]];
        }
            break;
        case ListXiaoLiangShangType:{
            [self.zongheLabel setTextColor:[UIColor colorWithHexString:@"9A9B9D"]];
            [self.zongheImageView setImage:[UIImage imageNamed:@"huixia"]];
            
            [self.xiaoliangLabel setTextColor:[UIColor colorWithHexString:@"FB5754"]];
            [self.xiaoliangImageView setImage:[UIImage imageNamed:@"shang"]];
            
            [self.jiageLabel setTextColor:[UIColor colorWithHexString:@"9A9B9D"]];
            [self.jiageImageView setImage:[UIImage imageNamed:@"shangxia"]];
         
        }
            break;
        case ListXiaoLiangXiaType:{
            [self.zongheLabel setTextColor:[UIColor colorWithHexString:@"9A9B9D"]];
            [self.zongheImageView setImage:[UIImage imageNamed:@"huixia"]];
            
            
            [self.xiaoliangLabel setTextColor:[UIColor colorWithHexString:@"FB5754"]];
            [self.xiaoliangImageView setImage:[UIImage imageNamed:@"xia"]];
            
            [self.jiageLabel setTextColor:[UIColor colorWithHexString:@"9A9B9D"]];
            [self.jiageImageView setImage:[UIImage imageNamed:@"shangxia"]];
        }
            break;
        case ListJiaGeShangType:{
            [self.zongheLabel setTextColor:[UIColor colorWithHexString:@"9A9B9D"]];
            [self.zongheImageView setImage:[UIImage imageNamed:@"huixia"]];
            
            
            [self.xiaoliangLabel setTextColor:[UIColor colorWithHexString:@"9A9B9D"]];
            [self.xiaoliangImageView setImage:[UIImage imageNamed:@"shangxia"]];
            
            [self.jiageLabel setTextColor:[UIColor colorWithHexString:@"FB5754"]];
            [self.jiageImageView setImage:[UIImage imageNamed:@"shang"]];
        }
            break;
            
        case ListJiaGeXiaType:{
            [self.zongheLabel setTextColor:[UIColor colorWithHexString:@"9A9B9D"]];
            [self.zongheImageView setImage:[UIImage imageNamed:@"huixia"]];
            
            
            [self.xiaoliangLabel setTextColor:[UIColor colorWithHexString:@"9A9B9D"]];
            [self.xiaoliangImageView setImage:[UIImage imageNamed:@"shangxia"]];
            
            [self.jiageLabel setTextColor:[UIColor colorWithHexString:@"FB5754"]];
            [self.jiageImageView setImage:[UIImage imageNamed:@"xia"]];
        }
            break;
            
        default:
            break;
    }
}

@end
