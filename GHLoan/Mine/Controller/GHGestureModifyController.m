//
//  GHGestureModifyController.m
//  GHLoan
//
//  Created by Lin on 2017/9/13.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "GHGestureModifyController.h"
#import "QLCircleView.h"
#import "QLMsgLabel.h"
#import "QLCircleViewConst.h"
#import "GHGestureViewController.h"
#import "GHTabBarController.h"

@interface GHGestureModifyController () <CircleViewDelegte>

//** 文字提示Label*/
@property (nonatomic, strong) QLMsgLabel *msgLabel;

@end

@implementation GHGestureModifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.isToSetNewGesture ? @"修改原密码" : @"验证原密码";
    [self.view setBackgroundColor:CircleViewBackgroundColor];
    
    QLCircleView *circle = [[QLCircleView alloc] init];
    circle.delegate = self;
    circle.type = CircleViewTypeModify;
    [self.view addSubview:circle];
    
    QLMsgLabel *msgLabel = [[QLMsgLabel alloc] init];
    msgLabel.frame = CGRectMake(0, 0, GHScreenWidth, 14);
    msgLabel.center = CGPointMake(GHScreenWidth/2, CGRectGetMinY(circle.frame) - 30);
    [msgLabel showNormalMsg:gestureTextOldGesture];
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
}

#pragma mark - CircleViewDelegte
- (void)circleView:(QLCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    if (equal) {
        if (self.isToSetNewGesture) {
            GHGestureViewController *gestureVC = [[GHGestureViewController alloc] init];
            [self.navigationController pushViewController:gestureVC animated:YES];
        } else if (self.isfromMainView){
            [UIApplication sharedApplication].keyWindow.rootViewController = [GHTabBarController new];
        } else {
            [QLCircleViewConst saveGesture:nil key:gestureFinalSaveKey];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self.msgLabel setText:gestureTextVerifyError];
    }
}


@end
