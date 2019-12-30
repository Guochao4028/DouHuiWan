//
//  DefinedColors.h
//  likeBuy
//
//  Created by mac on 2019/9/17.
//  Copyright © 2019 Beans. All rights reserved.
//

#ifndef DefinedColors_h
#define DefinedColors_h

#define RGB(R,G,B) RGBA((R),(G),(B),0.99)

#define RGBA(R,G,B,A) [UIColor colorWithRed:((R)/255.0) green:((G)/255.0) blue:((B)/255.0) alpha:(A)]

///豆惠玩 亮灰
#define LIGHTGREY [UIColor colorWithHexString:@"DFDFDF"]
///豆惠玩 深红
#define DARKRED [UIColor colorWithHexString:@"FF5457"]
///豆惠玩 字深灰
#define TEXTGREY [UIColor colorWithHexString:@"999999"]
///豆惠玩 黑色
#define BLACK [UIColor colorWithHexString:@"333333"]
///豆惠玩 边框颜色
#define BORDERCOLOR [UIColor colorWithHexString:@"F7F7F7"]
///豆惠玩 分类 背景色
#define DARKWHITE [UIColor colorWithHexString:@"FDFDFD"]


///白色
#define WHITE [UIColor whiteColor]

#define TEXTNORMALCOLOR    RGB(102, 102, 102)

#define TEXTCHANGECOLOR    RGB(51, 51, 51)

#define REDLINECOLOR       RGB(251, 87, 84)


#endif /* DefinedColors_h */
