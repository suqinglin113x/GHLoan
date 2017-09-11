//
//  GHScrollHeaderView.h
//  GHLoan
//
//  Created by Lin on 2017/8/30.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHScrollHeaderView : UIView

@property (nonatomic, copy) void (^imgClick)(NSInteger);

- (void)addScrollBannerWithImgs:(NSArray *)imgs;
@end
