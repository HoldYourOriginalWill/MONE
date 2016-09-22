//
//  HomePage.h
//  MONE
//
//  Created by THANAO on 4/9/16.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "HomePageModel.h"
#import <UIKit/UIKit.h>

@interface HomePage : UIView 

@property (strong, nonatomic) UILabel *commentnum;              // 评论数
@property (strong, nonatomic) UILabel *hp_author;               // 作者
@property (strong, nonatomic) UILabel *hp_content;              // 短文内容
@property (strong, nonatomic) UIImageView *hp_img_original_url; // 图片
@property (strong, nonatomic) UILabel *hp_makettime;            // 发布时间
@property (strong, nonatomic) UILabel *hp_title;                // 短文标题
@property (strong, nonatomic) UILabel *praisenum;               // 点赞数
@property (strong, nonatomic) UIImageView *weatherImageView;    // 最新一期有天气
@property (strong, nonatomic) UILabel *earthLabel;              // 默认label

@property (strong, nonatomic) HomePageModel *model;

@property (strong, nonatomic) UIView *markView;
@property (assign, nonatomic) CGRect imageFrame;

@end
