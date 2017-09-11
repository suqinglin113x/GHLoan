//
//  GHMineViewController.m
//  GHLoan
//
//  Created by Lin on 2017/8/24.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "GHMineViewController.h"
#import "GHLockViewController.h"

@interface GHMineViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation GHMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.topViewController.title = @"我的";
    
  
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, 0, GHScreenWidth, GHScreenHeight - 64);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    }
    return _tableView;
}
- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSArray arrayWithObjects:@[@"借款进度", @"我的还款", @"还款银行卡"], @[@"我的优惠券", @"邀请好友"], @[@"在线客服", @"消息中心", @"手势密码", @"更多"], nil];
    }
    return _dataArr;
}


#pragma mark -- UITableViewDataSource--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.dataArr[section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 1 && indexPath.row == 1) {
        cell.detailTextLabel.text = @"奖金可提现";
    }
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
    return cell;
}
#pragma mark -- UITableViewDelegate --
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 200;
    }
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [self loginHeadView];
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 2) {
        GHLockViewController *lockVC = [GHLockViewController new];
        [self.navigationController pushViewController:lockVC animated:YES];
    }
}
- (UIView *)loginHeadView
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GHScreenWidth, 200)];
    
    UIImageView *loginImgV = [[UIImageView alloc] initWithFrame:CGRectZero];
    loginImgV.center = backView.center;
    loginImgV.bounds = CGRectMake(0, 0, 100, 100);
    loginImgV.image = GHSetImageWithName(@"login");
    loginImgV.layer.cornerRadius = loginImgV.gh_width / 2;
    [backView addSubview:loginImgV];
    
    UIImageView *indicator = [[UIImageView alloc] initWithFrame:CGRectZero];
    CGFloat width = 60;
    indicator.frame = CGRectMake(GHScreenWidth - width - 10, loginImgV.gh_centerY - width *0.5, width, width);
    indicator.image = GHSetImageWithName(@"jiantou");
    [backView addSubview:indicator];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLab.center = CGPointMake(backView.gh_centerX, backView.gh_height - (backView.gh_height - loginImgV.gh_height) *0.5 *0.5);
    titleLab.bounds = CGRectMake(0, 0, 150, 30);
    titleLab.text = @"立即登录";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor whiteColor];
    [backView addSubview:titleLab];
    return backView;
}

@end
