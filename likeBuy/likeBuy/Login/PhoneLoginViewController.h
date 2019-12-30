//
//  PhoneLoginViewController.h
//  likeBuy
//
//  Created by mac on 2019/9/5.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN



@interface PhoneLoginViewController : BaseViewController

@property(nonatomic, strong)NSString *identifyingCode;

@property(nonatomic, strong)NSString *phoneNumberStr;

@property(nonatomic, strong)UIViewController *vc;


@end

NS_ASSUME_NONNULL_END
