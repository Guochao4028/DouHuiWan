//
//  SearchCommandView.m
//  ALiLikePurchase
//
//  Created by mac on 2019/11/6.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "SearchCommandView.h"

@interface SearchCommandView()
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
- (IBAction)quxiaoAction:(id)sender;
- (IBAction)searchAtion:(id)sender;

@end

@implementation SearchCommandView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"SearchCommandView" owner:self options:nil];
        [self initUI];
        
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.contentView];
    [self.contentView  setFrame:self.bounds];
}


-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.contentView setFrame:self.bounds];
}


#pragma mark -  aciton

- (IBAction)quxiaoAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(tapQuXiao)]) {
     [self.delegate tapQuXiao];
    }
}

- (IBAction)searchAtion:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(jumpSearch:)]) {
        [self.delegate jumpSearch:self.wordStr];
       }
}

#pragma mark - setter / getter

-(void)setWordStr:(NSString *)wordStr{
    _wordStr = wordStr;
    [self.wordLabel setText:wordStr];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self setHidden:YES];
}


@end
