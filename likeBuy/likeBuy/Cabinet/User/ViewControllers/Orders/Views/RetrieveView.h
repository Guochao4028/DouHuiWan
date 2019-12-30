//
//  RetrieveView.h
//  likeBuy
//
//  Created by mac on 2019/12/12.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RetrieveViewDelegate <NSObject>

-(void)tapSearch:(NSString *)text;

@end

@interface RetrieveView : UIView
@property(nonatomic, weak)id<RetrieveViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
