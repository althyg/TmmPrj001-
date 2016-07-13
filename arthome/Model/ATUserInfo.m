//
//  ATUserInfo.m
//  arthome
//
//  Created by 海修杰 on 16/3/14.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ATUserInfo.h"

static ATUserInfo * userInfo=nil;

@implementation ATUserInfo

+(instancetype)shareUserInfo{
    if (!userInfo) {
        userInfo = [[self alloc] init];
    }
    return userInfo;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo=[super allocWithZone:zone];
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         userInfo.appToken = [defaults objectForKey:@"appToken"];
         userInfo.userType = [defaults objectForKey:@"userType"];
         userInfo.phone = [defaults objectForKey:@"phone"];
         userInfo.nickName = [defaults objectForKey:@"nickName"];
         userInfo.headUrl = [defaults objectForKey:@"headUrl"];
         userInfo.receName = [defaults objectForKey:@"receName"];
         userInfo.recePhone = [defaults objectForKey:@"recePhone"];
         userInfo.receLocation = [defaults objectForKey:@"receLocation"];
         userInfo.phoneBind = [defaults objectForKey:@"phoneBind"];
         userInfo.isArtistTip = [defaults objectForKey:@"isArtistTip"];
    });
    return userInfo;
}

-(void)saveAccountToSandBox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.appToken forKey:@"appToken"];
    [defaults setObject:self.userType forKey:@"userType"];
    [defaults setObject:self.phone forKey:@"phone"];
    [defaults setObject:self.nickName forKey:@"nickName"];
    [defaults setObject:self.headUrl forKey:@"headUrl"];
    [defaults setObject:self.receName forKey:@"receName"];
    [defaults setObject:self.recePhone forKey:@"recePhone"];
    [defaults setObject:self.receLocation forKey:@"receLocation"];
    [defaults setObject:self.phoneBind forKey:@"phoneBind"];
    [defaults setObject:self.isArtistTip forKey:@"isArtistTip"];
    [defaults synchronize];
}

- (void)userInformationFormLoginData:(NSDictionary *)infoDic{
    self.appToken = infoDic[@"appToken"];
    self.userType = infoDic[@"userType"];
    self.phone = infoDic[@"phone"];
    self.nickName = infoDic[@"nickName"];
    self.headUrl = infoDic[@"headUrl"];
    self.receName = infoDic[@"receName"];
    self.recePhone = infoDic[@"recePhone"];
    self.receLocation = infoDic[@"receLocation"];
    self.phoneBind = infoDic[@"phoneBind"];
    [self saveAccountToSandBox];
}

-(void)clearUserInfo{
    self.appToken = @"";
    self.userType = @"";
    self.phone = @"";
    self.nickName = @"";
    self.headUrl = @"";
    self.receName = @"";
    self.recePhone = @"";
    self.receLocation = @"";
    self.phoneBind = @"";
    [self saveAccountToSandBox];
}


@end
