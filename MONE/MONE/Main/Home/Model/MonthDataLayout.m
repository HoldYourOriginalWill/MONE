//
//  MonthDataLayout.m
//  MONE
//
//  Created by Mac46 on 16/9/14.
//  Copyright © 2016年 cz. All rights reserved.
//

#define kCellWidth (kScreenWidth - 35) / 2

#import "MonthDataLayout.h"

@interface MonthDataLayout () {
    CGFloat _height;
}

@end


@implementation MonthDataLayout

+ (instancetype)layoutWithMonthDataModel:(MonthDataModel *)model {
    MonthDataLayout *layout = [[MonthDataLayout alloc] init];
    if (layout) {
        layout.monthModel = model;
    }
    return layout;
}

- (void)setMonthModel:(MonthDataModel *)monthModel {
    if (_monthModel == monthModel) {
        return;
    }
    _monthModel = monthModel;
    
    _height = 0;
    
    _imageFrame = CGRectMake(0, 0, kCellWidth, 130);
    _height += _imageFrame.size.height;
    
    _titleFrame = CGRectMake(0, _imageFrame.size.height - 15, kCellWidth, 15);
    
    CGSize size = CGSizeMake(kCellWidth - 10, 1000);
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:13]};
    CGRect rect = [_monthModel.hp_content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    _contentFrame = CGRectMake(0, _height, rect.size.width, rect.size.height);
    _height += _contentFrame.size.height;
}

- (CGFloat)height {
    return _height;
}

- (CGFloat)width {
    
    return kCellWidth - 5;
}

@end
