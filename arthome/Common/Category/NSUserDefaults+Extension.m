//
//  NSUserDefaults+Extension.m
//  arthome
//
//  Created by 海修杰 on 16/5/26.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "NSUserDefaults+Extension.h"

//沙盒的版本key
#define kVersionInSandBox @"VersionInSandBox"

@implementation NSUserDefaults (Extension)

+(void)saveCurrentVersion{
    //保存当前应用版本号到沙盒
    NSString *currentVersion = [self versionFromInfoPlist];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentVersion forKey:kVersionInSandBox];
    [defaults synchronize];
}

+(NSString *)versionFromSandBox{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kVersionInSandBox];
}


+(NSString *)versionFromInfoPlist{
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    //    NSLog(@"%@",info);
    //获取当前版本
    NSString *versionKey =  (__bridge NSString *)kCFBundleVersionKey;
    NSString *currentVersion = info[versionKey];
    
    return currentVersion;
}



@end
