//
//  QLCircleViewConst.m
//  GHLoan
//
//  Created by Lin on 2017/9/11.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "QLCircleViewConst.h"

@implementation QLCircleViewConst
+ (void)saveGesture:(NSString *)gesture key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:gesture forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getGestureWithKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
@end
