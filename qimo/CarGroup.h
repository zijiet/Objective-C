//
//  CarGroup.h
//  qimo
//
//  Created by LiJiaXin on 25/5/26.
//  Copyright (c) 2025年 LiJiaXin. All rights reserved.
//

#ifndef qimo_CarGroup_h
#define qimo_CarGroup_h


#endif

#import <Foundation/Foundation.h>
#import "Car.h"
@interface CarGroup:NSObject

@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)NSArray *cars;

+(instancetype)groupWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end