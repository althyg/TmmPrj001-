//
//  NSUserDefaults+Extension.h
//  arthome
//
//  Created by 海修杰 on 16/5/26.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Extension)
/**
 *  保存当前版本号到偏好设置
 */
+(void)saveCurrentVersion;


/**
 *  获取沙盒的版本号
 */
+(NSString *)versionFromSandBox;

/**
 *  获取Info.plist的版本号
 */
+(NSString *)versionFromInfoPlist;

@end
