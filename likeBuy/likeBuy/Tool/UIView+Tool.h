//
//  UIView+Tool.h
//  likeBuy
//
//  Created by mac on 2019/9/19.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Tool)

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGPoint origin;

/// 加阴影
+(void)addShadow:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
