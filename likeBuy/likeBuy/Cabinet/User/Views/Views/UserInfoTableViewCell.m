//
//  UserInfoTableViewCell.m
//  likeBuy
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "UserInfoTableViewCell.h"

#import "DBManager.h"

@interface UserInfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *nologinView;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIView *priceView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *heardImageView;
@property (weak, nonatomic) IBOutlet UILabel *yaoqingmaLabel;
@property (weak, nonatomic) IBOutlet UILabel *leveLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nologinH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoViewH;
@property (weak, nonatomic) IBOutlet UILabel *zongshouyiLabel;
@property (weak, nonatomic) IBOutlet UILabel *tixianLabel;
@property (weak, nonatomic) IBOutlet UIButton *tixianButton;
- (IBAction)tixianAction:(id)sender;

@property (nonatomic, strong)User *model;
@property (weak, nonatomic) IBOutlet UIButton *yaoqingButton;

- (IBAction)copyAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginAction:(id)sender;

@end

@implementation UserInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.heardImageView.layer.cornerRadius = 56/2;
    
    self.tixianButton.layer.cornerRadius = 4;
    
    self.yaoqingButton.layer.cornerRadius = 4;
    
    self.loginButton.layer.cornerRadius = 4;
    
    [self.heardImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSetup)];
    [self.heardImageView addGestureRecognizer:tap];
    
    [self initData];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)initData{
    self.model = [[DataManager shareInstance]getUser];
}

-(void)refreshData{
    [self initData];
}

#pragma mark - getter / setter

-(void)setModel:(User *)model{
    _model = model;
    if (model == nil) {
        [[self nologinView ]setHidden:NO];
        [[self infoView]setHidden:YES];
        self.nologinH.constant = 136;
        self.infoViewH.constant = 80;
        
        [self.zongshouyiLabel setText:@"¥0"];
        [self.tixianLabel setText:@"¥0"];
        [self.tixianButton setUserInteractionEnabled:NO];
        [self.tixianButton setBackgroundColor:RGB(247, 247, 247)];
        [self.tixianButton setTitleColor:RGB(144, 147, 153) forState:UIControlStateNormal];
    }else{
        [[self nologinView ]setHidden:YES];
        [[self infoView]setHidden:NO];
        self.nologinH.constant = 80;
        self.infoViewH.constant = 80;
        
        [self.tixianLabel setText:[NSString stringWithFormat:@"¥%@", model.extractableRebate]];
        
        [self.zongshouyiLabel setText:[NSString stringWithFormat:@"¥%@", model.rebateAmountStr]];
        [self.tixianButton setUserInteractionEnabled:YES];
        [self.tixianButton setBackgroundColor:[UIColor colorWithHexString:@"4D7FFF"]];
        [self.tixianButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    
    if ([self.infoView isHidden] == NO) {
        
        if (model.shortName.length == 0) {
            
            [self.nameLabel setText:model.telephone];
        }else{
            [self.nameLabel setText:model.shortName];
        }
        
        [self.heardImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]placeholderImage:[UIImage imageNamed:@"121"]];
        
        BOOL isShowconfig =  [DBManager shareInstance].isShowconfig;
        
        if (isShowconfig == NO) {
            [self.yaoqingmaLabel setText:[NSString stringWithFormat:@"邀请码：%@",model.selfResqCode]];
            
            [self.yaoqingButton setHidden:NO];
            [self.priceView setHidden:NO];
                   
        }else{
            [self.yaoqingButton setHidden:YES];
            [self.priceView setHidden:YES];
        }
        
       [self.leveLabel setText:model.grade];
       
    }
    
    
}

- (IBAction)copyAction:(id)sender {
    
    if(self.model.selfResqCode.length > 1){
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.model.selfResqCode;
        [MBProgressHUD wj_showSuccess];
        
    }else{
        [MBProgressHUD wj_showError];
    }
    
}

- (IBAction)tixianAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(tapTixian)]){
        [self.delegate tapTixian];
    }
}

- (IBAction)loginAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(tapLogin)]){
        [self.delegate tapLogin];
    }
}

-(void)tapSetup{
    if([self.delegate respondsToSelector:@selector(tapSetup)]){
        [self.delegate tapSetup];
    }
}

@end
