//
//  DefineBlocks.h
//  ALiLikePurchase
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 郭超. All rights reserved.
//
#import "Message.h"

#ifndef DefineBlocks_h
#define DefineBlocks_h

typedef void (^NSDictionaryCallBack)(NSDictionary * result);

typedef void (^NSArrayCallBack) (NSArray * result);

typedef void  (^NSObjectCallBack) (NSObject* object);

typedef void (^MessageCallBack) (Message * message);

typedef void (^NSDataCallBack) (NSData* data);

typedef void (^BoolCallBack) (Boolean isTrue);

#endif /* DefineBlocks_h */
