//
//  QLCircleInfoView.m
//  GHLoan
//
//  Created by Lin on 2017/9/12.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "QLCircleInfoView.h"
#import "QLCircleViewConst.h"
#import "QLCircle.h"

@implementation QLCircleInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加小按钮
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.backgroundColor = CircleBackgroundColor;
    for (NSInteger i = 0; i < 9; i ++) {
        QLCircle *circle = [[QLCircle alloc] init];
        circle.type = CircleTypeInfo;
        [self addSubview:circle];
        
        CGFloat itemViewWH = CircleInfoRadius * 2;
        CGFloat marginValue = (self.frame.size.width - 3 * itemViewWH) / 3.0f;
        NSUInteger col = i % 3;
        
        NSUInteger row = i / 3;
        
        CGFloat y = marginValue * row + row * itemViewWH + marginValue/2;
        
        CGFloat x = marginValue * col + col * itemViewWH + marginValue/2;
        
        CGRect frame = CGRectMake(x, y, itemViewWH, itemViewWH);
        
        // 设置tag -> 密码记录的单元
        circle.tag = i + 1;
        
        circle.frame = frame;
    }
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    CGFloat itemViewWH = CircleInfoRadius * 2;
//    CGFloat marginValue = (self.frame.size.width - 3 * itemViewWH) / 3.0f;
//    
//    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
//        
//        NSUInteger col = idx % 3;
//        
//        NSUInteger row = idx / 3;
//        
//        CGFloat y = marginValue * row + row * itemViewWH + marginValue/2;
//        
//        CGFloat x = marginValue * col + col * itemViewWH + marginValue/2;
//        
//        CGRect frame = CGRectMake(x, y, itemViewWH, itemViewWH);
//        
//        // 设置tag -> 密码记录的单元
//        subview.tag = idx + 1;
//        
//        subview.frame = frame;
//    }];
//}
@end
