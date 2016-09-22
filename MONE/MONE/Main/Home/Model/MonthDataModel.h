//
//  MonthDataModel.h
//  MONE
//
//  Created by Mac46 on 16/9/14.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MonthDataModel : NSObject

@property (copy, nonatomic) NSString *hp_content;       // 短文内容
@property (copy, nonatomic) NSURL *hp_img_original_url; // 图片
@property (copy, nonatomic) NSString *hp_title;         // 短文标题
@property (copy, nonatomic) NSString *hp_author;        // 作者
@property (copy, nonatomic) NSString *hp_makettime;     // 时间
@property (copy, nonatomic) NSString *praisenum;        // 点赞数
@property (copy, nonatomic) NSString *hpcontent_id;     // 短文编号

@end
