//
//  GHBaseNavController.m
//  GHLoan
//
//  Created by Lin on 2017/8/28.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "GHBaseNavController.h"

#define enableDrag (self.viewControllers.count > 1 && self.disableDragBack)
typedef NS_ENUM(NSInteger, GHNavMovingState) {
    GHNavMovingStateStanBy,
    GHNavMovingStateDragBegan,
    GHNavMovingStateDragChanged,
    GHNavMovingStateDragEnd,
    GHNavMovingStateDecelerating
};
@interface GHBaseNavController () <UIGestureRecognizerDelegate>

/**
 黑色蒙版
 */
@property (nonatomic, strong) UIView *lastScreenBlackMask;

/**
 显示上一个界面的截屏
 */
@property (nonatomic, strong) UIImageView *lastScreenShotView;

/**
 显示上一个界面的截屏黑色背景
 */
@property (nonatomic, strong) UIView *backgroundView;

/**
 存放截屏的字典数组 key:控制器指针字符串 value:截屏图片
 */
@property (nonatomic, retain) NSMutableDictionary *screenShotDict;

/**
 移动状态
 */
@property (nonatomic, assign) GHNavMovingState movingState;


/**
 自定义的返回按钮
 */
@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation GHBaseNavController


+ (void)initialize
{
    // 修改导航条样式
    UINavigationBar  *navBar = [UINavigationBar appearance];
    [navBar setTranslucent:NO];
    navBar.barTintColor = [UIColor colorWithRed:0.86f green:0.85f blue:0.80f alpha:1.00f];
    navBar.titleTextAttributes = @{
                                   NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:20],
                                   NSForegroundColorAttributeName:GHRGBColor(21, 21, 21, 1),
                                   };
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // tabbar 底部留白去除
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 添加控制器手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(paningGestureReciver:)];
    pan.delegate = self;
    [pan delaysTouchesBegan];
    self.panGesture = pan;
//    [self.view addGestureRecognizer:pan];
}

#pragma mark -lazy
- (NSMutableDictionary *)screenShotDict
{
    if (_screenShotDict == nil) {
        _screenShotDict = [NSMutableDictionary dictionary];
    }
    return _screenShotDict;
}

- (UIView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] initWithFrame:self.view.frame];
        _backgroundView.backgroundColor = [UIColor redColor];
        
        _lastScreenShotView = [[UIImageView alloc] initWithFrame:_backgroundView.frame];
        _lastScreenShotView.backgroundColor = [UIColor greenColor];
        [_backgroundView addSubview:_lastScreenShotView];
        
        _lastScreenBlackMask = [[UIView alloc] initWithFrame:_backgroundView.bounds];
        _lastScreenBlackMask.backgroundColor = [UIColor yellowColor];
        [_backgroundView addSubview:_lastScreenBlackMask];
    }
    if (_backgroundView.superview == nil) {
        [self.view.superview insertSubview:_backgroundView belowSubview:self.view];
    }
    return _backgroundView;
}

/**
 拦截操作
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 每次push先移除手势
    [self.view removeGestureRecognizer:self.panGesture];
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [leftBtn setImage:GHSetImageWithName(@"back_guoheng") forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.tintColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        viewController.navigationItem.leftBarButtonItem = leftItem;
        
    }
    
    // 添加手势
    if (self.disableDragBack) {
        
        [self.view addGestureRecognizer:self.panGesture];
        [self.screenShotDict setObject:[self capture] forKey:[self pointer:self.topViewController]];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *poped = [super popViewControllerAnimated:animated];
    [self.screenShotDict removeObjectForKey:[self pointer:self.topViewController]];
    return poped;
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray<UIViewController *> *popedVCs = [super popToViewController:viewController animated:YES];
    for (UIViewController *vc in popedVCs) {
        [self.screenShotDict removeObjectForKey:[self pointer:vc]];
    }
    [self.screenShotDict removeObjectForKey:[self pointer:self.topViewController]];
    return popedVCs;
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    NSArray <UIViewController *> *popedVCS = [super popToRootViewControllerAnimated:YES];
    for (UIViewController *vc in popedVCS) {
        [self.screenShotDict removeObjectForKey:[self pointer:vc]];
    }
    [self.screenShotDict removeObjectForKey:self.topViewController];
    return popedVCS;
}

#pragma mark - 返回
- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - 截屏相关方法

/**
 当前导航界面的截屏
 */
- (UIImage *)capture
{
    UIView *view = self.view;
    if (self.tabBarController) {
        view = self.tabBarController.view;
    }
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 得到oc对象的指针字符串
 */
- (NSString *)pointer:(id)object
{
    return [NSString stringWithFormat:@"%p", object];
}

/**
 获取前一个界面的截图
 */
- (UIImage *)lastScreenShot
{
    UIViewController *lastVC = [self.viewControllers objectAtIndex:self.viewControllers.count - 2];
    return [self.screenShotDict objectForKey:[self pointer:lastVC]];
}

#pragma mark  - 手势 action
- (void)paningGestureReciver:(UIPanGestureRecognizer *)receiver
{
    if (!enableDrag) {
        return;
    }
    if (receiver.state == UIGestureRecognizerStateBegan) {
        if (self.movingState == GHNavMovingStateStanBy) {
            self.movingState = GHNavMovingStateDragBegan;
            self.backgroundView.hidden = NO;
            self.lastScreenShotView.image = [self lastScreenShot];
        }
    } else if (receiver.state == UIGestureRecognizerStateChanged){
        if (self.movingState == GHNavMovingStateDragBegan || self.movingState == GHNavMovingStateDragChanged) {
            self.movingState = GHNavMovingStateDragChanged;
            [self moveViewWithX:[receiver translationInView:[UIApplication sharedApplication].keyWindow].x];
        }
    } else if (receiver.state == UIGestureRecognizerStateEnded || receiver.state == UIGestureRecognizerStateCancelled) {
        if (self.movingState == GHNavMovingStateDragBegan || self.movingState == GHNavMovingStateDragChanged) {
            self.movingState = GHNavMovingStateDragEnd;
            [self panGestureDidFinish:receiver];
        }
    }
}
- (void)moveViewWithX:(CGFloat)x
{
    x = MAX(MIN(x, GHScreenWidth), 0);
    self.view.frame = (CGRect){{x, self.view.gh_y}, self.view.frame.size};
    self.lastScreenBlackMask.alpha = (1 - x/GHScreenWidth) *0.6;
}
- (void)panGestureDidFinish:(UIPanGestureRecognizer *)panGesture
{
    // 获取手指离开时的速率
    CGFloat velocityX = [panGesture velocityInView:[UIApplication sharedApplication].keyWindow].x;
    CGFloat translationX = [panGesture translationInView:[UIApplication sharedApplication].keyWindow].x;
    CGFloat decelerationTime = 0.4;
    // 按照一定的decelerationTime的衰减时间，计算出目标的位置
    CGFloat targetX = MIN(MAX(translationX + (velocityX *decelerationTime), 0), GHScreenWidth);
    BOOL pop = (targetX > 0.3 *GHScreenWidth);
    // 设置动画初始化速率为当前
    CGFloat initialSpringVelocity = fabs(velocityX)/(pop ? GHScreenWidth - translationX :translationX);
    self.movingState = GHNavMovingStateDecelerating;
    CGRect frame = (CGRect){{0, self.view.frame.origin.y}, self.view.bounds.size};
    BOOL adjusttabbarFrame = NO;
    if (self.tabBarController) {
        if (CGRectEqualToRect(frame, self.tabBarController.view.frame)) {
            adjusttabbarFrame = YES;
        }
        UIView *superView = self.view;
        while (superView != self.tabBarController.view && superView) {
            if (!CGRectEqualToRect(frame, self.tabBarController.view.frame)) {
                adjusttabbarFrame = NO;
                break;
            }
            superView = superView.superview;
        }
    }
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:1 initialSpringVelocity:initialSpringVelocity options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [weakSelf moveViewWithX:pop ? GHScreenWidth : 0];
        
    } completion:^(BOOL finished) {
        weakSelf.backgroundView.hidden = YES;
        if (pop) {
            [weakSelf popViewControllerAnimated:NO];
        }
        weakSelf.view.frame = frame;
        if (adjusttabbarFrame) {
            UIView *superView = weakSelf.view;
            while (superView != weakSelf.tabBarController.view && superView) {
                superView.frame = frame;
                superView = superView.superview;
            }
        }
        weakSelf.movingState = GHNavMovingStateStanBy;
    }];
}

/// 手势冲突处理
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    if (![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
//        return NO;
//    }
//    return YES;
//}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer
//{
//    Class class1 =  [gestureRecognizer class];
//    Class class2 = [otherGestureRecognizer class];
//
//    NSLog(@"%@ %@", class1, class2);
//    if (![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
//        return NO;
//    }
//    return NO;
//}

- (void)dealloc
{
    self.screenShotDict = nil;
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
}
@end
