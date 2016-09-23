//
//  CustomScrollView.m
//  MONE
//
//  Created by THANAO on 9/9/16.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CustomScrollView.h"

typedef NS_ENUM(NSInteger, PagedOrthoScrollViewLockDirection) {
    PagedOrthoScrollViewLockDirectionNone,
    PagedOrthoScrollViewLockDirectionVertical,
    PagedOrthoScrollViewLockDirectionHorizontal
};

@interface CustomScrollView ()
@property (assign, nonatomic) PagedOrthoScrollViewLockDirection directionLock;
@property (assign, nonatomic) CGFloat valueLock;
@end

@implementation CustomScrollView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.directionLock = PagedOrthoScrollViewLockDirectionNone;
        self.valueLock = 0;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.directionalLockEnabled = YES;
    }
    return self;
}

- (void)setBounds:(CGRect)bounds {
    int mx, my;
    
    if (self.directionLock == PagedOrthoScrollViewLockDirectionNone) {

        mx = abs((int)CGRectGetMinX(bounds) % (int)CGRectGetWidth(self.bounds));

        if (mx != 0) {
            self.directionLock = PagedOrthoScrollViewLockDirectionVertical;
            self.valueLock = (round(CGRectGetMinY(bounds) / CGRectGetHeight(self.bounds)) * CGRectGetHeight(self.bounds));
        } else {
            self.directionLock = PagedOrthoScrollViewLockDirectionHorizontal;
            self.valueLock = (round(CGRectGetMinX(bounds) / CGRectGetWidth(self.bounds)) * CGRectGetWidth(self.bounds));
        }
    }
    
    if (self.directionLock == PagedOrthoScrollViewLockDirectionVertical) {
        bounds.origin.y = self.valueLock;
    } else {
        bounds.origin.x = self.valueLock;
    }
    
    mx = abs((int)CGRectGetMinX(bounds) % (int)CGRectGetWidth(self.bounds));
    my = abs((int)CGRectGetMinY(bounds) % (int)CGRectGetHeight(self.bounds));
    
    if (mx == 0 && my == 0) {
        self.directionLock = PagedOrthoScrollViewLockDirectionNone;
    }
    [super setBounds:bounds];
}

// 解决scrollView事件截获
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        return nil;
    }
    return hitView;
}

@end
