//
//  GHRecommendModel.h
//  GHLoan
//
//  Created by Lin on 2017/9/14.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHRecommendModel : GHBaseModel
// 消息：success
@property (nonatomic, copy) NSString *message;
// 展示数据
@property (nonatomic, strong) NSArray *data;
// 总条数
@property (nonatomic, assign) NSInteger total_number;
// 登录状态：0或1
@property (nonatomic, assign) NSInteger login_status;

@property (nonatomic, strong) NSArray *tips;

@end

@interface GHRecommendTipModel : GHBaseModel
// 更新数据条数
@property (nonatomic, copy) NSString *display_info;
@end

@interface GHRecContentModel : GHBaseModel
// 摘要
@property (nonatomic, copy) NSString *abstract;
// 文章链接
@property (nonatomic, copy) NSString *article_url;
// 评论数
@property (nonatomic, assign) NSInteger comment_count;
// 标题
@property (nonatomic, copy) NSString *title;
// 作者
@property (nonatomic, copy) NSString *source;

@end
