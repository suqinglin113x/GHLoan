//
//  GHLockViewController.m
//  GHLoan
//
//  Created by Lin on 2017/9/11.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "GHLockViewController.h"
#import "GHGestureViewController.h"
#import "GHGestureModifyController.h"
#import "QLCircleViewConst.h"

@interface GHLockViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UISwitch *switchBtn;
@end

@implementation GHLockViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

    NSString *gesture = [QLCircleViewConst getGestureWithKey:gestureFinalSaveKey];
    self.switchBtn = [[UISwitch alloc] init];
    if (gesture) {
        self.switchBtn.on = YES;
        self.dataSource = [NSMutableArray arrayWithArray: @[@"设置手势密码", @"登录手势密码", @"修改手势密码"]];
    } else {
        self.switchBtn.on = NO;
        self.dataSource = [NSMutableArray arrayWithArray: @[@"设置手势密码", @"登录手势密码"]];
    }
    [self.tableView reloadData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 还原成NO
    GHBaseNavController *nav = (GHBaseNavController *)self.navigationController;
    nav.disableDragBack = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = GHBackgroundColor;
    self.navigationItem.title = @"手势密码";
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    if (indexPath.row == 0) {
        cell.accessoryView = self.switchBtn;
        [self.switchBtn addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        GHGestureModifyController *modifyVC = [[GHGestureModifyController alloc] init];
        modifyVC.isToSetNewGesture = YES;
        [self.navigationController pushViewController:modifyVC animated:YES];
    }
}

- (void)switchClick:(UISwitch *)sender
{
    
    if (sender.isOn) {
        GHGestureViewController *gesVC = [[GHGestureViewController alloc] init];
        gesVC.type = GHGestureViewControllerTypeSetting;
        // 还原成NO
//        GHBaseNavController *nav = (GHBaseNavController *)self.navigationController;
//        nav.disableDragBack = YES;
        [self.navigationController pushViewController:gesVC animated:YES];
    } else {
        GHGestureModifyController *modifyVC = [[GHGestureModifyController alloc] init];
        modifyVC.isToSetNewGesture = NO;
        [self.navigationController pushViewController:modifyVC animated:YES];
    }
}
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
@end
