//
//  NavigationView.h
//  likeBuy
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NavigationViewDelegate <NSObject>

@optional
-(void)jumpSearchView;

-(void)jumpMessageView;

-(void)back;

@end

@interface NavigationView : UIView


-(instancetype)initWithFrame:(CGRect)frame type:(NavigationType)type;

@property(nonatomic, copy)NSString *daxieTitleStr;

@property(nonatomic, copy)NSString *titleStr;

@property(nonatomic, assign)BOOL isClearColor;

@property(nonatomic, weak)id<NavigationViewDelegate> delegate;


/***
 *是否显示 信息图标
 *no 不显示
 *yes 显示
 */
@property(nonatomic, assign)BOOL isViewMeage;



@end

NS_ASSUME_NONNULL_END
