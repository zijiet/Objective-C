//
//  Car.h
//  qimo
//
//  Created by LiJiaXin on 25/5/26.
//  Copyright (c) 2025年 LiJiaXin. All rights reserved.
//

#ifndef qimo_Car_h
#define qimo_Car_h


#endif

#import <Foundation/Foundation.h>
@interface Car:NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *icon;

+(instancetype)carWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end