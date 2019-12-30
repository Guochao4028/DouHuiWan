//
//  SearchBarView.m
//  likeBuy
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "SearchBarView.h"

@interface SearchBarView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *seachView;

@end

@implementation SearchBarView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"SearchBarView" owner:self options:nil];
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self.contentView  setFrame:self.bounds];
    [self addSubview:self.contentView];
    self.seachView.layer.cornerRadius = 8;
}

-(void)setIsClearColor:(BOOL)isClearColor{
    if (isClearColor == YES) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self.contentView setBackgroundColor:[UIColor clearColor]];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(jumpSearchView)]) {
        [self.delegate jumpSearchView];
    }
}

-(void)setBgColor:(UIColor *)bgColor{
    [self setBackgroundColor:bgColor];
    [self.contentView setBackgroundColor:bgColor];
}

@end
