//
//  GHTools.m
//  GHLoan
//
//  Created by Lin on 2017/10/12.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "GHTools.h"
#import <sys/utsname.h>

@implementation GHTools

#pragma mark - 设备
+ (NSString *)deviceName
{
    NSString *devName;
    
    struct utsname info;
    uname(&info);
    NSString *platform = [NSString stringWithCString:info.machine encoding:NSUTF8StringEncoding];
    if ([platform isEqualToString:@"i386"]) {
        return @"Simulator";
    }
    if ([platform isEqualToString:@"x86_64"]) {
        return @"Simulator";
    }
    // iphone
    if ([platform isEqualToString:@"iPhone7,2"]) {
        return @"iPhone 6";
    }
    if ([platform isEqualToString:@"iPhone10,3"]) {
        return @"iPhone X";
    }
    return devName;
}



@end
