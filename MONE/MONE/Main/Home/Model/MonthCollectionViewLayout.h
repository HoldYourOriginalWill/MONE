//
//  MonthCollectionViewLayout.h
//  MONE
//
//  Created by Mac46 on 16/9/14.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MonthCollectionViewLayout;

@protocol MonthCollectionViewLayoutDelegate <NSObject>

@required
- (CGFloat)waterflowlayout:(MonthCollectionViewLayout *)waterlayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(MonthCollectionViewLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(MonthCollectionViewLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(MonthCollectionViewLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(MonthCollectionViewLayout *)waterflowLayout;

@end

@interface MonthCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, weak) id<MonthCollectionViewLayoutDelegate> delegate;
@end
