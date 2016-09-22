	//
//  ToolView.m
//  MONE
//
//  Created by THANAO on 9/9/16.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "ToolView.h"

@implementation ToolView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubViews];
    }
    return self;
}

- (void)_createSubViews {
    _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 64, 0, 44, 44)];
    [_shareButton setImage:[UIImage imageNamed:@"shareImage"] forState:UIControlStateNormal];
    [_shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_shareButton];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(_shareButton.frame.origin.x - 50, 0, 50, 44)];
    _label.textColor = [UIColor lightGrayColor];
    _label.font = [UIFont systemFontOfSize:14];
    [self addSubview:_label];
    
    _loveButton = [[UIButton alloc] initWithFrame:CGRectMake(_label.frame.origin.x - 44, 0, 44, 44)];
    if (_isSelect) {
        [_loveButton setImage:[UIImage imageNamed:@"like_selected"] forState:UIControlStateNormal];
    } else {
        [_loveButton setImage:[UIImage imageNamed:@"like_default"] forState:UIControlStateNormal];
    }
    
    [_loveButton addTarget:self action:@selector(loveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loveButton];
    
    UIButton *diaryButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 106, 42)];
    [diaryButton setImage:[UIImage imageNamed:@"diary_default"] forState:UIControlStateNormal];
    [self addSubview:diaryButton];
}

#pragma mark - buttonAction
- (void)shareAction {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"share" object:self];
}

- (void)loveAction:(UIButton *)sender {
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"praise" object:self];
}


@end
