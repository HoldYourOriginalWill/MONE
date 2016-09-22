//
//  QuestionModel.h
//  One 一个
//
//  Created by XinShangjie on 16/8/26.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthorModel.h"
@interface QuestionModel : NSObject
@property(nonatomic, copy)NSString *question_id;
@property(nonatomic, copy)NSString *question_title;
@property(nonatomic, copy)NSString *answer_title;
@property(nonatomic, copy)NSString *answer_content;
@property(nonatomic, copy)NSString *question_makettime;
@end
