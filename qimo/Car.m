//
//  Car.m
//  qimo
//
//  Created by LiJiaXin on 25/5/26.
//  Copyright (c) 2025年 LiJiaXin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"
@implementation Car

+(instancetype)carWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
