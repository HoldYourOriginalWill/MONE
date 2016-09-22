//
//  MusicModel.h
//  One 一个
//
//  Created by mac48 on 16/9/19.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthorModel.h"
@interface MusicModel : NSObject
@property(nonatomic, copy)NSString *musicID;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *cover;
@property(nonatomic, copy)NSString *isfirst;
@property(nonatomic, copy)NSString *story_title;
@property(nonatomic, copy)NSString *story;
@property(nonatomic, copy)NSString *lyric;
@property(nonatomic, copy)NSString *info;
@property(nonatomic, copy)NSString *platform;
@property(nonatomic, copy)NSString *music_id;
@property(nonatomic, copy)NSString *charge_edt;
@property(nonatomic, copy)NSString *related_to;
@property(nonatomic, copy)NSString *web_url;
@property(nonatomic, copy)NSString *sort;
@property(nonatomic, copy)NSString *maketime;
@property(nonatomic, copy)NSString *last_update_date;
@property(nonatomic, copy)NSString *read_num;

@property(nonatomic, assign)NSInteger praisenum;
@property(nonatomic, assign)NSInteger sharenum;
@property(nonatomic, assign)NSInteger commentnum;

@property(nonatomic, strong)AuthorModel *author;
@property(nonatomic, strong)AuthorModel *story_author;
@end
