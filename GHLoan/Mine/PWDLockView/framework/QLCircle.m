//
//  QLCircle.m
//  GHLoan
//
//  Created by Lin on 2017/9/11.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "QLCircle.h"
#import "QLCircleViewConst.h"

@interface QLCircle ()
/** 外环颜色*/
@property (nonatomic, strong) UIColor *outsideCircleColor;

/** 实心圆颜色*/
@property (nonatomic, strong) UIColor *insideCircleColor;

/** 三角形颜色*/
@property (nonatomic, strong) UIColor *triangleColor;

@end
@implementation QLCircle

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = CircleBackgroundColor;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = CircleBackgroundColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat scale;
    if (self.type == CircleTypeGesture) {
        scale = CircleRadio;
    } else {
        scale = 1;
    }
    CGRect circleRect = CGRectMake(CircleEdgeWidth, CircleEdgeWidth, rect.size.width - CircleEdgeWidth *2, rect.size.height - CircleEdgeWidth *2);
    
    // 旋转上下文
    [self transformCtx:context rect:rect];
    
    // 画圆环
    [self drawEmptyCircleWithContext:context rect:circleRect color:self.outsideCircleColor];
    
    // 画实心圆
    [self drawSolidCircleWithContext:context rect:rect scale:scale color:self.insideCircleColor];
    
    if (self.arrow) {
        // 画三角形箭头
        [self drawTriangleWithContext:context topPoint:CGPointMake(rect.size.width /2, 10) length:kTriangleLength color:self.triangleColor];
    }
}

#pragma mark - 画外圆环
- (void)drawEmptyCircleWithContext:(CGContextRef)ctx rect:(CGRect)rect color:(UIColor *)color
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, rect);
    CGContextAddPath(ctx, path);
    [color set];
    CGContextSetLineWidth(ctx, CircleEdgeWidth);
    CGContextStrokePath(ctx);
    CGPathRelease(path);
}
#pragma mark - 画实心圆
- (void)drawSolidCircleWithContext:(CGContextRef)ctx rect:(CGRect)rect scale:(CGFloat)scale color:(UIColor *)color
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(rect.size.width/2 *(1 - scale) + CircleEdgeWidth, rect.size.height/2 *(1 - scale) + CircleEdgeWidth, rect.size.width *scale - CircleEdgeWidth *2, rect.size.height *scale - CircleEdgeWidth *2));
    CGContextAddPath(ctx, path);
    [color set];
    CGContextFillPath(ctx);
    CGPathRelease(path);
}
#pragma mark - 画三角形
- (void)drawTriangleWithContext:(CGContextRef)ctx topPoint:(CGPoint)topPoint length:(CGFloat)length color:(UIColor *)color
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, topPoint.x, topPoint.y);
    CGPathAddLineToPoint(path, NULL, topPoint.x - length/2, topPoint.y + length/2);
    CGPathAddLineToPoint(path, NULL, topPoint.x + length/2, topPoint.y + length/2);
    [color set];
    CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    CGPathRelease(path);
}

#pragma mark - 上下文旋转
- (void)transformCtx:(CGContextRef)ctx rect:(CGRect)rect
{
    // 平移到中心点
    CGContextTranslateCTM(ctx, rect.size.width/2, rect.size.height/2);
    // 翻转
    CGContextRotateCTM(ctx, self.angle);
    // 平移回去
    CGContextTranslateCTM(ctx, -rect.size.width/2, -rect.size.height/2);
}

#pragma mark - lazy
- (UIColor *)outsideCircleColor
{
    UIColor *color;
    switch (self.state) {
        case CircleStateNormal:
            color = CircleStateNormalOutsideColor;
            break;
        case CircleStateSelected:
            color = CircleStateSelectedOutsideColor;
            break;
        case CircleStateLastOneSelected:
            color = CircleStateSelectedOutsideColor;
            break;
        case CircleStateError:
            color = CircleStateErrorOutsideColor;
            break;
        case CircleStateLastOneError:
            color = CircleStateErrorOutsideColor;
            break;
        default:
            color = CircleStateNormalOutsideColor;
            break;
    }
    return color;
}

- (UIColor *)insideCircleColor
{
    UIColor *color;
    switch (self.state) {
        case CircleStateNormal:
            color = CircleStateNormalInsideColor;
            break;
        case CircleStateSelected: case CircleStateLastOneSelected:
            color = CircleStateSelectedInsideColor;
            break;
        case CircleStateError: case CircleStateLastOneError:
            color = CircleStateErrorInsideColor;
            break;
        default:
            color = CircleStateNormalInsideColor;
            break;
    }
    return color;
}
- (UIColor *)triangleColor
{
    UIColor *color;
    switch (self.state) {
        case CircleStateNormal:
            color = CircleStateNormalTriangleColor;
            break;
        case CircleStateSelected:
            color = CircleStateSelectedTriangleColor;
            break;
        case CircleStateLastOneSelected:
            color = CircleStateNormalTriangleColor;
            break;
        case CircleStateError:
            color = CircleStateErrorTriangleColor;
            break;
        case CircleStateLastOneError:
            color = CircleStateNormalTriangleColor;
            break;
        default:
            color = CircleStateNormalTriangleColor;
            break;
    }
    return color;
}

#pragma mark - setter
- (void)setAngle:(CGFloat)angle
{
    _angle = angle;
    [self setNeedsDisplay];
}
- (void)setState:(CircleState)state
{
    _state = state;
    [self setNeedsDisplay];
}

@end
