//
//  MonthDataLayout.h
//  MONE
//
//  Created by Mac46 on 16/9/14.
//  Copyright © 2016年 cz. All rights reserved.
//
#import "MonthDataModel.h"

#import <Foundation/Foundation.h>

@interface MonthDataLayout : NSObject

@property (strong, nonatomic) MonthDataModel *monthModel;

@property (assign, nonatomic) CGRect imageFrame;
@property (assign, nonatomic) CGRect titleFrame;

@property (assign, nonatomic) CGRect contentFrame;

+ (instancetype)layoutWithMonthDataModel:(MonthDataModel *)model;
- (CGFloat)height;
- (CGFloat)width;

@end
