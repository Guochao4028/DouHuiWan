//
//  LaunchImageAdView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/9/25.
//  Copyright © 2019 郭超. All rights reserved.
//
typedef enum {
    
    LogoAdType = 0,///带logo的广告
    FullScreenAdType = 1,///全屏的广告
}AdType;

typedef enum {
    
    skipAdType = 1,///点击跳过
    clickAdType = 2,///点击广告
    overtimeAdType = 3,///倒计时完成跳过
    
}clickType;

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^LBClick) (const clickType);

@interface LaunchImageAdView : UIView

@property (nonatomic, strong) UIImageView *aDImgView;
///倒计时总时长
@property (nonatomic, assign) NSInteger adTime;
///网络图片URL
@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy)LBClick clickBlock;

/*
 *  adType 广告类型
 */
- (void(^)(AdType const adType))getLBlaunchImageAdViewType;

@end

NS_ASSUME_NONNULL_END
