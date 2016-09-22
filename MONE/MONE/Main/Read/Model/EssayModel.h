//
//  EssayModel.h
//  One 一个
//
//  Created by XinShangjie on 16/8/26.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthorModel.h"
@interface EssayModel : NSObject
@property(nonatomic, assign)BOOL has_audio;
@property(nonatomic, copy)NSString *content_id;
@property(nonatomic, strong)AuthorModel *author;
@property(nonatomic, copy)NSString *hp_makettime;
@property(nonatomic, copy)NSString *guide_word;
@property(nonatomic, copy)NSString *hp_title;
@end
