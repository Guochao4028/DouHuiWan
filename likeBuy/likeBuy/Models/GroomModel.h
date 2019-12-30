//
//  GroomModel.h
//  likeBuy
//
//  Created by mac on 2019/10/22.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroomModel : NSObject

@property(nonatomic, copy)NSString *remark;

@property(nonatomic, copy)NSString *itemId;

@property(nonatomic, strong)NSArray *pics;

@property(nonatomic, strong)NSString *title;

@property(nonatomic, strong)NSString *index;

@property(nonatomic, strong)NSString *groomID;

@property(nonatomic, assign)CGFloat tableViewH;

@end

NS_ASSUME_NONNULL_END


//{
//    remark = "<p>我推荐该商品，好用</p>",
//    id = 3,
//    itemId = "603175975667",
//    pics =     (
//        "http://img.alicdn.com/bao/uploaded/i3/1743607907/O1CN01rzwPKQ28HSFe3mCYe_!!0-item_pic.jpg",
//        "http://img.alicdn.com/bao/uploaded/i3/1743607907/O1CN01z7KrAV28HSFfWpH4b_!!1743607907.jpg",
//        "http://img.alicdn.com/bao/uploaded/i2/1743607907/O1CN01Rnw73i28HSFa7VFv1_!!1743607907.jpg",
//        "http://img.alicdn.com/bao/uploaded/i2/1743607907/O1CN01TzZbMx28HSFe3ainI_!!1743607907.jpg",
//        "http://img.alicdn.com/bao/uploaded/i3/1743607907/O1CN01IvXJnc28HSFctXzQf_!!1743607907.png",
//    ),
//    title = "国潮牌日系歌姬刺绣连帽卫衣男加绒宽松潮男情侣装男装秋冬季外套",
//    index = 3,
//}
