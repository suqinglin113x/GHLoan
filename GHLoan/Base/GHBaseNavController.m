//
//  GHBaseNavController.m
//  GHLoan
//
//  Created by Lin on 2017/8/28.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "GHBaseNavController.h"

@interface GHBaseNavController ()

@end

@implementation GHBaseNavController

+ (void)initialize
{
    // 修改导航样式
    UINavigationBar  *navBar = [UINavigationBar appearance];
    [navBar setTranslucent:NO];
    navBar.barTintColor = [UIColor colorWithRed:0.86f green:0.85f blue:0.80f alpha:1.00f];
    navBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20],
                                   NSForegroundColorAttributeName:[UIColor colorWithRed:21/255.0 green:21/255.0 blue:21/255.0 alpha:1.0]};
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}


/**
 拦截操作
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 0) {
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
