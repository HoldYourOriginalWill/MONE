//
//  HomePageLayout.h
//  MONE
//
//  Created by THANAO on 5/9/16.
//  Copyright © 2016年 cz. All rights reserved.
//
#import "HomePageModel.h"
#import <Foundation/Foundation.h>

@interface HomePageLayout : NSObject

@property (strong, nonatomic) HomePageModel *pageModel;         // 需要自动布局的model

@property (assign, nonatomic, readonly) CGRect imageFrame;      // 图片frame
@property (assign, nonatomic, readonly) CGRect titleFrame;      // 标题frame
@property (assign, nonatomic, readonly) CGRect authorFrame;     // 作者frame
@property (assign, nonatomic, readonly) CGRect contentFrame;    // 内容frame
@property (assign, nonatomic, readonly) CGRect timeFrame;       // 时间frame


+ (instancetype)layoutWithHomePageModel:(HomePageModel *)model;
- (CGFloat)pageHeight;

@end
