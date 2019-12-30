//
//  DBManager.m
//  ALiLikePurchase
//
//  Created by mac on 2019/8/23.
//  Copyright © 2019 郭超. All rights reserved.
//

#import "DBManager.h"
//#import "GoodsDBModel.h"
//#import "GoodsDetailModel.h"
#import "FMDatabase.h"

@interface DBManager ()
///管理对象上下文
@property(strong,nonatomic)NSManagedObjectContext *managerContenxt;

///模型对象
@property(strong,nonatomic)NSManagedObjectModel *managerModel;

///存储调度器
@property(strong,nonatomic)NSPersistentStoreCoordinator *maagerDinator;

@property(nonatomic, copy)NSString * dbPath;

///保存数据的方法
-(void)save;
@end

@implementation DBManager


-(void)createTableSqlString:(NSArray *)sqlStrings tableNames:(NSArray <NSString *>*)tableNames{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.dbPath = [doc stringByAppendingPathComponent:@"User.sqlite"];
    if ([fileManager fileExistsAtPath:self.dbPath] == NO) {
        FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]) {
            for (NSString *sql in sqlStrings) {
                BOOL res = [db executeUpdate:sql];
                if (res == NO) {
                    NSLog(@"创建数据表成功");
                }
            }
            [db close];
        } else {
            NSLog(@"创建数据库失败");
        }
    }else{
        //检查数据库有是否有想要创建的数据表
        
        FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
        
        if ([db open]) {
            int i = 0;
            for (NSString *tableName in tableNames) {
                NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", tableName ];
                
                FMResultSet *rs = [db executeQuery:existsSql];
                
                if ([rs next]) {
                    NSInteger count = [rs intForColumn:@"countNum"];
                    
                    if (count == 1) {
                        NSLog(@"存在");
                    }else{
                        NSString *sql = sqlStrings[i];
                        BOOL res = [db executeUpdate:sql];
                        if (res == NO) {
                            NSLog(@"创建数据表成功");
                        }
                        
                    }
                }
                i++;
            }
            [db close];
        }
    }
}

-(void)writeData:(GoodsDetailModel  *)model{
    
//    if ([self cleanData:model.numIid] == YES) {
//
//        Goods *goods = [NSEntityDescription insertNewObjectForEntityForName:@"Goods" inManagedObjectContext:self.managerContenxt];
//
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
//        goods.goodsId = model.numIid;
//        goods.goodsData = data;
//        goods.isFav = model.isfavorite;
//        goods.time = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
//
//        User *user = [[DataManager shareInstance]getUser];
//        if (user != nil) {
//            goods.token = user.appToken;
//        }
//
//        [self.managerContenxt save:nil];
//    }
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
//        NSString *deleteSql = [NSString stringWithFormat:@"delete from goods where goodsId ='%@'", model.numIid];
//        BOOL res = [db executeUpdate:deleteSql];
//        if (res == YES) {
//            NSString * sql = [NSString stringWithFormat:@"insert into %@ (%@) values(?, ?, ?, ?, ?) ", @"goods", @"goodsId,isFav,token,time,goodsData"];
//            NSString *goodsId = model.numIid;
//            NSString *isFav = model.isfavorite;
//            User *user = [[DataManager shareInstance]getUser];
//            NSString *token;
//            if (user != nil) {
//                token = user.appToken;
//            }else{
//                token = nil;
//            }
//            NSString *time = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
//            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
//            [db executeUpdate:sql, goodsId, isFav, token, time, data];
        }
        [db close];
//    }
    
    
}

-(NSArray *)readData{
    
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Goods"];
//
//    NSSortDescriptor *scoreSort = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:NO];
//    request.sortDescriptors = @[scoreSort];
//
//    NSArray *resArray = [self.managerContenxt executeFetchRequest:request error:nil];
//    NSMutableArray *goodsList = [NSMutableArray array];
//    for (Goods *itme in resArray) {
//        GoodsDetailModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:itme.goodsData];
//        if (model != nil) {
//            [goodsList addObject:model];
//        }
//    }
//
//    return goodsList;
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    NSMutableArray *saveArray = [NSMutableArray array];
    if ([db open]) {
        // 1.执行查询语句
        FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM goods ORDER BY time DESC"];
        
        
        // 2.遍历结果
        while ([resultSet next]) {
//            GoodsDBModel *item = [[GoodsDBModel alloc]init];
//
//            NSString *goodsId = [resultSet stringForColumn:@"goodsId"];
//            item.goodsId = goodsId;
//
//            NSString *isFav = [resultSet stringForColumn:@"isFav"];
//            item.isFav = isFav;
//
//            NSString *token = [resultSet stringForColumn:@"token"];
//            item.token = token;
//
//            NSData *goodsData = [resultSet dataForColumn:@"goodsData"];
//            item.goodsData = goodsData;
//            [saveArray addObject:item];
        }
        [db close];
    }
    
    
    NSMutableArray *goodsList = [NSMutableArray array];
//    for (GoodsDBModel *itme in saveArray) {
//        GoodsDetailModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:itme.goodsData];
//        if (model != nil) {
//            [goodsList addObject:model];
//        }
//    }

    
    
    return goodsList;
}

///查询单个商品
-(BOOL)cleanData:(NSString *)modelid{
    BOOL flag = NO;
//    //创建删除请求
//    NSFetchRequest *deleRequest = [NSFetchRequest fetchRequestWithEntityName:@"Goods"];
//    
//    //删除条件
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"goodsId = %@",modelid];
//    deleRequest.predicate = pre;
//    
//    //返回需要删除的对象数组
//    NSArray *deleArray = [self.managerContenxt executeFetchRequest:deleRequest error:nil];
//    
//    if (deleArray.count >0) {
//        //从数据库中删除
//        for (Goods *tem in deleArray) {
//            [self.managerContenxt deleteObject:tem];
//        }
//        
//        NSError *error = nil;
//        //保存--记住保存
//        if ([self.managerContenxt save:&error]) {
//            flag = YES;
//        }else{
//            flag = NO;
//        }
//    }else{
//        flag = YES;
//    }
//    
    return flag;
}


+(DBManager *)shareInstance{
    static DBManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DBManager alloc]init];
    });
    return instance;
}

#pragma mark - setter / getter

-(NSManagedObjectContext *)managerContenxt
{
    if (_managerContenxt == nil) {
        
        _managerContenxt = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        ///设置存储调度器
        [_managerContenxt setPersistentStoreCoordinator:self.maagerDinator];
    }
    return _managerContenxt;
}

-(NSManagedObjectModel *)managerModel
{
    
    if (_managerModel == nil) {
        
        _managerModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    }
    return _managerModel;
}


-(NSPersistentStoreCoordinator *)maagerDinator
{
    if (_maagerDinator == nil) {
        
        _maagerDinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.managerModel];
        
        //添加存储器
        /**
         * type:一般使用数据库存储方式NSSQLiteStoreType
         * configuration:配置信息 一般无需配置
         * URL:要保存的文件路径
         * options:参数信息 一般无需设置
         */
        
        //拼接url路径
        NSURL *url = [[self getDocumentUrlPath]URLByAppendingPathComponent:@"sqlit.db" isDirectory:YES];
        
        [_maagerDinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:nil];
    }
    return _maagerDinator;
}

-(NSURL*)getDocumentUrlPath
{
    ///获取文件位置
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]
    ;
}

-(void)save
{  ///保存数据
    [self.managerContenxt save:nil];
}

@end
