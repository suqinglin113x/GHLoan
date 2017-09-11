//
//  GHGroupModel.m
//  GHLoan
//
//  Created by Lin on 2017/9/1.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "GHGroupModel.h"

@implementation GHGroupModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    GHGroupModel *model = [GHGroupModel new];
    model.text = dict[@"text"];
    
    return model;
}
@end
