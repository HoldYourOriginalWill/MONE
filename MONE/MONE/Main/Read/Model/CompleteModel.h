//
//  CompleteModel.h
//  One 一个
//
//  Created by mac48 on 16/9/14.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthorModel.h"
@class AuthorModel;
@interface CompleteModel : NSObject
//通用
@property(nonatomic, strong)AuthorModel *author;//作者
@property(nonatomic, copy)NSString *last_update_date;//最后更新时间
@property(nonatomic, copy)NSURL *web_url;//网址
@property(nonatomic, assign)NSInteger praisenum;//点赞数
@property(nonatomic, assign)NSInteger sharenum;//分享数
@property(nonatomic, assign)NSInteger commentnum;//评论数
@property(nonatomic, copy)NSString *read_num;//连载，问答阅读数
@property(nonatomic, copy)NSString *guide_word;//文章，问答引导文字
//文章部分
@property(nonatomic, copy)NSString *content_id;//文章的id
@property(nonatomic, copy)NSString *hp_author_introduce;//责任编辑
@property(nonatomic, copy)NSString *hp_title;//标题
@property(nonatomic, copy)NSString *hp_content;//文章内容
@property(nonatomic, copy)NSString *hp_makettime;//创作时间
@property(nonatomic, copy)NSURL *audio;//音频网址
//连载部分
@property(nonatomic, copy)NSString *serialID;//连载的id
@property(nonatomic, copy)NSString *title;//标题
@property(nonatomic, copy)NSString *serial_id;//连载id
@property(nonatomic, copy)NSString *content;//连载内容
@property(nonatomic, copy)NSString *charge_edt;//责任编辑
@property(nonatomic, copy)NSString *maketime;//创作时间
@property(nonatomic, copy)NSString *number;//连载数量
@property(nonatomic, copy)NSString *excerpt;//概述
@property(nonatomic, copy)NSString *input_name;//输入名字
@property(nonatomic, copy)NSString *last_update_name;//最后更新的用户名
//问答部分
@property(nonatomic, copy)NSString *question_id;//问答的id
@property(nonatomic, copy)NSString *question_title;//问题标题
@property(nonatomic, copy)NSString *question_content;//问题内容
@property(nonatomic, copy)NSString *answer_title;//回答标题
@property(nonatomic, copy)NSString *answer_content;//回答内容
@property(nonatomic, copy)NSString *question_makettime;//创作时间
@property(nonatomic, copy)NSString *recommend_flag;

@end
