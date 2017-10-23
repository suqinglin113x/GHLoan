//
//  GHTabBarController.m
//  GHLoan
//
//  Created by Lin on 2017/8/24.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "GHTabBarController.h"


#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"
@interface GHTabBarController ()

@end

@implementation GHTabBarController

+ (void)initialize
{
    UITabBar *bar = [UITabBar appearance];
    bar.barTintColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    
    UITabBarItem *barItem = [UITabBarItem appearance];
    // 选中状态
    NSMutableDictionary *atts = [NSMutableDictionary dictionary];
    atts[NSForegroundColorAttributeName] = [UIColor colorWithRed:255.0/255.0 green:122.0/255.0 blue:123.0/255.0 alpha:1];
    atts[NSFontAttributeName] = [UIFont systemFontOfSize:12.f];
    [barItem setTitleTextAttributes:atts forState:UIControlStateSelected];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"GHHomeViewController",
                                   kTitleKey  : @"首页",
                                   kImgKey    : @"Home_normal",
                                   kSelImgKey : @"Home_selected"},
                                 
                                 @{kClassKey  : @"GHFinanceViewController",
                                   kTitleKey  : @"理财",
                                   kImgKey    : @"Finance_normal",
                                   kSelImgKey : @"Finance_selected"},
                                 
                                 @{kClassKey  : @"GHFindViewController",
                                   kTitleKey  : @"发现",
                                   kImgKey    : @"Find_normal",
                                   kSelImgKey : @"Find_selected"},
                                 
                                 @{kClassKey  : @"GHMineViewController",
                                   kTitleKey  : @"我",
                                   kImgKey    : @"Mine_normal",
                                   kSelImgKey : @"Mine_selected"} ];
    [childItemsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [NSClassFromString(obj[kClassKey]) new];
        [self addChildVC:vc title:obj[kTitleKey] normalImg:obj[kImgKey] selectedImg:obj[kSelImgKey]];
    }];
    
}

- (void)addChildVC:(UIViewController *)vc title:(NSString *)title normalImg:(NSString *)normalImg selectedImg:(NSString *)selectedImg
{
    GHBaseNavController *nav = [[GHBaseNavController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    [nav.tabBarItem setImage:[UIImage imageNamed:normalImg]];
    [nav.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self addChildViewController:nav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
