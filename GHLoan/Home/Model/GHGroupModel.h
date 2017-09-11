//
//  GHGroupModel.h
//  GHLoan
//
//  Created by Lin on 2017/9/1.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHGroupModel : NSObject
//@property (nonatomic, strong) NSArray *large_image_list; //
@property (nonatomic, copy) NSString *text; //
//@property (nonatomic, assign) NSInteger id; // 67739811802
//@property (nonatomic, assign) NSInteger favorite_count; // 5
//@property (nonatomic, assign) NSInteger go_detail_count; // 27240


- (instancetype)initWithDict:(NSDictionary *)dict;
@end
