//
//  DatabaseManager.m
//  qimo
//
//  Created by LiJiaXin on 25/5/26.
//  Copyright (c) 2025年 LiJiaXin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"

static DatabaseManager *sharedInstance=nil;
static sqlite3 *db=NULL;

@implementation DatabaseManager

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance=[[self alloc] init];
        [sharedInstance initializeDatabase];
    });
    return sharedInstance;
}

-(void)initializeDatabase{
    NSString *docdir=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *databasePath=[docdir stringByAppendingPathComponent:@"car_database.sqlite"];
    NSLog(@"%@",docdir);
    
    //create or open this database
    int result=sqlite3_open([databasePath UTF8String], &db);
    if(result==SQLITE_OK){
        NSLog(@"DB is opend.");
    }else{
        NSLog(@"DB is NOT opend.");
        return;
    }
    
    //create table
    const char *sql="create table if not exists car_views(car_name TEXT primary key ,view_count Integer default 0);";
    //response
    char *errmsg=NULL;
    result=sqlite3_exec(db, sql, NULL, NULL, &errmsg);
    if(result==SQLITE_OK){
        NSLog(@"table is created");
    }else{
        NSLog(@"table is NOT created");
        sqlite3_free(errmsg);
    }
}

-(void)updateViewCountForCarName:(NSString *)carName{
    const char *sql="insert or replace into car_views(car_name,view_count)""values(?,coalesce((select view_count from car_views where car_name=?),0)+1)";
//    const char *sql="update car_views set view_count=view_count+1 where car_name=?";
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(db,sql,-1,&stmt,NULL)==SQLITE_OK){
        sqlite3_bind_text(stmt,1,[carName UTF8String],-1,SQLITE_STATIC);
        sqlite3_bind_text(stmt,2,[carName UTF8String],-1,SQLITE_STATIC);
        if(sqlite3_step(stmt)!=SQLITE_DONE){
            NSLog(@"Failed to update view count:%s",sqlite3_errmsg(db));
        }else{
            NSLog(@"View count updated successfully for car: %@",carName);
        }
        sqlite3_finalize(stmt);
    }else{
        NSLog(@"Failed to prepared statement:%s",sqlite3_errmsg(db));
    }
}

-(NSInteger)loadViewCountForName:(NSString *)carName{
    __block NSInteger viewCount=0;
    const char *sql="select view_count from car_views where car_name=?";
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(db, sql,-1, &stmt, NULL)==SQLITE_OK){
        sqlite3_bind_text(stmt,1,[carName UTF8String],-1,SQLITE_STATIC);
        if(sqlite3_step(stmt)==SQLITE_ROW){
            viewCount=sqlite3_column_int(stmt, 0);
            NSLog(@"View count loaded successfully for car %@: %ld",carName,(long)viewCount);
        }else{
            NSLog(@"No row found for car: %@.",carName);
        }
        sqlite3_finalize(stmt);
    }else{
        NSLog(@"Failed to prepare statement:%s",sqlite3_errmsg(db));
    }
    return viewCount;
}

@end