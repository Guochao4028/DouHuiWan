//
//  ModelTool.m
//  likeBuy
//
//  Created by mac on 2019/10/8.
//  Copyright © 2019 Beans. All rights reserved.
//

#import "ModelTool.h"
#import "CategoryModel.h"
#import "CategorySecondClassModel.h"
#import "OrderModel.h"
#import "RecommendModel.h"
#import "FansModel.h"
#import "BannerModel.h"
#import "UserAccessChannelsModel.h"
#import "InfoModel.h"
#import "GroomModel.h"

#import "PddGoodsCat.h"
#import "PddGoodsOpt.h"
#import "GoodsModel.h"

#import "PddGoodsListModel.h"

#import "JDCategoryModel.h"

#import "QuestionModel.h"

#import "QuestionListDataModel.h"

@implementation ModelTool

/** 处理分类数据  */
+(NSArray<CategoryModel *>*)processCategoricalData:(NSArray*)dataArray{
    
//    NSMutableArray *savaArray = [NSMutableArray array];
//    for (NSDictionary *dic in dataArray) {
//        CategoryModel *categoryModel = [[CategoryModel alloc]init];
//        categoryModel.categoryId = dic[@"id"];
//        categoryModel.categoryName = dic[@"categoryName"];
//        //读取子类数据
//        NSString *childNameStr = dic[@"childName"];
//        NSString *childImageStr = dic[@"childImage"];
//        NSString *childIdStr = dic[@"childId"];
//        //所有子类数据转数组
//        NSArray *childNameList =  [childNameStr componentsSeparatedByString:@","];
//        NSArray *childImageList =  [childImageStr componentsSeparatedByString:@","];
//        NSArray *childIdList =  [childIdStr componentsSeparatedByString:@","];
//        NSMutableArray *savaChildArray = [NSMutableArray array];
//        for (int i = 0; i < childIdList.count; i++) {
//            CategorySecondClassModel *secondClass = [[CategorySecondClassModel alloc]init];
//            secondClass.categoryId = childIdList[i];
//            secondClass.name = childNameList[i];
//            secondClass.imageUrl = childImageList[i];
//            [savaChildArray addObject:secondClass];
//        }
//
//        categoryModel.secondClassModels = savaChildArray;
//        [savaArray addObject:categoryModel];
//    }
//    return [NSArray arrayWithArray:savaArray];
    
    
    NSArray * categoryArray = [CategoryModel mj_objectArrayWithKeyValuesArray:dataArray];
    
    return categoryArray;
}

/** 字典写入plist文件*/
+(BOOL)writeFileToData:(NSDictionary *)dataDic forFileName:(NSString *)fileName{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:fileName];   //获取路径  
    //创建一个dic，写到plist文件里
    BOOL flag = [dataDic writeToFile:filename atomically:YES];
    return flag;
}

/** 打包订单数据 */
+(NSArray *)processingOrder:(NSArray *)orderArray{
    NSArray *orderList = [OrderModel mj_objectArrayWithKeyValuesArray:orderArray];
    return orderList;
}

/** 分装订单数据 */
+(NSArray *)processingFinishOrder:(NSArray *)orderArray withString:(NSString *)str{
    NSMutableArray *list = [NSMutableArray array];
    for (OrderModel *model in orderArray) {
        NSString *status = [NSString stringWithFormat:@"%@", model.tkStatus];
        if ([status isEqualToString:str] == YES) {
            [list addObject:model];
        }
    }
    
    return list;
}

/**
 打包 粉丝数据
 */
+(NSArray *)processingFans:(NSArray *)dataList{
    
    NSArray *list = [FansModel mj_objectArrayWithKeyValuesArray:dataList];
    return list;
}

/**
 处理RecommendModel数据
 */
+(NSMutableArray *)processingRecommendModelData:(NSArray *)datatArray{
    NSMutableArray *temp = [NSMutableArray array];
    
    NSArray *dataArray = [RecommendModel mj_objectArrayWithKeyValuesArray:datatArray];
    
    for (int i = 0; i < dataArray.count; i++) {
        RecommendModel *item = dataArray[i];
        CGFloat tableViewH = [ModelTool calculateCellHeight:item];
        item.tableViewH = tableViewH;
        [temp addObject:item];
    }
    return temp;
}

/**
 处理GroomModel数据
 */
+(NSMutableArray *)processingGroomModelData:(NSArray *)datatArray{
    NSMutableArray *temp = [NSMutableArray array];
    
    NSArray *dataArray = [GroomModel mj_objectArrayWithKeyValuesArray:datatArray];
    
    for (int i = 0; i < dataArray.count; i++) {
        GroomModel *item = dataArray[i];
        CGFloat tableViewH = [ModelTool calculateCellGroomHeight:item];
        item.tableViewH = tableViewH;
        [temp addObject:item];
    }
    return temp;
}

/// 打包消息数据
+(NSArray *)processingInfoModelData:(NSArray*)dataArray{
    NSArray *list = [InfoModel mj_objectArrayWithKeyValuesArray:dataArray];
    return list;
}


/**
 计算 Groom cell 高度
 */
+(CGFloat)calculateCellGroomHeight:(GroomModel *)model{
    CGFloat tableViewH = 0;
    CGFloat titleH = 68;
    
    CGFloat labelWidth = (ScreenWidth - 70 - 21);
    
    NSString *displayStr = [model.remark stringByAppendingString:@"\n"];
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[displayStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    //5.计算富文本的size
    CGSize size = [attrStr boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading |NSStringDrawingUsesDeviceMetrics context:nil].size;
    
    CGFloat imageH = 0;
    if (model.pics.count > 1) {
        
        for (int i = 0; i < model.pics.count ; i++) {
            int row = i/3;
            imageH = 20 +row *((75* WIDTHTPROPROTION)+10) +(75* WIDTHTPROPROTION);
        }
    }else{
        imageH = 178 + 20;
    }
    /* 最后的10 是自己加 的 */
    tableViewH = titleH + 10 + size.height +20 + 20 +imageH + 10 + 109 + 15 + 10;
    
    return tableViewH;
}

/**
 计算cell 高度
 */
+(CGFloat)calculateCellHeight:(RecommendModel *)model{
    CGFloat tableViewH = 0;
    CGFloat titleH = 68;
    
    CGFloat labelWidth = (ScreenWidth - 70 - 21);
    
    NSString *displayStr = [model.cText stringByAppendingString:@"\n"];
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[displayStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    //5.计算富文本的size
    CGSize size = [attrStr boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading |NSStringDrawingUsesDeviceMetrics context:nil].size;
    
    CGFloat imageH = 0;
    if (model.pics.count > 1) {
        
        for (int i = 0; i < model.pics.count ; i++) {
            int row = i/3;
            imageH = 20 +row *((75* WIDTHTPROPROTION)+10) +(75* WIDTHTPROPROTION);
        }
    }else{
        imageH = 178 + 20;
    }
    /* 最后的10 是自己加 的 */
    tableViewH = titleH + 10 + size.height +20 + 20 +imageH + 10 + 109 + 15 + 10;
    
    return tableViewH;
}

/// 处理Banner数据
+(NSMutableDictionary *)processBannerData:(NSArray*)dataArray{
    NSMutableDictionary *savaDic = [NSMutableDictionary dictionary];
    NSMutableArray *bannerArray = [NSMutableArray array];
    NSMutableArray *picArray = [NSMutableArray array];
    for (NSDictionary *dic in dataArray) {
        NSInteger level = [dic[@"level"] integerValue];
        BannerModel *banner = [[BannerModel alloc]init];
        banner.imgUrl = dic[@"imgUrl"];
        banner.imgID = dic[@"id"];
        banner.level = dic[@"level"];
        banner.name = dic[@"name"];
        banner.sort = dic[@"sort"];
        banner.toUrl = dic[@"toUrl"];
        banner.colour = dic[@"colour"];
        if (level == 0) {
            [bannerArray addObject:banner];
        }else if (level == 2) {
            [picArray addObject:banner];
        }else if (level == 1) {
            
        }
    }
    
    [savaDic setObject:bannerArray forKey:@"banner"];
    [savaDic setObject:picArray forKey:@"pic"];
    
    return savaDic;
}

/**json字符串转字典*/
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        //NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

///处理分类数据，只返回一级分类的名字
+(NSArray<NSString *>*)processPrimaryClassification:(NSArray*)dataArray{
    NSMutableArray *temp = [NSMutableArray array];
    
    NSArray *categoricalDataArray = [ModelTool processCategoricalData:dataArray];
    
    for (CategoryModel *tem in categoricalDataArray) {
        [temp addObject:tem.categoryName];
    }
    
    return [NSArray arrayWithArray:temp];
}

/** 处理url 数据 返回 字典 @param code url */
+(NSDictionary *)processingString:(NSString *)code{
    NSArray *dataArray = [code componentsSeparatedByString:@"?"];
    NSArray *parameterArray = [[dataArray lastObject]componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    for (NSString *tem in parameterArray) {
        NSArray *tempArray = [tem componentsSeparatedByString:@"="];
        [dic setObject:[tempArray lastObject] forKey:[tempArray firstObject]];
    }
    
    return dic;
}

+(void)saveSearchHistoryArrayToLocal:(NSArray *)historyStringArray {
//    [[NSUserDefaults standardUserDefaults] setObject:historyStringArray forKey:@"historyStringArray"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"test.plist"];
    NSLog(@"%@",filePath);
        BOOL isSuccess = [historyStringArray writeToFile:filePath atomically:YES];
        if (isSuccess) {
//            NSLog(@"成功");
        } else {
//            NSLog(@"失败");
        }
}

+(NSMutableArray *)getSearchHistoryArrayFromLocal{
//    NSArray *fileArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"historyStringArray"];
//
//
//    NSMutableArray * historyStringArray = [NSMutableArray arrayWithArray:fileArray];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
       NSString *filePath = [path stringByAppendingPathComponent:@"test.plist"];
       NSLog(@"%@",filePath);
    NSArray *tem = [NSArray arrayWithContentsOfFile:filePath];
    
    return [NSMutableArray arrayWithArray:tem];
}

/**
 *处理用户渠道 id
 */
+(UserAccessChannelsModel *)processingUserAccessChannelsModel:(NSDictionary *)dic{
    UserAccessChannelsModel *mode = [UserAccessChannelsModel mj_objectWithKeyValues:dic];
    return mode;
}

/// 处理时间数据
+(NSArray *)processingTimeData:(NSArray *)dataList{
    
//    @[
//        @{@"time":time
//          @"data":@[]
//        }
//    ]
    
    //先把传过来的数组转成 可变数组
    NSMutableArray *tempDataList = [NSMutableArray arrayWithArray:dataList];
    //保存所有时间相同的数据
    NSMutableArray *allModel = [NSMutableArray array];
    //比较时间，两层循环
    for (int i= 0; i < tempDataList.count; i++) {
        //单个相同时间的数组
        NSMutableArray *tem = [NSMutableArray array];
        //取出比较的时间
        InfoModel *modelI = tempDataList[i];
        //取出之后所有的时间
        for (int  j = i+1; j < tempDataList.count; j++) {
            //逐一取出时间
            InfoModel *modelJ = tempDataList[j];
            // 设置 时间格式
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            //解决8小时时间差问题
            [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
            unsigned unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
            //字符串 转化 NSDate 对象
            NSDate *iDate = [dateFormatter dateFromString:modelI.crTime];
            //要比较的时间
            NSDate *jData = [dateFormatter dateFromString:modelJ.crTime];
            //时间类
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents* comp1 = [calendar components:unitFlag fromDate:iDate];
            NSDateComponents* comp2 = [calendar components:unitFlag fromDate:jData];
            //判断时间是否为同一天
            BOOL isSameDay = [comp1 day] == [comp2 day] && [comp1 month] == [comp2 month] && [comp1 year]  == [comp2 year];
            if (isSameDay == YES) {
                //把之后所有相同的时间加入集合
                [tem addObject:modelJ];
                //移出所有的相同的时间数据
                [tempDataList removeObject:modelJ];
            }
        }
        //把取出的
        [tem addObject:modelI];
        
        
        //移出最先的比较时间数据
        [tempDataList removeObject:modelI];
        //过滤重复数据
        NSSet *set = [NSSet setWithArray:tem];
        //过滤后的数组
        NSArray *setArray = [set allObjects];
        //排序数据
        NSArray *newArray = [setArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {

            InfoModel *object1 = (InfoModel *)obj1;
            InfoModel *object2 = (InfoModel *)obj2;
            
            NSString *time1 = [self stampWithTime:object1.crTime];
            NSString *time2 = [self stampWithTime:object2.crTime];
            
            if([time1 doubleValue] < [time2 doubleValue]){
                return NSOrderedDescending;
                
            }else if([time1 doubleValue] > [time2 doubleValue]){
                
                return NSOrderedAscending;
                
            }return NSOrderedSame;
        }];
        
        //相同时间加在一起
        [allModel addObject:newArray];
        
        
    }
    NSMutableArray *assembly = [NSMutableArray array];
    for (NSArray * tem in allModel) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        InfoModel *model = [tem firstObject];
        [dic setValue:model.crTime forKey:@"time"];
        [dic setValue:tem forKey:@"data"];
        [assembly addObject:dic];
    }
    NSLog(@"assembly : %@", assembly);
    
    return assembly;
}

+(NSString *)stampWithTime:(NSString *)timestr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    // ----------设置你想要的格式
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //使用系统的时区
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    //将字符串按     formatter转成nsdate
    NSDate* date = [formatter dateFromString:timestr];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}

///整理消息数据
+(NSArray *)collateMessageData:(NSArray *)dataList{
    
    NSMutableArray *tem = [NSMutableArray array];
    for (NSDictionary *dic in dataList) {
        NSArray *allKeys = [dic allKeys];
        NSMutableDictionary *temDic = [NSMutableDictionary dictionary];
        for (NSString *key in allKeys) {
            NSArray *dataList = dic[key];
            NSArray *modelArray = [InfoModel mj_objectArrayWithKeyValuesArray:dataList];
            
            [temDic setValue:modelArray forKey:key];
            
        }
        
        [tem addObject:temDic];
    }
    return tem;
}

//处理 拼多多 查询商品目录列表
+(NSArray *)collatePddGoodsCatData:(NSArray *)dataList{
    NSArray *list = [PddGoodsOpt mj_objectArrayWithKeyValuesArray:dataList];
    return list;
}

///处理拼多多 商品列表
+(NSArray *)collatePddGoodsListData:(NSArray *)dataList{
    NSArray *list = [PddGoodsListModel mj_objectArrayWithKeyValuesArray:dataList];
    return list;
}


///处理京东 商品类目
+(NSArray *)collateJDGoodsCategoryData:(NSArray *)dataList{
    NSArray *list = [JDCategoryModel mj_objectArrayWithKeyValuesArray:dataList];
    return list;
}


///处理 常见问题 model 数据
+(NSArray *)getQuestionData:(NSArray *)dataList{
    NSArray *list = [QuestionModel mj_objectArrayWithKeyValuesArray:dataList];
    return list;
}

+(NSArray *)getQuestionListData:(NSArray *)dataList{
    NSArray *list = [QuestionListDataModel mj_objectArrayWithKeyValuesArray:dataList];
    return list;
}



@end
