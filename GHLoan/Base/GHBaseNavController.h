//
//  GHBaseNavController.h
//  GHLoan
//
//  Created by Lin on 2017/8/28.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHBaseNavController : UINavigationController

/**
 是否禁用返回拖拽手势 YES:启用 NO：禁用
 */
@property (nonatomic, assign) BOOL disableDragBack;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
- (void)back;
@end
