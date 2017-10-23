//
//  GHHomeViewController.m
//  GHLoan
//
//  Created by Lin on 2017/8/24.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "GHHomeViewController.h"
#import "GHScrollHeaderView.h"
#import "GHGroupModel.h"
#import "GHWKWebViewController.h"



@interface GHHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation GHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    } else {
        // Fallback on earlier versions
        // self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationItem.title = @"首页";
    
    
    [self hidenNav:YES];
    
    // 顶部banner
    GHScrollHeaderView *header = [[GHScrollHeaderView alloc] initWithFrame:CGRectMake(0, 0, GHScreenWidth, 200)];
    [self.tableView setTableHeaderView:header];
    [header addScrollBannerWithImgs:@[@"love_flower.jpg", @"love_night.jpg", @"waterColor.jpg"]];
    header.imgClick = ^(NSInteger index){
        NSLog(@"当前轮播%ld", index);
        self.tableView;
    };
    
    
    [GHRequestManager GH_GET:kNHHomeServiceListAPI parameters:nil responseSerializerType:GHResponseSerializerTypeJSON success:^(id responseObject) {
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"success"]) {
            
            NSArray *dataArr = [[responseObject objectForKey:@"data"] objectForKey:@"data"];
            for (NSInteger i = 0; i < dataArr.count; i ++ ) {
                NSDictionary *dict = dataArr[i];
                GHGroupModel *model = [[GHGroupModel alloc] initWithDict:dict[@"group"]];
                [self.dataSource addObject:model];
            }
        } else {
            NSLog(@"数据加载出现问题");
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


// 隐藏导航栏
- (void)hidenNav:(BOOL)hidden
{
    self.navigationController.navigationBar.hidden = hidden;
    self.tableView.gh_height = GHScreenHeight - 49;
}


#pragma mark -- UITableViewDataSource --
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
    GHGroupModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.text;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GHGroupModel *model = self.dataSource[indexPath.row];
    GHWKWebViewController *webVC = [[GHWKWebViewController alloc] init];
//    webVC.article_url = model.
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - lazy init
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, GHScreenWidth, self.view.bounds.size.height - 64 - 49);
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.0f];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"IDCELL"];
    }
    return _tableView;
}


- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}



@end
