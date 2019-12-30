//
//  TipMeunView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "TipMeunView.h"

@interface TipMeunView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *pddSelectedView;
@property (weak, nonatomic) IBOutlet UIView *jdSelectesView;
//@property (weak, nonatomic) IBOutlet UIView *tianmaoSelectView;
@property (weak, nonatomic) IBOutlet UIView *taobaoSelectView;
//@property (weak, nonatomic) IBOutlet UIView *chaoshiSelectView;
@property (weak, nonatomic) IBOutlet UIView *pddView;
@property (weak, nonatomic) IBOutlet UIView *jdView;
//@property (weak, nonatomic) IBOutlet UIView *chaoshiView;
@property (weak, nonatomic) IBOutlet UIView *taobaoView;
//@property (weak, nonatomic) IBOutlet UIView *tianmaoView;


@end

@implementation TipMeunView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"TipMeunView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self.pddSelectedView setHidden:YES];
    [self.jdSelectesView setHidden:YES];
//    [self.tianmaoSelectView setHidden:YES];
    [self.taobaoSelectView setHidden:YES];
//    [self.chaoshiSelectView setHidden:YES];
    
    [self addSubview:self.contentView];
    [self.contentView  setFrame:self.bounds];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectMeun:)];
    [self.pddView addGestureRecognizer:tap];
    [self.pddView setTag:MeunSelectPDDType];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectMeun:)];
    [self.jdView addGestureRecognizer:tap1];
    [self.jdView setTag:MeunSelectJDType];
    
//    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectMeun:)];
//    [self.chaoshiView addGestureRecognizer:tap2];
//    [self.chaoshiView setTag:MeunSelectCHAOSHIType];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectMeun:)];
    [self.taobaoView addGestureRecognizer:tap3];
    [self.taobaoView setTag:MeunSelectTAOBAOType];
    
//    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectMeun:)];
//    [self.tianmaoView addGestureRecognizer:tap4];
//    [self.tianmaoView setTag:MeunSelectTIANMAOType];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}

#pragma mark - action
-(void)selectMeun:(UITapGestureRecognizer *)sender{
    
    NSInteger tag = sender.view.tag;
    if ([self.delegate respondsToSelector:@selector(selectedMeunType:)]) {
        [self.delegate selectedMeunType:tag];
    }
    
}

#pragma mark - setter / getter

-(void)setType:(MeunSelectType)type{
    switch (type) {
        case MeunSelectPDDType:{
            [self.pddSelectedView setHidden:NO];
            
            [self.jdSelectesView setHidden:YES];
//            [self.tianmaoSelectView setHidden:YES];
            [self.taobaoSelectView setHidden:YES];
//            [self.chaoshiSelectView setHidden:YES];
        }
            break;
        case MeunSelectJDType:{
            [self.jdSelectesView setHidden:NO];
            [self.pddSelectedView setHidden:YES];
            
//            [self.tianmaoSelectView setHidden:YES];
            [self.taobaoSelectView setHidden:YES];
//            [self.chaoshiSelectView setHidden:YES];
        }
            break;
        case MeunSelectCHAOSHIType:{
//            [self.chaoshiSelectView setHidden:NO];
            [self.pddSelectedView setHidden:YES];
            [self.jdSelectesView setHidden:YES];
//            [self.tianmaoSelectView setHidden:YES];
            [self.taobaoSelectView setHidden:YES];
            
        }
            break;
        case MeunSelectTAOBAOType:{
            [self.taobaoSelectView setHidden:NO];
            [self.pddSelectedView setHidden:YES];
            [self.jdSelectesView setHidden:YES];
//            [self.tianmaoSelectView setHidden:YES];
            
//            [self.chaoshiSelectView setHidden:YES];
        }
            break;
        case MeunSelectTIANMAOType:{
//            [self.tianmaoSelectView setHidden:NO];
            [self.pddSelectedView setHidden:YES];
            [self.jdSelectesView setHidden:YES];
            
            [self.taobaoSelectView setHidden:YES];
//            [self.chaoshiSelectView setHidden:YES];
        }
            break;
        default:
            break;
    }
}

@end
