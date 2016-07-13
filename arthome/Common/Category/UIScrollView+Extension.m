//
//  UIScrollView+Extension.m
//  arthome
//
//  Created by 海修杰 on 16/3/19.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "UIScrollView+Extension.h"

@implementation UIScrollView (Extension)

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

@end
