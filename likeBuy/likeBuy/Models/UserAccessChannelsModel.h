//
//  UserAccessChannelsModel.h
//  likeBuy
//
//  Created by mac on 2019/10/19.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserAccessChannelsModel : NSObject


@property(nonatomic, copy)NSString *modelId;
//这个是渠道id
@property(nonatomic, copy)NSString *descriptionId;
@property(nonatomic, copy)NSString *adzoneType;
@property(nonatomic, copy)NSString *deviceOs;
@property(nonatomic, copy)NSString *tbsendUrl;
@property(nonatomic, copy)NSString *remark;
@property(nonatomic, copy)NSString *appSecret;
@property(nonatomic, copy)NSString *appKey;
@property(nonatomic, copy)NSString *pId;
@property(nonatomic, copy)NSString *tbsendTextUrl;
@property(nonatomic, copy)NSString *status;
@property(nonatomic, copy)NSString *adzoneId;
@end

NS_ASSUME_NONNULL_END

//
//{
//    message = "操作成功！",
//    data =     {
//        id = 1,
//        description = "2272390415",
//        adzoneType = "app",
//        deviceOs = "ios",
//        tbsendUrl = "http://gw.api.taobao.com/router/rest",
//        remark = "",
//        appSecret = "5be59de113e9835ed0c223de61ee8b53",
//        appKey = "27979957",
//        pId = "mm_451870089_958600174_109581650168",
//        tbsendTextUrl = "",
//        status = "0",
//        adzoneId = "109581650168",
//    },
//    code = 0,
//}
