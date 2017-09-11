//
//  UIView+GHFrame.m
//  GHLoan
//
//  Created by Lin on 2017/8/29.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "UIView+GHFrame.h"

@implementation UIView (GHFrame)


- (CGFloat)gh_x
{
    return self.frame.origin.x;
}
- (void)setGh_x:(CGFloat)gh_x
{
    CGRect rect = self.frame;
    rect.origin.x = gh_x;
    self.frame = rect;
}

- (CGFloat)gh_y
{
    return self.frame.origin.y;
}
- (void)setGh_y:(CGFloat)gh_y
{
    CGRect rect = self.frame;
    rect.origin.y = gh_y;
    self.frame = rect;
}

- (CGFloat)gh_width
{
    return self.frame.size.width;
}
- (void)setGh_width:(CGFloat)gh_width
{
    CGRect rect = self.frame;
    rect.size.width = gh_width;
    self.frame = rect;
}

- (CGFloat)gh_height
{
    return self.frame.size.height;
}
- (void)setGh_height:(CGFloat)gh_height
{
    CGRect rect = self.frame;
    rect.size.height = gh_height;
    self.frame = rect;
}

- (CGFloat)gh_centerX
{
    return self.center.x;
}
-  (void)setGh_centerX:(CGFloat)gh_centerX
{
    CGPoint point = self.center;
    point.x = gh_centerX;
    self.center = point;
}

- (CGFloat)gh_centerY
{
    return self.center.y;
}
- (void)setGh_centerY:(CGFloat)gh_centerY
{
    CGPoint point = self.center;
    point.y = gh_centerY;
    self.center = point;
}

- (CGSize)gh_size
{
    return self.frame.size;
}
- (void)setGh_size:(CGSize)gh_size
{
    CGRect rect = self.frame;
    rect.size = gh_size;
    self.frame = rect;
}
@end
