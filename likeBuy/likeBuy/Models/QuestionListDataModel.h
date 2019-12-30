//
//  QuestionListDataModel.h
//  likeBuy
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 Beans. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuestionListDataModel : NSObject


@property(nonatomic, copy)NSString *questionId;
@property(nonatomic, copy)NSString *typeProblem;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *typePlateform;
@property(nonatomic, copy)NSString *content;

@end

NS_ASSUME_NONNULL_END


/**
 id = 26,
 typeProblem = 10,
 title = "自营收益1",
 typePlateform = 20,
 content = "解答",
 */
