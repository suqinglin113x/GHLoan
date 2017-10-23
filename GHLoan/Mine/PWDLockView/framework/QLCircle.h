//
//  QLCircle.h
//  GHLoan
//
//  Created by Lin on 2017/9/11.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  单个圆的各种状态
 */
typedef NS_ENUM(NSInteger, CircleState) {
    CircleStateNormal = 1,
    CircleStateSelected,
    CircleStateError,
    CircleStateLastOneSelected,
    CircleStateLastOneError
};

/**
 *  单个圆的用途类型
 */
typedef NS_ENUM(NSInteger, CircleType) {
    CircleTypeInfo = 1,
    CircleTypeGesture
};

@interface QLCircle : UIView

/** 所处的状态 */
@property (nonatomic, assign) CircleState state;

/** 类型 */
@property (nonatomic, assign) CircleType type;

/** 是否带箭头 */
@property (nonatomic, assign) BOOL arrow;

/** 角度 */
@property (nonatomic, assign) CGFloat angle;
@end
