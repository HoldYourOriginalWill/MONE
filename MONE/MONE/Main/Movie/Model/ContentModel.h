//
//  ContentModel.h
//  仿One
//
//  Created by Mac47 on 16/9/18.
//  Copyright © 2016年 ckn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface ContentModel : NSObject

@property (nonatomic, strong) NSString *content;     //观后感
@property (nonatomic, strong) UserModel *user;       //作者信息

@end
