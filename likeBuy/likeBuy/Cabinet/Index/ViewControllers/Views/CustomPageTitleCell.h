//
//  CustomPageTitleCell.h
//  likeBuy
//
//  Created by mac on 2019/10/8.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "XLPageTitleCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomPageTitleCell : XLPageTitleCell
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, strong, nonnull) NSDictionary *model;

@end

NS_ASSUME_NONNULL_END
