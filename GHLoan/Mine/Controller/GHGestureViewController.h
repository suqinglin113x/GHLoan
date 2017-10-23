//
//  GHGestureViewController.h
//  GHLoan
//
//  Created by Lin on 2017/9/11.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GHGestureViewControllerType) {
    GHGestureViewControllerTypeSetting,
    GHGestureViewControllerTypeLogin,
    GHGestureViewControllerTypeModify,
};

@interface GHGestureViewController : UIViewController


/**
 控制器来源
 */
@property (nonatomic, assign) GHGestureViewControllerType type;

@end
