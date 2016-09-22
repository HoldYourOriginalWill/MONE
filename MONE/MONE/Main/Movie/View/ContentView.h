//
//  ContentView.h
//  仿One
//
//  Created by Mac47 on 16/9/20.
//  Copyright © 2016年 ckn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentView : UIScrollView

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *username;
@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIButton *hideBtn;

- (void)makeViewWithImageURLStr:(NSString *)urlStr username:(NSString *)username content:(NSString *)content;
- (CGFloat)height;

@end
