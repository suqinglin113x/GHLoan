//
//  GHFindViewController.m
//  GHLoan
//
//  Created by Lin on 2017/8/24.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "GHFindViewController.h"
#import "GHRecommendModel.h"

@interface GHFindViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GHRecommendTipModel *tipModel;
@end

@implementation GHFindViewController
{
    long int _currentTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    
    // 适配ios11
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    NSDate *date = [NSDate date];
    NSTimeInterval currentTimer = [date timeIntervalSince1970];
    _currentTime = (long int)currentTimer;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSDictionary *param = @{@"tt_from" : @"pull",
                                @"min_behot_time" : [NSString stringWithFormat:@"%ld", _currentTime]};
        [self loadDataWithParameter:param];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        NSDictionary *param = @{@"tt_from" : @"pre_load_more",
                                @"max_behot_time" : [NSString stringWithFormat:@"%ld", _currentTime]};
        _currentTime -= 60;
        [self loadDataWithParameter:param];
    }];
    
    
}


#pragma mark - 网络请求
- (void)loadDataWithParameter:(NSDictionary *)param
{
    
    [GHRequestManager GH_GET:HomeRecommendAPI parameters:param responseSerializerType:0 success:^(id responseObject) {
        if (responseObject ) {
            self.tipModel = [[GHRecommendTipModel alloc] initWithDict:responseObject[@"tips"]];
            NSLog(@"%@", self.tipModel.display_info);
            NSArray *arr = responseObject[@"data"];
            NSMutableArray *temArr = [NSMutableArray array];
            for (NSInteger i = 0; i < arr.count; i ++) {
                GHRecContentModel *content = [GHRecContentModel objWithDict:arr[i]];
                if ([param[@"tt_from"] isEqualToString:@"pull"]) {
                    [temArr addObject:content];
                    [self.dataSource insertObject:content atIndex:0];
                } else {
                    
#warning some problems...
                    if (![self.dataSource containsObject:content]) {
                        NSLog(@"不包含");
                        [self.dataSource addObject:content];
                    } else {
                        
                    }
                    
                }
            }
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if (!responseObject[@"has_more"] ) {
                [self showRefreshMsgView];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self hideRefreshMsgView];
                });
            }
            
        }
    } failure:^(NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"IDCELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    GHRecContentModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GHRecContentModel *model = self.dataSource[indexPath.row];
    
}
#pragma mark - lazy
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, GHScreenWidth, GHScreenHeight - 64);
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = GHBackgroundColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark - 显示和隐藏数据更新弹框
- (void)showRefreshMsgView
{
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, GHScreenWidth, 30)];
    self.tableView.tableHeaderView = msgLabel;
    msgLabel.tag = 100;
    msgLabel.text = self.tipModel.display_info;
    msgLabel.textAlignment = 1;
    msgLabel.backgroundColor = GHRGBColor(211, 255, 255, 1);
    msgLabel.textColor = GHRGBColor(53, 178, 255, 1);
    msgLabel.font = [UIFont systemFontOfSize:15];
}
- (void)hideRefreshMsgView
{
    UILabel *msgLabel = (UILabel*)[self.view viewWithTag:100];
    self.tableView.tableHeaderView = nil;
    msgLabel = nil;
}

#pragma mark - 当前时间
- (void)currentTime
{
    
}
@end
