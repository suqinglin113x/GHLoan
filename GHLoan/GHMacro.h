//
//  GHMacro.h
//  GHLoan
//
//  Created by Lin on 2017/8/29.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#ifndef GHMacro_h
#define GHMacro_h


/** 屏幕尺寸 */
#define GHScreenWidth [UIScreen mainScreen].bounds.size.width
#define GHScreenHeight [UIScreen mainScreen].bounds.size.height
#define iPhone_X (GHScreenWidth == 375.f && GHScreenHeight == 812.f)
//** 设置图片 */
#define GHSetImageWithName(name) [UIImage imageNamed:[NSString stringWithFormat:@"%@", name]]

//** 十六进制颜色 */
#define GHHexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//** RGB颜色 */
#define GHRGBColor(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//** 背景颜色 */
#define GHBackgroundColor GHRGBColor(242, 242, 242, 1)

#endif /* GHMacro_h */
