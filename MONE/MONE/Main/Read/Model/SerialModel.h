//
//  SerialModel.h
//  One 一个
//
//  Created by XinShangjie on 16/8/26.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthorModel.h"
@interface SerialModel : NSObject
@property(nonatomic, copy)NSString *number;
@property(nonatomic, copy)NSString *excerpt;
@property(nonatomic, copy)NSString *maketime;
@property(nonatomic, copy)NSString *serialID;
@property(nonatomic, strong)AuthorModel *author;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, assign)BOOL *has_audio;
@property(nonatomic, copy)NSString *read_num;
@property(nonatomic, copy)NSString *serial_id;
@end
