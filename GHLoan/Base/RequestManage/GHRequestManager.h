//
//  GHRequestManager.h
//  GHLoan
//
//  Created by Lin on 2017/8/31.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 数据解析器类型

 - GHResponseSerializerTypeDefault: 默认JSON，如果使用这个响应解析器，那么返回的数据将会是JSON格式
 - GHResponseSerializerTypeJSON: JSON类型，如果使用这个响应解析器，那么返回的数据将会是JSON格式
 - GHResponseSerializerTypeXML: XML类型，如果使用这个响应解析器，那么请求返回的数据将会是XML格式
 - GHResponseSerializerTypePlist: Plist类型，如果使用这个响应解析器，那么返回的数据将会是Plist格式
 - GHResponseSerializerTypeData: Data类型，如果使用这个响应解析器，那么返回的数据将会是二进制格式
 */
typedef NS_ENUM(NSUInteger, GHResponseSerializerType){
    GHResponseSerializerTypeDefault,
    GHResponseSerializerTypeJSON,
    GHResponseSerializerTypeXML,
    GHResponseSerializerTypePlist,
    GHResponseSerializerTypeData
};

@interface GHRequestManager : NSObject

/**
 GET请求

 @param URLString URL
 @param parameters 参数
 @param type 数据解析类型
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void)GH_GET:(NSString *)URLString parameters:(id)parameters responseSerializerType:(GHResponseSerializerType)type success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


/**
 POST请求

 @param URLString URL
 @param parameters 参数
 @param type 数据解析类型
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)GH_POST:(NSString *)URLString parameters:(id)parameters responseSerializerType:()type success:(void(^)(id))success failure:(void(^)(NSError *))failure;
@end
