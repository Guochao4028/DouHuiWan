//
//  SearchTopView.m
//  likeBuy
//
//  Created by mac on 2019/9/25.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "SearchTopView.h"
#import "NSString+Tool.h"

@interface SearchTopView ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)backAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *searchLabel;

@property (weak, nonatomic) IBOutlet UIButton *searchButton;

- (IBAction)searchAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *loadView;
- (IBAction)tapIocnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *iconImaegView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backImageViewW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchLabelW;

@end

@implementation SearchTopView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"SearchTopView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.contentView];
    [self.contentView  setFrame:self.bounds];
    
    [self.searchTextField setDelegate:self];
    self.searchTextField.returnKeyType = UIReturnKeySearch;

    self.searchTextField .attributedPlaceholder = [NSString attributedPlaceholder:@"粘贴宝贝标题/输入关键字搜索" inView:self.searchTextField];
    
    self.loadView.layer.cornerRadius = 16;
}

-(void)endInput{
     [self.searchTextField  resignFirstResponder];
}

#pragma mark - action

- (IBAction)backAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(back)]) {
        [self.delegate back];
    }
}

- (IBAction)searchAction:(id)sender {
    
    if([self.delegate respondsToSelector:@selector(searchTextField:)]){
        [self.delegate searchTextField:self.searchTextField.text];
    }
}

- (IBAction)tapIocnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectMeunAction)]) {
        [self.delegate selectMeunAction];
    }
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if([self.delegate respondsToSelector:@selector(searchTextField:)]){
        [self.delegate searchTextField:textField.text];
    }
    return YES;
}

#pragma mark - setter / getter
-(void)setType:(MeunSelectType)type{
    NSString *pic;
    switch (type) {
        case MeunSelectPDDType:{
            pic = @"pdd";
        }
            break;
        case MeunSelectJDType:{
            pic = @"jd";
        }
            break;
        case MeunSelectCHAOSHIType:{
            pic = @"chaoshi";
        }
            break;
        case MeunSelectTAOBAOType:{
            pic = @"taobao";
        }
            break;
        case MeunSelectTIANMAOType:{
            pic = @"tianmao";
        }
            break;
        default:
            break;
    }
    [self.iconImaegView setImage:[UIImage imageNamed:pic]];
}


-(void)setInTextStr:(NSString *)inTextStr{
    _inTextStr = inTextStr;
    [self.searchTextField setText:inTextStr];
}

-(void)setIsViewBack:(BOOL)isViewBack{
    _isViewBack = isViewBack;
    if(isViewBack == YES){
        self.backImageViewW.constant = 0;
        [self.backButton setHidden:YES];
    }else{
        self.backImageViewW.constant = 15;
        [self.backButton setHidden:NO];
        self.searchLabelW.constant = 0;
    }
}

@end
