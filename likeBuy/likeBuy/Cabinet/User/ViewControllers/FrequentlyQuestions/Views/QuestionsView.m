//
//  QuestionsView.m
//  likeBuy
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "QuestionsView.h"
#import "QuestionListDataModel.h"

@interface QuestionsView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *neirongTextView;

@end


@implementation QuestionsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"QuestionsView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.contentView];
    [self.contentView  setFrame:self.bounds];
    
}

-(void)setModel:(QuestionListDataModel *)model{
    [self.titleLabel setText:model.title];
    [self.neirongTextView setText:model.content];
}



@end
