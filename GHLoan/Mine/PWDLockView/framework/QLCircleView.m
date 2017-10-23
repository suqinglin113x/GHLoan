//
//  QLCircleView.m
//  GHLoan
//
//  Created by Lin on 2017/9/11.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "QLCircleView.h"
#import "QLCircleViewConst.h"
#import "QLCircle.h"


@interface QLCircleView ()
// 选中的圆的集合
@property (nonatomic, strong) NSMutableArray *circleSet;
// 当前点
@property (nonatomic, assign) CGPoint currentPoint;
// 数组清空标志
@property (nonatomic, assign) BOOL hasClean;

@end
@implementation QLCircleView

#pragma mark - 重写arrow setter方法
- (void)setArrow:(BOOL)arrow
{
    _arrow = arrow;
    
    // 遍历子控件，改变是否有箭头
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
}

- (NSMutableArray *)circleSet
{
    if (_circleSet == nil) {
        _circleSet = [NSMutableArray array];
    }
    return _circleSet;
}
#pragma mark - 初始化
- (instancetype)initWithType:(CircleViewType)type clip:(BOOL)clip arrow:(BOOL)arrow
{
    if (self = [super init]) {
        // 解锁视图准备
        [self lockViewPrepare];
        
        self.type = type;
        self.clip = clip;
        self.arrow = arrow;
    }
    return self;
}
- (instancetype)init
{
    if (self = [super init]) {
        // 解锁视图准备
        [self lockViewPrepare];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        // 解锁视图准备
        [self lockViewPrepare];
    }
    return self;
}

#pragma mark - 解锁视图准备
- (void)lockViewPrepare
{
    [self setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - CircleViewEdgeMargin *2, [UIScreen mainScreen].bounds.size.width - CircleViewEdgeMargin *2)];
    [self setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width / 2, CircleViewCenterY)];
    
    // 默认裁剪子控件
    self.clip = YES;
    self.arrow = YES;
    
    self.backgroundColor= CircleViewBackgroundColor;
    
    for (NSInteger i = 0; i < 9; i ++) {
        QLCircle *circle = [[QLCircle alloc] init];
        circle.type = CircleTypeGesture;
        circle.arrow = self.arrow;
        [self addSubview:circle];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 布局circle
    CGFloat itemWidth = CircleRadius *2;
    CGFloat marginValue = (self.bounds.size.width - itemWidth * 3) / 3;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat col = idx % 3;
        CGFloat row = idx / 3;
        
        CGFloat x = marginValue / 2 + itemWidth * col + marginValue * col;
        CGFloat y = marginValue / 2 + itemWidth * row + marginValue * row;
        
        subview.tag = idx + 1;
        CGRect frame = CGRectMake(x, y, itemWidth, itemWidth);
        subview.frame = frame;
    }];
}

#pragma mark - 手势
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 清空
    [self gestureEndResetMember];
    self.currentPoint = CGPointZero;
    CGPoint point = [[touches anyObject] locationInView:self];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof QLCircle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(obj.frame, point)) {
            obj.state = CircleStateSelected;
            [self.circleSet addObject:obj];
        }
    }];
    
    // 数组中最后一个对象处理
    [self circleSetLastObjectWithState:CircleStateLastOneSelected];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 
    self.currentPoint = CGPointZero;
    CGPoint point = [[touches anyObject] locationInView:self];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof QLCircle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(obj.frame, point)) {
            if ([self.circleSet containsObject:obj]) {
                
            } else {
                [self.circleSet addObject:obj];
                
                // 跳跃连线处理
                [self calAngleAndConnectTheTheJumpCircle];
            }
        } else {
            self.currentPoint = point;
        }
    }];
    
    [self.circleSet enumerateObjectsUsingBlock:^(QLCircle *circle, NSUInteger idx, BOOL * _Nonnull stop) {
        circle.state = CircleStateSelected;
    }];
    
    [self circleSetLastObjectWithState:CircleStateLastOneSelected];
    [self setNeedsDisplay];
}
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    return NO;
//}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setHasClean:NO];
    NSString *gesture = [self getGestureResultfromCircleSet:self.circleSet];
    CGFloat length = gesture.length;
    if (length == 0) {
        return;
    }
    // 手绘结果处理
    switch (self.type) {
        case CircleViewTypeSetting:
            [self gestureEndByTypeSettingWithGesture:gesture length:length];
            break;
         case CircleViewTypeModify:
            [self gestureEndByTypeModifyWithGesture:gesture length:length];
            break;
        default:
            [self gestureEndByTypeSettingWithGesture:gesture length:length];
            break;
    }
    // 手势结束后是否错误回显
    [self errorToDisplay];
}
#pragma mark - 解锁类型：设置 手势路径的处理
- (void)gestureEndByTypeSettingWithGesture:(NSString *)gesture length:(CGFloat)length
{
    if (length < CircleSetCountLeast) {
        // 通知代理
        if ([self.delegate respondsToSelector:@selector(circleView:type:connectCircleLessThanNeedWithGesture:)]) {
            [self.delegate circleView:self type:CircleViewTypeSetting connectCircleLessThanNeedWithGesture:gesture];
        }
        // 改变状态为error
        [self changeCircleInCircleSetWithState:CircleStateError];
    } else { // 连接多余4个
        NSString *firstgesture = [QLCircleViewConst getGestureWithKey:gestureFirstSaveKey];
        if (firstgesture.length < CircleSetCountLeast) {
            // 存储第一个密码
            [QLCircleViewConst saveGesture:gesture key:gestureFirstSaveKey];
            // 通知代理
            if ([self.delegate respondsToSelector:@selector(circleView:type:didCompleteSetFirstGesture:)]) {
                [self.delegate circleView:self type:CircleViewTypeSetting didCompleteSetFirstGesture:gesture];
            }
        } else { // 第二个密码 并进行比较
            BOOL equal = [gesture isEqualToString:firstgesture];
            // 通知代理
            if([self.delegate respondsToSelector:@selector(circleView:type:didCompleteSetSecondGesture:result:)]) {
                [self.delegate circleView:self type:CircleViewTypeSetting didCompleteSetSecondGesture:gesture result:equal];
            }
            if (equal) {
                [QLCircleViewConst saveGesture:gesture key:gestureFinalSaveKey];
            } else {
                // 不一致，重绘
                [self changeCircleInCircleSetWithState:CircleStateError];
            }
        }
    }
}
#pragma mark - 改变circle状态
- (void)changeCircleInCircleSetWithState:(CircleState)state
{
    
    [self.circleSet enumerateObjectsUsingBlock:^(QLCircle *circle, NSUInteger idx, BOOL * _Nonnull stop) {
        circle.state = state;
        
        if (state == CircleStateError) {
            if (idx == self.circleSet.count - 1) {
                circle.state = CircleStateLastOneError;
            }
        }
    }];
    
    [self setNeedsDisplay];
}
#pragma mark - 错误，恢复普通
- (void)errorToDisplay
{
    if ([self getCircleState] == CircleStateError || [self getCircleState] == CircleStateLastOneError) {
        // 错误状态时延迟一秒在进行下一步操作
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDisplayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self gestureEndResetMember];
        });
    } else {
        [self gestureEndResetMember];
    }
}

#pragma mark - 手势结束时的清空操作
- (void)gestureEndResetMember
{
    @synchronized (self) {
        if (!self.hasClean) {
            // 手势完毕，选中的圆恢复普通状态
            [self changeCircleInCircleSetWithState:CircleStateNormal];
            // 清空数组
            [self.circleSet removeAllObjects];
            // 清空方向
            //        [self resetAllCircleDirect];
            self.hasClean = YES;
        }
    }
}

#pragma mark - 解锁类型：修改原密码
- (void)gestureEndByTypeModifyWithGesture:(NSString *)gesture length:(CGFloat)length
{
    NSString *oldPassward = [QLCircleViewConst getGestureWithKey:gestureFinalSaveKey];
    BOOL equal = [gesture isEqualToString:oldPassward];
    if (equal) {
        if ([self.delegate respondsToSelector:@selector(circleView:type:didCompleteLoginGesture:result:)]) {
            [self.delegate circleView:self type:CircleViewTypeModify didCompleteLoginGesture:gesture result:equal];
        }
    } else {
        [self changeCircleInCircleSetWithState:CircleStateError];
    }
}

#pragma mark - 获得手势密码串
- (NSString *)getGestureResultfromCircleSet:(NSMutableArray *)setArray
{
    NSMutableString *resultStr = [NSMutableString string];
    for (QLCircle *circle in setArray) {
        [resultStr appendFormat:@"%@", @(circle.tag)];
    }
    return resultStr;
}
#pragma mark - 对数组中最后一个对象的处理
- (void)circleSetLastObjectWithState:(CircleState)state
{
    [[self.circleSet lastObject] setState:state];
}

#pragma mark - 获取当前选中圆的状态
- (CircleState)getCircleState
{
    return ((QLCircle *)[self.circleSet firstObject]).state;
}

#pragma mark - 处理三角形方向和跳跃连线
- (void)calAngleAndConnectTheTheJumpCircle
{
    if (self.circleSet == nil || self.circleSet.count < 2) {
        return;
    }
    // 三角形角度
    QLCircle *lastOne = [self.circleSet objectAtIndex:(self.circleSet.count - 1)];
    QLCircle *lastTwo = [self.circleSet objectAtIndex:(self.circleSet.count - 2)];
    
    CGFloat last_1_x = lastOne.center.x;
    CGFloat last_1_y = lastOne.center.y;
    CGFloat last_2_x = lastTwo.center.x;
    CGFloat last_2_y = lastTwo.center.y;
    CGFloat angle = atan2((last_1_y - last_2_y), (last_1_x - last_2_x)) + M_PI_2;
    [lastTwo setAngle:angle];
    
    // 跳跃连线
    CGFloat minX = fmin(last_1_x, last_2_x);
    CGFloat maxX = fmax(last_1_x, last_2_x);
    CGFloat minY = fmin(last_1_y, last_2_y);
    CGFloat maxY = fmax(last_1_y, last_2_y);
    CGPoint center = CGPointMake((maxX - minX) /2 + minX, (maxY - minY) /2 + minY);
    [self.subviews enumerateObjectsUsingBlock:^(__kindof QLCircle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(obj.frame, center)) {
            obj.angle = lastTwo.angle;
            [self.circleSet insertObject:obj atIndex:self.circleSet.count - 1];
        }
    }];
}

#pragma mark - 画线
- (void)drawRect:(CGRect)rect
{
    if (self.circleSet == nil || self.circleSet.count == 0) {
        return;
    }
    UIColor *color;
    if ([self getCircleState] == CircleStateError) {
        color = CircleConnectLineErrorColor;
    } else {
        color = CircleConnectLineNormalColor;
    }
    // 绘制线条
    [self connectCircleInRect:rect lineColor:color];
}
#pragma mark - 连线绘制图案
- (void)connectCircleInRect:(CGRect)rect lineColor:(UIColor *)color
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, rect);
    // 裁剪子控件
    [self clipSubViewWhenConnectInContext:context clip:self.clip];
    // 裁剪上下文
    CGContextEOClip(context);
    
    // 遍历选中的circle连线
    for (NSInteger index = 0; index < self.circleSet.count; index ++) {
        QLCircle *circle = self.circleSet[index];
        if (index == 0) {
            CGContextMoveToPoint(context, circle.center.x, circle.center.y);
        } else {
            CGContextAddLineToPoint(context, circle.center.x, circle.center.y);
        }
    }
    // 连接最后一个按钮到手指当前触摸点
    if (!CGPointEqualToPoint(self.currentPoint, CGPointZero)) {
        if ([self getCircleState] == CircleStateError || [self getCircleState] == CircleStateLastOneError) {
            // 如果是错误状态下不连接到当前的点
        } else {
            CGContextAddLineToPoint(context, self.currentPoint.x, self.currentPoint.y);
        }
    }
    
    // 线条转角样式
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, CircleConnectLineWidth);
    
    [color set];
    CGContextStrokePath(context);
}

#pragma mark - 是否裁剪子控件
- (void)clipSubViewWhenConnectInContext:(CGContextRef)context clip:(BOOL)clip
{
    if (clip) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGContextAddEllipseInRect(context, obj.frame);
        }];
    }
}
@end
