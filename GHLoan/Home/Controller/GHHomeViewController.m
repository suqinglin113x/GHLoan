//
//  GHHomeViewController.m
//  GHLoan
//
//  Created by Lin on 2017/8/24.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "GHHomeViewController.h"

@interface GHHomeViewController ()

@end

@implementation GHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"首页";
    
    [self hidenNav:YES];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 1, 100, 100)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}


// 隐藏导航栏
- (void)hidenNav:(BOOL)hidden
{
    self.navigationController.navigationBar.hidden = hidden;
}

- (void)addScrollBanner
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GHScreenWidth, 50)];
    
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
