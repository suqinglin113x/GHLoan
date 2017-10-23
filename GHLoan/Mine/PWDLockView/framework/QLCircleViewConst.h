//
//  QLCircleViewConst.h
//  GHLoan
//
//  Created by Lin on 2017/9/11.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import <Foundation/Foundation.h>

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

/**
 单个圆背景色
 */
#define CircleBackgroundColor [UIColor clearColor]

/**
 解锁背景色
 */
#define CircleViewBackgroundColor rgba(13, 52, 89, 1)

/**
 普通状态下外空心圆颜色
 */
#define CircleStateNormalOutsideColor rgba(241, 241, 241, 1)

/**
 选中状态下外空心圆颜色
 */
#define CircleStateSelectedOutsideColor rgba(34, 178, 246, 1)

/**
 错误状态下外空心圆颜色
 */
#define CircleStateErrorOutsideColor rgba(254, 82, 92, 1)

/**
 普通状态下内实心圆颜色
 */
#define CircleStateNormalInsideColor [UIColor clearColor]

/**
 选中状态下内实心圆颜色
 */
#define CircleStateSelectedInsideColor rgba(34, 178, 246, 1)

/**
 错误状态内实心圆颜色
 */
#define CircleStateErrorInsideColor rgba(254, 82, 92, 1)

/**
 普通状态下三角形颜色
 */
#define CircleStateNormalTriangleColor [UIColor clearColor]

/**
 选中状态下三角形颜色
 */
#define CircleStateSelectedTriangleColor rgba(34,178,246,1)

/**
 错误状态三角形颜色
 */
#define CircleStateErrorTriangleColor rgba(254,82,92,1)

/**
 三角形边长
 */
#define kTriangleLength  10.f

/**
 *  普通时连线颜色
 */
#define CircleConnectLineNormalColor rgba(34, 178, 246, 1)

/**
 *  错误时连线颜色
 */
#define CircleConnectLineErrorColor rgba(254, 82, 92, 1)

/**
 *  连线宽度
 */
#define CircleConnectLineWidth 1.0f

/**
 *  单个圆的半径
 */
#define CircleRadius 30.f

/**
 *  单个圆的圆心
 */
#define CircleCenter CGPointMake(CircleRadius, CircleRadius)

/**
 *  空心圆圆环宽度
 */
#define CircleEdgeWidth 1.0f

/**
 *  九宫格展示infoView 单个圆的半径
 */
#define CircleInfoRadius 5.f

/**
 *  内部实心圆占空心圆的比例系数
 */
#define CircleRadio 0.4
/**
 整个解锁view居中时，距离屏幕左边和右边的距离
 */
#define CircleViewEdgeMargin 30.f

/**
 *  整个解锁View的Center.y值 在当前屏幕的3/5位置
 */
#define CircleViewCenterY kScreenH * 1/2

/**
 *  连接的圆最少的个数
 */
#define CircleSetCountLeast 4

/**
 *  错误状态下回显的时间
 */
#define kDisplayTime 1.f

/**
 *  第一个手势密码存储key
 */
#define gestureFirstSaveKey @"gestureFirstSaveKey"

/**
 *  最终的手势密码存储key
 */
#define gestureFinalSaveKey @"gestureFinalSaveKey"

/**
 *  普通状态下文字提示的颜色
 */
#define textColorNormalState rgba(241,241,241,1)

/**
 *  警告状态下文字提示的颜色
 */
#define textColorWarningState rgba(254,82,92,1)

/**
 *  绘制解锁界面准备好时，提示文字
 */
#define gestureTextBeforeSet @"绘制解锁图案"

/**
 *  设置时，连线个数少，提示文字
 */
#define gestureTextConnectLess [NSString stringWithFormat:@"最少连接%d个点，请重新输入", CircleSetCountLeast]

/**
 *  再次绘制不一致，提示文字
 */
#define gestureTextDrawAgainError @"与上次绘制不一致，请重新绘制"

/**
 *  确认图案，提示再次绘制
 */
#define gestureTextDrawAgain @"再次绘制解锁图案"

/**
 *  设置成功
 */
#define gestureTextSetSuccess @"设置成功"

/**
 *  请输入原手势密码
 */
#define gestureTextOldGesture @"请输入原手势密码"

/**
 *  密码错误
 */
#define gestureTextVerifyError @"密码错误"

@interface QLCircleViewConst : NSObject

/**
 偏好设置：存字符串手势密码

 @param gesture 密码字符串
 @param key 存储key
 */
+ (void)saveGesture:(NSString *)gesture key:(NSString *)key;

/**
 偏好设置：取字符串手势密码
 @return 密码字符串
 */
+ (NSString *)getGestureWithKey:(NSString *)key;
@end
