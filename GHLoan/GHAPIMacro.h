
//
//  GHAPIMacro.h
//  GHLoan
//
//  Created by Lin on 2017/9/14.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#ifndef GHAPIMacro_h
#define GHAPIMacro_h
/** 内涵动态列表*/
#define kNHHomeServiceListAPI @"http://lf.snssdk.com/neihan/stream/mix/v1/?mpic=1&webp=1&essence=1&video_cdn_first=1&fetch_activity=1&content_type=-101&message_cursor=-1&longitude=116.28598550695&latitude=39.820226355117&am_longitude=116.288607&am_latitude=39.82425&am_city=%E5%8C%97%E4%BA%AC%E5%B8%82&am_loc_time=1504156142143&count=30&min_time=1504085988&screen_width=1080&double_col_mode=0&local_request_tag=1504156144425&iid=14333733581&device_id=34802906224&ac=wifi&channel=huawei&aid=7&app_name=joke_essay&version_code=651&version_name=6.5.1&device_platform=android&ssmix=a&device_type=H60-L01&device_brand=Huawei&os_api=23&os_version=6.0&uuid=866568020689500&openudid=c1c3120a0f664690&manifest_version_code=651&resolution=1080*1812&dpi=480&update_version_code=6512"

#pragma mark - 今日头条
#define BaseURL @""
//** 首页推荐*/
#define HomeRecommendAPI  @"https://lf.snssdk.com/api/news/feed/v65/?concern_id=6286225228934679042&refer=1&count=20&last_refresh_sub_entrance_interval=1505372393&loc_mode=6&loc_time=1505371552&city=%E5%8C%97%E4%BA%AC%E5%B8%82&lac=4461&cid=55385&cp=5d99baa9298e9q1&plugin_enable=3&iid=14553705546&device_id=34802906224&ac=wifi&channel=huawei&aid=13&app_name=news_article"

//    @"https://lf.snssdk.com/api/news/feed/v65/?concern_id=6286225228934679042&refer=1&count=20&min_behot_time=1505372345&last_refresh_sub_entrance_interval=1505372393&loc_mode=6&loc_time=1505371552&city=%E5%8C%97%E4%BA%AC%E5%B8%82&tt_from=pull&lac=4461&cid=55385&cp=5d99baa9298e9q1&plugin_enable=3&iid=14553705546&device_id=34802906224&ac=wifi&channel=huawei&aid=13&app_name=news_article"

//** 首页视频*/
#define HomeVideoAPI @"https://lf.snssdk.com/api/news/feed/v65/?category=video&refer=1&count=20&min_behot_time=1505024094&last_refresh_sub_entrance_interval=1505382787&loc_mode=6&loc_time=1505378317&latitude=39.823428815498&longitude=116.28368368768&city=%E5%8C%97%E4%BA%AC%E5%B8%82&tt_from=enter_auto&lac=4461&cid=55385&cp=5e9fb5a75e183q1&plugin_enable=3&iid=14553705546&device_id=34802906224&ac=wifi&channel=huawei&aid=13&app_name=news_article"

#endif /* GHAPIMacro_h */
