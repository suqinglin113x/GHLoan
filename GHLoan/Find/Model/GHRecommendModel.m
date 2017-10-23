//
//  GHRecommendModel.m
//  GHLoan
//
//  Created by Lin on 2017/9/14.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "GHRecommendModel.h"

@implementation GHRecommendModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    GHRecommendModel *model = [GHRecommendModel new];
    model.message = dict[@"message"];
    model.data = dict[@"data"];
    model.total_number = [dict[@"total_number"] integerValue];
    model.login_status = [dict[@"login_status"] integerValue];
    model.tips = dict[@"tips"];
    return model;
}
@end

@implementation GHRecommendTipModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    GHRecommendTipModel *model = [GHRecommendTipModel new];
    model.display_info = dict[@"display_info"];
    return model;
}

@end

@implementation GHRecContentModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    GHRecContentModel *model = [GHRecContentModel new];
    model.abstract = dict[@"abstract"];
    model.article_url = dict[@"article_url"];
    model.comment_count = [dict[@"comment_count"] integerValue];
    model.title = dict[@"title"];
    model.source = dict[@"source"];
    return model;
}
+ (instancetype)objWithDict:(NSDictionary *)dict
{
    NSMutableString * contentStr = dict[@"content"];
    NSData *data = [contentStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *contentDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    GHRecContentModel *model = [GHRecContentModel new];
    model.abstract = contentDict[@"abstract"];
    model.article_url = contentDict[@"article_url"];
    model.comment_count = [contentDict[@"comment_count"] integerValue];
    model.title = contentDict[@"title"];
    model.source = contentDict[@"source"];
    return model;
}
@end
