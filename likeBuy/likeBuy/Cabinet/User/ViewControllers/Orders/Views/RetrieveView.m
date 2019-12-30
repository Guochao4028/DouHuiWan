//
//  RetrieveView.m
//  likeBuy
//
//  Created by mac on 2019/12/12.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "RetrieveView.h"

@interface RetrieveView ()<UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation RetrieveView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [[NSBundle mainBundle] loadNibNamed:@"RetrieveView" owner:self options:nil];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.contentView];
    [self.contentView  setFrame:self.bounds];
    
    [self.searchBar setDelegate:self];
    
}



#pragma mark - UISearchBarDelegate

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self endEditing:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"SearchButton");
    NSString *txt = searchBar.text;
    
    if (txt.length > 0) {
        [self endEditing:YES];
        
        if ([self.delegate respondsToSelector:@selector(tapSearch:)] == YES) {
            [self.delegate tapSearch:txt];
        }
    }
}

#pragma mark - action
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end
