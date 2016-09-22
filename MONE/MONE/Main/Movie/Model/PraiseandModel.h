//
//  PraiseandModel.h
//  仿One
//
//  Created by Mac47 on 16/9/18.
//  Copyright © 2016年 ckn. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "UserModel.h"
#include "TouserModel.h"

@interface PraiseandModel : NSObject

@property (nonatomic, strong) NSString *quote;          //提问
@property (nonatomic, strong) NSString *content;        //评论
@property (nonatomic, strong) NSString *input_date;     //发表时间
@property (nonatomic, strong) UserModel *user;          //评论者
@property (nonatomic, strong) TouserModel *touser;      //被评论者

@end
