//
//  ThirdShareTool.h
//  arthome
//
//  Created by 海修杰 on 16/5/16.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ShareBlock)(NSInteger);

@interface ThirdShareTool : NSObject

-(instancetype)initWithContent:(NSString*)shareLink;

-(void)handleBlock:(ShareBlock) shareBlock;

-(void)removeFromWindow;

@end
