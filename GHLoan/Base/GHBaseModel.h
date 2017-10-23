//
//  GHBaseModel.h
//  GHLoan
//
//  Created by Lin on 2017/9/14.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHBaseModel : NSObject
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)objWithDict:(NSDictionary *)dict;
@end
