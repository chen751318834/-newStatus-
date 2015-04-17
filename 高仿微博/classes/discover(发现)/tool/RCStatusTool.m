//
//  RCStatusTool.m
//  高仿微博
//
//  Created by Raychen on 15/4/8.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCStatusTool.h"
#import "RCNetWorkingTool.h"
#import "RCStatusParam.h"
#import "RCStatusResult.h"
#import "MJExtension.h"
#import "RCUserParam.h"
#import "RCUserInfoResult.h"
#import "RCStatusFrame.h"
#import "FMDatabase.h"
#import "RCAccountTool.h"
#import "RCStatus.h"
#import "RCCommentParam.h"
#import "RCCommentResult.h"
#import "RCTransmitParam.h"
#import "RCTransmitResult.h"
@implementation RCStatusTool
static FMDatabase * _db;
+ (void)initialize{
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"stautses.sqlite"];
  _db =  [FMDatabase databaseWithPath:path];
    [_db open];
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_statuses(id integer PRAMARY KEY  AUTO INCREMENT,status blob NOT NULL,idstr text NOT NULL ,access_token text NOT NULL );"];
    
}
+ (void)saveStatuses:(NSArray *)statuses{
    for(RCStatus * status in statuses) {
        NSData * statusData = [NSKeyedArchiver
                                archivedDataWithRootObject:status];
        [_db executeUpdateWithFormat:@"INSERT INTO t_statuses(status ,idstr ,access_token) VALUES (%@ , %@ ,%@)",statusData,status.idstr,[RCAccountTool account].access_token];
    }
}


+ (NSArray *)statusesWithParam:(RCStatusParam *)param{
    NSString * sql = nil;
    if (param.since_id) {
        sql =[NSString stringWithFormat: @"SELECT status FROM t_statuses WHERE idstr>%@ ORDER BY idstr DESC LIMIT 20;",param.since_id];
    }else if (param.max_id){
     sql =[NSString stringWithFormat: @"SELECT status FROM t_statuses WHERE idstr<＝%@ ORDER BY idstr DESC LIMIT 20;",param.max_id];
    }
    else{
     sql = @"SELECT status FROM t_statuses ORDER BY idstr DESC LIMIT 20;";
    
    }
    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * statuses = [NSMutableArray array];
    while (set.next) {
       
        RCStatus * status = [NSKeyedUnarchiver unarchiveObjectWithData: [set dataForColumn:@"status"]];
        [statuses addObject:status];
       
    }
    return statuses;
}
+ (void)loadHomeStatusWithParam:(RCStatusParam *)param success:(void (^)(RCStatusResult *))success failure:(void (^)(NSError *))failure{
    NSArray * statuses = [self  statusesWithParam:param];
    if (statuses.count) { //有缓存
        if (success) {
            RCStatusResult * result = [[RCStatusResult alloc]init];
            result.statuses = statuses;
            success(result);

        }
    }else{  //没有缓存
        [RCNetWorkingTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:param.keyValues success:^(id json) {
            if (success) {
                RCStatusResult * result = [RCStatusResult objectWithKeyValues:json];
                [self saveStatuses:result.statuses];
                success(result);

            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

+(void)userInfoWithParam:(RCUserParam *)param success:(void (^)(RCUserInfoResult *))success failure:(void (^)(NSError *))failure{
    
    [RCNetWorkingTool get:@"https://api.weibo.com/2/users/show.json" params:param.keyValues success:^(id json) {
        if (success) {
            RCUserInfoResult * result = [RCUserInfoResult objectWithKeyValues:json];
            
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
+ (void)commentWithParam:(RCCommentParam *)param success:(void (^)(RCCommentResult *))success failure:(void (^)(NSError *))failure{
    [RCNetWorkingTool get:@"https://api.weibo.com/2/comments/show.json" params:param.keyValues success:^(id json) {
        if (success) {
            RCCommentResult * result = [RCCommentResult objectWithKeyValues:json];
            
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];


}
+ (void)transmitWithParam:(RCTransmitParam *)param success:(void (^)(RCTransmitResult *))success failure:(void (^)(NSError *))failure{
    [RCNetWorkingTool get:@"https://api.weibo.com/2/statuses/repost_timeline.json" params:param.keyValues success:^(id json) {
        if (success) {
            RCTransmitResult * result = [RCTransmitResult objectWithKeyValues:json];
            
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

}
@end
