//
//  QLCircleView.h
//  GHLoan
//
//  Created by Lin on 2017/9/11.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 手势密码界面类型
 */
typedef NS_ENUM(NSInteger, CircleViewType) {
    CircleViewTypeSetting,    // 设置手势密码
    CircleViewTypeLogin,      // 登录手势密码
    CircleViewTypeVerify,     // 验证
    CircleViewTypeModify      // 修改旧手势密码
};
@class QLCircleView;
@protocol  CircleViewDelegte <NSObject>

@optional
#pragma mark - 设置手势密码代理方法

/**
 连线少于4个时

 @param view QLCircleView
 @param type CircleViewType
 @param gesture 手势结果
 */
- (void)circleView:(QLCircleView *)view type:(CircleViewType)type connectCircleLessThanNeedWithGesture:(NSString *)gesture;

/**
 连线大于等于4个，获取到的第一个密码代理

 @param view QLCircleView
 @param type CircleViewType
 @param gesture 第一次保存的密码
 */
- (void)circleView:(QLCircleView *)view type:(CircleViewType)type didCompleteSetFirstGesture:(NSString *)gesture;

/**
 获取到第二个密码代理

 @param view QLCircleView
 @param type CircleViewType
 @param gesture 第二次密码
 @param equal 两次密码是否匹配
 */
- (void)circleView:(QLCircleView *)view type:(CircleViewType)type didCompleteSetSecondGesture:(NSString *)gesture result:(BOOL)equal;

#pragma mark - 登录手势密码代理方法

/**
 登录或者验证密码输入完成时的代理方法

 @param view QLCircleView
 @param type CircleViewType
 @param gesture 登录时密码
 @param equal 密码正确与否
 */
- (void)circleView:(QLCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal;

@end

@interface QLCircleView : UIView

/**
 是否裁剪，default is YES
 */
@property (nonatomic, assign) BOOL clip;

/**
 是否有箭头， default is YES.
 */
@property (nonatomic, assign) BOOL arrow;

/**
 解锁类型
 */
@property (nonatomic, assign) CircleViewType type;
@property (nonatomic, weak) id <CircleViewDelegte> delegate;

/**
 初始化方法
 */
- (instancetype)initWithType:(CircleViewType)type clip:(BOOL)clip arrow:(BOOL)arrow;
@end
