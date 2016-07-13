//
//  GetCodeButton.m
//  YHOUSE
//
//  Created by FENG on 15-1-7.
//  Copyright (c) 2015年 FENG. All rights reserved.
//

#import "GetCodeButton.h"

@interface GetCodeButton()
{
    int indexCount;
//    SEL _action;
}
@property (nonatomic ,strong) NSTimer *timer;

@end

@implementation GetCodeButton
@synthesize timer;

- (void)dealloc
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:COLOR_da1025 forState:UIControlStateNormal];
        [self setTitleColor:COLOR_b3b3b3 forState:UIControlStateDisabled];
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.titleLabel.font = DEF_MyFont(13);
        
    }
    return self;
}

- (void)changeIndex
{
    [self setTitle:[NSString stringWithFormat:@"%ds重新发送",--indexCount] forState:UIControlStateNormal];
       if (indexCount == 0) {
        [self stop];
        
        if (_finish) {
            _finish();
        }
    }
}

- (void)start
{
    self.backgroundColor = COLOR_ffffff;
//    [self performSelector:_action];
    [self stop];
    self.isLoading = YES;
    indexCount = SECONDS_COUNT;
    self.enabled = NO;
    [self setTitle:[NSString stringWithFormat:@"%d",indexCount] forState:UIControlStateNormal];
    [self setTitle:[NSString stringWithFormat:@"%d秒重新发送",SECONDS_COUNT] forState:UIControlStateNormal];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 1
                                                  target: self
                                                selector: @selector(changeIndex)
                                                userInfo: nil
                                                 repeats: YES];
}

- (void)stop{
    self.isLoading = NO;
    [self setTitle:@"发送验证码" forState:UIControlStateNormal];
    self.enabled = YES;

    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [super addTarget:target action:action forControlEvents:controlEvents];
    
//    _action = action;
//    
//    Class class = [self class];
//    
//    SEL originalSelector = action;
//    SEL swizzledSelector = @selector(start);
//    
//    Method originalMethod = class_getInstanceMethod(class, originalSelector);
//    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//    
//    BOOL didAddMethod =
//    class_addMethod(class,
//                    originalSelector,
//                    method_getImplementation(swizzledMethod),
//                    method_getTypeEncoding(swizzledMethod));
//    
//    if (didAddMethod) {
//        class_replaceMethod(class,
//                            swizzledSelector,
//                            method_getImplementation(originalMethod),
//                            method_getTypeEncoding(originalMethod));
//    } else {
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//    }
    
}

#pragma mark - private

-(void)setDisabledColor:(UIColor *)disabledColor
{
    _disabledColor = disabledColor;
    
    [self setTitleColor:_disabledColor forState:UIControlStateDisabled];
}

-(void)setEnableColor:(UIColor *)enableColor
{
    _enableColor = enableColor;
    
    [self setTitleColor:_enableColor forState:UIControlStateNormal];
}

-(void)setFont:(UIFont *)font
{
    _font = font;
    
    self.titleLabel.font = font;
}

@end
