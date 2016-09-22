//
//  ContentView.m
//  仿One
//
//  Created by Mac47 on 16/9/20.
//  Copyright © 2016年 ckn. All rights reserved.
//

#import "ContentView.h"
@interface ContentView() {
    CGFloat _height;
}
@end

@implementation ContentView

- (void)makeViewWithImageURLStr:(NSString *)urlStr username:(NSString *)username content:(NSString *)content{
    _height = 0;
    _height += kSpaceWidth * 2;
    
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(kSpaceWidth * 2, kSpaceWidth * 2, 40, 40)];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    [self addSubview:_iconView];
    
    _height += _iconView.frame.size.height;
    _height += kSpaceWidth * 2;
    
    _username = [[UILabel alloc] initWithFrame:CGRectMake(55, kSpaceWidth * 2, 150, 20)];
    _username.font = kContentFontSize;
    _username.text = username;
    [self addSubview:_username];
    
    _contentL = [[UILabel alloc] init];
    _contentL.numberOfLines = 0;
    _contentL.backgroundColor = [UIColor whiteColor];
    _contentL.font = kContentFontSize;
    _contentL.text = content;
    NSDictionary *attri = @{NSFontAttributeName : kContentFontSize};
    CGRect rect = [content boundingRectWithSize:CGSizeMake(kScreenWidth - kSpaceWidth * 4, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
    [_contentL sizeToFit];
    _contentL.frame = CGRectMake(kSpaceWidth * 2, 50, kScreenWidth - kSpaceWidth * 4, rect.size.height);
    [self addSubview:_contentL];
    
    _height += kSpaceWidth * 2;
    _height += _contentL.frame.size.height;
    
    _hideBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 50, kSpaceWidth * 2, 40, 40)];
    [_hideBtn setImage:[UIImage imageNamed:@"unofficial_plot_default"] forState:UIControlStateNormal];
    [_hideBtn addTarget:self action:@selector(hideAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_hideBtn];

    _height += kSpaceWidth * 4;
}

- (CGFloat)height {
    return _height;
}

- (void)hideAction{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissCtrl" object:self];
}

@end
