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

/** 内涵动态列表*/
NSString *const kNHHomeServiceListAPI = @"http://lf.snssdk.com/neihan/stream/mix/v1/?mpic=1&webp=1&essence=1&video_cdn_first=1&fetch_activity=1&content_type=-101&message_cursor=-1&longitude=116.28598550695&latitude=39.820226355117&am_longitude=116.288607&am_latitude=39.82425&am_city=%E5%8C%97%E4%BA%AC%E5%B8%82&am_loc_time=1504156142143&count=30&min_time=1504085988&screen_width=1080&double_col_mode=0&local_request_tag=1504156144425&iid=14333733581&device_id=34802906224&ac=wifi&channel=huawei&aid=7&app_name=joke_essay&version_code=651&version_name=6.5.1&device_platform=android&ssmix=a&device_type=H60-L01&device_brand=Huawei&os_api=23&os_version=6.0&uuid=866568020689500&openudid=c1c3120a0f664690&manifest_version_code=651&resolution=1080*1812&dpi=480&update_version_code=6512";


@interface GHHomeViewController () <UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation GHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"首页";
    
    [self hidenNav:YES];
    
    // 顶部banner
    GHScrollHeaderView *header = [[GHScrollHeaderView alloc] initWithFrame:CGRectMake(0, 0, GHScreenWidth, 200)];
    [self.tableView setTableHeaderView:header];
    [header addScrollBannerWithImgs:@[@"love_flower.jpg", @"love_night.jpg", @"waterColor.jpg"]];
    header.imgClick = ^(NSInteger index){
        NSLog(@"当前轮播%ld", index);
    };
    
    
    [GHRequestManager GH_GET:kNHHomeServiceListAPI parameters:nil responseSerializerType:nil success:^(id responseObject) {
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
}

#pragma mark - lazy init
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, GHScreenWidth, GHScreenHeight -64 -49);
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.0f];
//        _tableView.delegate = self;
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
