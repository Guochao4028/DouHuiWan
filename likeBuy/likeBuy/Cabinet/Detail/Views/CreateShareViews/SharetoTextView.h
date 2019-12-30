//
//  SharetoTextView.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/18.
//  Copyright © 2019 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SharetoTextViewDelegate <NSObject>

-(void)tapSavePic;
-(void)tapSendWeiXin;
-(void)tapSendPengyouquan;
-(void)tapSendQQ;
-(void)tapSendQQZ;



@end

@interface SharetoTextView : UIView

@property(nonatomic, weak)id<SharetoTextViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
