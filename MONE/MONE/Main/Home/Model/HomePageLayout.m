//
//  HomePageLayout.m
//  MONE
//
//  Created by THANAO on 5/9/16.
//  Copyright © 2016年 cz. All rights reserved.
//
#define kPhotoHeight ((kScreenWidth - 30) * 0.75)   // 首页图片高度
#define kTitleHeight 20     // 
#define kTimeHeight 20      //

#import "HomePageLayout.h"

@interface HomePageLayout() {
    CGFloat _pageHeight;
}

@end

@implementation HomePageLayout

+ (instancetype)layoutWithHomePageModel:(HomePageModel *)model {
    
    HomePageLayout *pageLayout = [[HomePageLayout alloc] init];
    if (pageLayout) {
        pageLayout.pageModel = model;
    }
    return pageLayout;
}

- (void)setPageModel:(HomePageModel *)pageModel {
    if (_pageModel == pageModel) {
        return;
    }
    _pageModel = pageModel;
    _pageHeight = 0;
    
    _pageHeight += kSpaceWidth;
    
    _imageFrame = CGRectMake(kSpaceWidth, _pageHeight, kScreenWidth - 30, kPhotoHeight);
    _pageHeight += _imageFrame.size.height;
    _pageHeight += kSpaceWidth;
    
    _titleFrame = CGRectMake(kSpaceWidth, _pageHeight, 100, kTitleHeight);
    _authorFrame = CGRectMake(_titleFrame.origin.x + _titleFrame.size.width, _titleFrame.origin.y, _imageFrame.size.width - kSpaceWidth - _titleFrame.size.width, kTitleHeight);
    _pageHeight += _titleFrame.size.height;
    _pageHeight += kSpaceWidth * 2;
    
    CGSize size = CGSizeMake(kScreenWidth - 2 * (10 + kSpaceWidth * 2), 1000);
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 8;
    NSDictionary *attributes = @{NSFontAttributeName : kContentFontSize,
                                 NSParagraphStyleAttributeName : paragraph};
    CGRect rect = [_pageModel.hp_content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    _contentFrame = CGRectMake(kSpaceWidth * 2, _pageHeight, rect.size.width, rect.size.height);
    _pageHeight += _contentFrame.size.height;
    _pageHeight += 10 * kSpaceWidth;
    
    _timeFrame = CGRectMake(kScreenWidth - 135, _pageHeight, 110, kTimeHeight);
    _pageHeight += _timeFrame.size.height;
    _pageHeight += 2 * kSpaceWidth;
}

- (CGFloat)pageHeight {
    return _pageHeight;
}
@end
