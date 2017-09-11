//
//  GHScrollHeaderView.m
//  GHLoan
//
//  Created by Lin on 2017/8/30.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "GHScrollHeaderView.h"

@interface GHScrollHeaderView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *bannerScrollV;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation GHScrollHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)addScrollBannerWithImgs:(NSArray *)imgs
{
    UIScrollView *bannerScrollV = [[UIScrollView alloc] initWithFrame:self.frame];
    bannerScrollV.contentSize = CGSizeMake(GHScreenWidth *imgs.count, bannerScrollV.gh_height);
    bannerScrollV.pagingEnabled = YES;
    bannerScrollV.delegate = self;
    bannerScrollV.showsVerticalScrollIndicator = bannerScrollV.showsHorizontalScrollIndicator = NO;
    [self addSubview:bannerScrollV];
    self.bannerScrollV = bannerScrollV;
    
    // 添加图片
    for (NSInteger i = 0; i < imgs.count; i ++) {
        UIImageView  *imV = [[UIImageView alloc] initWithFrame:CGRectZero];
        imV.frame = CGRectMake(bannerScrollV.gh_width *i, 0, bannerScrollV.gh_width, bannerScrollV.gh_height);
        imV.image = [UIImage imageNamed:imgs[i]];
        self.imgView = imV;
        [bannerScrollV addSubview:imV];
        
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImg)];
        [imV addGestureRecognizer:tap];
        
        // 图片添加文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.frame = imV.frame;
        [bannerScrollV addSubview:label];
        label.text = imgs[i];
        label.font = [UIFont systemFontOfSize:30.f];
        label.textColor = [UIColor yellowColor];
        label.tag = i + 1;
    }
    
    // 指示器
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    pageControl.gh_size = CGSizeMake(100, 30);
    pageControl.center = CGPointMake(bannerScrollV.gh_centerX, bannerScrollV.gh_height - 30);
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.numberOfPages = imgs.count;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
    // 添加定时器
    [self addTimer];
    
    
}


/**
 添加定时器
 */
- (void)addTimer
{
    self.timer = [NSTimer timerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSInteger index =self.pageControl.currentPage;
        if (index < self.pageControl.numberOfPages) {
            index ++;
        }
        if (index == self.pageControl.numberOfPages) {
            index = 0;
        }
        self.pageControl.currentPage = index;
        
        // 便移量
        CGFloat offsetx = GHScreenWidth *index;
        [self.bannerScrollV setContentOffset:CGPointMake(offsetx, 0) animated:YES];
 
    }];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];;
}

/**
 移除定时器
 */
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark -- UIScrollViewDelegate --
/**
 用户开始拖拽
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}
/**
  用户停止拖拽
  */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger currentIndex = (offset + GHScreenWidth *0.5) / GHScreenWidth;
    self.pageControl.currentPage = currentIndex;
    
    // 修改frame
    
}

#pragma mark -- 手势点击事件
- (void)clickImg
{
    NSInteger index = self.pageControl.currentPage;
    if (self.imgClick) {
        self.imgClick(index);
    }
}
@end
