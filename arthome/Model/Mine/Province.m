//
//  Province.m
//  UIDatePicker(键盘的简单处理)
//
//  Created by pkxing on 14/11/17.
//  Copyright (c) 2014年 梦醒. All rights reserved.
//

#import "Province.h"

@implementation Province

+(NSArray *)provinces
{
    NSBundle *bundle = [NSBundle mainBundle];

    NSString *path = [bundle pathForResource:@"newaddress" ofType:@"plist"];

    NSArray *array  = [NSArray arrayWithContentsOfFile:path];

    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *dict in array) {

        Province *province = [[Province alloc]init];
        
        NSMutableArray *cities = [NSMutableArray array];
        
        for (NSDictionary * dic in dict[@"cities"]) {
            
            City *city = [[City alloc]init];
            
            city.name = dic[@"name"];
            
            city.code = dic [@"code"];
            
            [cities addObject:city];
        }
        
        province.name = dict[@"name"];
        
        province.cities = cities;
        
        [arrayM addObject:province];
        
    }

    return arrayM;
}

@end
