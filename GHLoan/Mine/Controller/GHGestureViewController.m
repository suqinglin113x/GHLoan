//
//  GHGestureViewController.m
//  GHLoan
//
//  Created by Lin on 2017/9/11.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "GHGestureViewController.h"
#import "QLCircleView.h"
#import "QLCircleViewConst.h"
#import "QLMsgLabel.h"
#import "QLCircleInfoView.h"
#import "QLCircle.h"
#import "GHLockViewController.h"

@interface GHGestureViewController () <UINavigationControllerDelegate, CircleViewDelegte>
@property (nonatomic, strong) QLCircleView *lockView;
@property (nonatomic, strong) QLMsgLabel *msgLabel;
@property (nonatomic, strong) QLCircleInfoView *infoView;
@end

@implementation GHGestureViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 进来先清空存的第一个密码
    [QLCircleViewConst saveGesture:nil key:gestureFirstSaveKey];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:CircleViewBackgroundColor];;
    self.navigationController.delegate = self;
    // 1界面相同部分生成器
    [self setupSameUI];
    
    // 2界面不同部分生成器
    [self setupDifferentUI];
    
}

#pragma mark - 界面相同部分生成器
- (void)setupSameUI
{
    // 解锁界面
    QLCircleView *lockView = [[QLCircleView alloc] init];
    self.lockView = lockView;
    lockView.delegate = self;
    [self.view addSubview:lockView];
}

#pragma mark - 界面不同部分生成器
- (void)setupDifferentUI
{
    switch (self.type) {
        case GHGestureViewControllerTypeSetting:
            [self setupSubViewsSettingVc];
            break;
        default:
            break;
    }
}

#pragma mark - 设置界面手势密码
- (void)setupSubViewsSettingVc
{
    self.title = @"设置手势密码";
    [self.lockView setType:CircleViewTypeSetting];
    // 添加infoView
    [self.view addSubview:self.infoView];
    //
    [self.msgLabel showNormalMsg:gestureTextBeforeSet];
}

#pragma mark - CircleViewDelegte
- (void)circleView:(QLCircleView *)view type:(CircleViewType)type connectCircleLessThanNeedWithGesture:(NSString *)gesture
{
    NSString *firstGesture = [QLCircleViewConst getGestureWithKey:gestureFirstSaveKey];
    if (firstGesture.length) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"reset" style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightItem)];
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
    } else {
        [self.msgLabel showWarnMsgAndShake:gestureTextConnectLess];
    }
}
- (void)circleView:(QLCircleView *)view type:(CircleViewType)type didCompleteSetFirstGesture:(NSString *)gesture
{
    [self.msgLabel showNormalMsg:gestureTextDrawAgain];
    // 小提示图展示
    [self infoViewShowInView:view];
}
- (void)infoViewShowInView:(QLCircleView *)circleView
{
    for (QLCircle *circle in circleView.subviews) {
        
        if (circle.state == CircleStateSelected || circle.state == CircleStateLastOneSelected) {
            for (QLCircle *infoCircle in self.infoView.subviews) {
                
                if (infoCircle.tag == circle.tag) {
                    [infoCircle setState:CircleStateSelected];
                }
            }
        }
    }
}
- (void)circleView:(QLCircleView *)view type:(CircleViewType)type didCompleteSetSecondGesture:(NSString *)gesture result:(BOOL)equal
{
    if (equal) {
        [self.msgLabel showNormalMsg:gestureTextSetSuccess];
        [QLCircleViewConst saveGesture:gesture key:gestureFinalSaveKey];
        for (UIViewController *contriller in self.navigationController.viewControllers) {
            if ([contriller isKindOfClass:[GHLockViewController class]]) {
                
                [self.navigationController popToViewController:contriller animated:YES];
            }
        }
        
    } else {
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"reset" style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightItem)];
    }
}

#pragma mark - 重设按钮
- (void)didClickRightItem
{
    self.navigationItem.rightBarButtonItem.title = nil;
    [self infoViewDeselect];
    [self.msgLabel showNormalMsg:gestureTextBeforeSet];
    [QLCircleViewConst saveGesture:nil key:gestureFirstSaveKey];
}

#pragma mark - 去除infoView中选中的圆点
- (void)infoViewDeselect
{
    [self.infoView.subviews enumerateObjectsUsingBlock:^(__kindof QLCircle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.state = CircleStateNormal;
    }];
}

#pragma mark - lazy
- (QLMsgLabel *)msgLabel
{
    if (_msgLabel == nil) {
        _msgLabel = [[QLMsgLabel alloc] init];
        _msgLabel.bounds = CGRectMake(0, 0, kScreenW, 14);
        _msgLabel.center = CGPointMake(kScreenW / 2, CGRectGetMinY(self.lockView.frame) - 30);
        [self.view addSubview:_msgLabel];
    }
    return _msgLabel;
}
- (QLCircleInfoView *)infoView
{
    if (_infoView == nil) {
        _infoView = [[QLCircleInfoView alloc] initWithFrame:CGRectMake(0, 0, CircleRadius * 2 * 0.6, CircleRadius * 2 * 0.6)];
        _infoView.center = CGPointMake(kScreenW/2, CGRectGetMinY(self.msgLabel.frame) - CGRectGetHeight(_infoView.frame)/2 - 10);
    }
    return _infoView;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.type == GHGestureViewControllerTypeLogin) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}
@end
