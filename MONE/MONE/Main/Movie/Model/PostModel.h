//
//  PostModel.h
//  仿One
//
//  Created by Mac47 on 16/9/18.
//  Copyright © 2016年 ckn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostModel : NSObject

@property (nonatomic, strong) NSString *score;             //评分
@property (nonatomic, strong) NSString *detailcover;       //海报
@property (nonatomic, strong) NSString *title;             //标题

@property (nonatomic, strong) NSString *keywords;          //相关电影
@property (nonatomic, strong) NSString *info;              //导演
@property (nonatomic, copy) NSArray *photo;                //图片数组

@end
