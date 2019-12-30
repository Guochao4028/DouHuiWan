//
//  SearchTopView.h
//  likeBuy
//
//  Created by mac on 2019/9/25.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SearchTopViewDelegate <NSObject>

@optional
-(void)searchTextField:(NSString *)word;

-(void)selectMeunAction;

-(void)back;

@end

@interface SearchTopView : UIView

@property(nonatomic, weak)id<SearchTopViewDelegate> delegate;

@property(nonatomic, assign)MeunSelectType type;

@property(nonatomic, copy)NSString *inTextStr;

@property(nonatomic, assign)BOOL isViewBack;

/// 输入结束
-(void)endInput;

@end

NS_ASSUME_NONNULL_END
