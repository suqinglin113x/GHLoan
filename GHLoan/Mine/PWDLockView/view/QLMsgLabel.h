//
//  QLMsgLabel.h
//  GHLoan
//
//  Created by Lin on 2017/9/12.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QLMsgLabel : UILabel

- (void)showNormalMsg:(NSString *)msg;

- (void)showWarnMsg:(NSString *)msg;
/**
 警示并震动
 */
- (void)showWarnMsgAndShake:(NSString *)msg;
@end
