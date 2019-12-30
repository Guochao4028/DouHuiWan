//
//  NewsView.m
//  likeBuy
//
//  Created by mac on 2019/10/22.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "NewsView.h"

#import "DBManager.h"

@interface NewsView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation NewsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"NewsView" owner:self options:nil];
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isRedPoint:) name:NOTIFICATIONREDPOINT object:nil];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.contentView];
    [self.contentView  setFrame:self.bounds];
    self.redView.layer.cornerRadius = 4;
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self.contentView setBackgroundColor:[UIColor clearColor]];
}

-(void)isRedPoint:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    NSString *redPoint = dic[@"isRedPoint"];
    [[DBManager shareInstance]setIsRedView:redPoint];
    BOOL isRedPoint = [redPoint boolValue];
    [self.redView setHidden:!isRedPoint];
}



@end
