//
//  DatabaseManager.h
//  qimo
//
//  Created by LiJiaXin on 25/5/26.
//  Copyright (c) 2025年 LiJiaXin. All rights reserved.
//

#ifndef qimo_DatabaseManager_h
#define qimo_DatabaseManager_h


#endif

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DatabaseManager : NSObject

+(instancetype)sharedInstance;
-(void)initializeDatabase;
-(void)updateViewCountForCarName:(NSString *)carName;
-(NSInteger)loadViewCountForName:(NSString *)carName;

@end