//
//  BSFitdpiUtil.h
//  Ali Huishou
//
//  Created by 胡占峰 on 2019/8/8.
//  Copyright © 2019 liuzhuang. All rights reserved.
//

#define kRefereWidth 375.0 // 参考宽度
#define kRefereHeight 667.0 // 参考高度

#define AdaptW(floatValue) [BSFitdpiUtil adaptWidthWithValue:floatValue]

#import <Foundation/Foundation.h>

 #import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSFitdpiUtil : NSObject

/**
 以屏幕宽度为固定比例关系，来计算对应的值。假设：参考屏幕宽度375，floatV=10；当前屏幕宽度为750时，那么返回的值为20
 @param floatV 参考屏幕下的宽度值
 @return 当前屏幕对应的宽度值
 */
+ (CGFloat)adaptWidthWithValue:(CGFloat)floatV;


@end

NS_ASSUME_NONNULL_END
