//
//  QLMsgLabel.m
//  GHLoan
//
//  Created by Lin on 2017/9/12.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "QLMsgLabel.h"
#import "QLCircleViewConst.h"

@implementation QLMsgLabel

- (instancetype)init
{
    if (self = [super init]) {
        // 初始化
        [self viewPepare];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self viewPepare];
    }
    return self;
}

- (void)viewPepare
{
    [self setFont:[UIFont systemFontOfSize:14.f]];
    [self setTextAlignment:NSTextAlignmentCenter];
}

- (void)showNormalMsg:(NSString *)msg
{
    [self setText:msg];
    [self setTextColor:textColorNormalState];
}

- (void)showWarnMsg:(NSString *)msg
{
    [self setText:msg];
    [self setTextColor:textColorWarningState];
}

- (void)showWarnMsgAndShake:(NSString *)msg
{
    [self setText:msg];
    [self setTextColor:textColorWarningState];
    
    // 添加shake动画
    CAKeyframeAnimation *keyAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    keyAni.values = @[@(-5), @0, @5, @0, @(-5), @0, @5, @0, @(-5)];
    keyAni.duration = 0.3f;
    keyAni.repeatCount = 2;
    keyAni.removedOnCompletion = NO;
    [self.layer addAnimation:keyAni forKey:@"shake"];
}
@end
