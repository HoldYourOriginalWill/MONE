//
//  HomePageModel.h
//  MONE
//
//  Created by THANAO on 4/9/16.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageModel : NSObject

// http://v3.wufazhuce.com:8000/api/hp/more/0

/*
 "author_id" = "-1";
 commentnum = 186;
 "hp_author" = "\U4e07";
 "hp_content" = "\U5973";
 "hp_img_original_url" = "http://image.wufazhuce.com/FlDFgAFVicIwfqO4cCeQFPB5LLSd";
 "hp_img_url" = "http://image.wufazhuce.com/FlDFgAFVicIwfqO4cCeQFPB5LLSd";
 "hp_makettime" = "2016-08-25 23:00:00";
 "hp_title" = "VOL.1419";
 "hpcontent_id" = 1444;
 "ipad_url" = "http://image.wufazhuce.com/FhCJDvZ8vgWvgA4M0sf9LFk2wvoL";
 "last_update_date" = "2016-08-18 17:00:14";
 praisenum = 27759;
 sharenum = 2834;
 "wb_img_url" = "";
 "web_url" = "http://m.wufazhuce.com/one/1444";
 */

@property (copy, nonatomic) NSString *author_id;        // 作者id
@property (copy, nonatomic) NSString *commentnum;       // 评论数
@property (copy, nonatomic) NSString *hp_author;        // 作者
@property (copy, nonatomic) NSString *hp_content;       // 短文内容
@property (copy, nonatomic) NSURL *hp_img_original_url; // 图片
@property (copy, nonatomic) NSURL *hp_img_url;
@property (copy, nonatomic) NSString *hp_makettime;     // 发布时间
@property (copy, nonatomic) NSString *hp_title;         // 短文标题
@property (copy, nonatomic) NSString *hpcontent_id;     // 短文编号
@property (copy, nonatomic) NSURL *ipad_url;
@property (copy, nonatomic) NSString *last_update_date; // 最后更新时间
@property (copy, nonatomic) NSString *praisenum;        // 点赞数
@property (copy, nonatomic) NSString *sharenum;         // 分享数
@property (copy, nonatomic) NSURL *wb_img_url;
@property (copy, nonatomic) NSURL *web_url;             // 网页版

@end
