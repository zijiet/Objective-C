//
//  CarGroup.m
//  qimo
//
//  Created by LiJiaXin on 25/5/26.
//  Copyright (c) 2025年 LiJiaXin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"
#import "CarGroup.h"
@implementation CarGroup

+(instancetype)groupWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        self.title=dict[@"title"];
        NSArray *arr=dict[@"cars"];
        NSMutableArray *carsArray=[NSMutableArray array];
        for(NSDictionary *dict in arr){
            Car *car=[Car carWithDict:dict];
            [carsArray addObject:car];
        }
        self.cars=carsArray;
    }
    return self;
}

@end
