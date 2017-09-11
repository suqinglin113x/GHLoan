//
//  GHRequestManager.m
//  GHLoan
//
//  Created by Lin on 2017/8/31.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "GHRequestManager.h"

@implementation GHRequestManager

+ (void)GH_GET:(NSString *)URLString parameters:(id)parameters responseSerializerType:()type success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/xml", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 设置https证书
//    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    policy.allowInvalidCertificates = YES;
//    manager.securityPolicy = policy;

    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)GH_POST:(NSString *)URLString parameters:(id)parameters responseSerializerType:(id)type success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
}
@end
