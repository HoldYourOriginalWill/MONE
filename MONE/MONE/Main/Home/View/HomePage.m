//
//  HomePage.m
//  MONE
//
//  Created by THANAO on 4/9/16.
//  Copyright © 2016年 cz. All rights reserved.
//
#import "HomePageLayout.h"

#import "HomePage.h"


@implementation HomePage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.shadowOpacity = 1;
        self.layer.shadowOffset = CGSizeMake(0, 0.5);
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        [self _createDefaultView];
    }
    return self;
}

- (void)setModel:(HomePageModel *)model {
    _model = model;
    if (_model) {
        HomePageLayout *layout = [HomePageLayout layoutWithHomePageModel:_model];
        // 图片
        _hp_img_original_url.frame = layout.imageFrame;
        [_hp_img_original_url sd_setImageWithURL:_model.hp_img_original_url placeholderImage:[UIImage imageNamed:@"home"]];
        [self addSubview:_hp_img_original_url];
        
        // 标题
        _hp_title = [[UILabel alloc] initWithFrame:layout.titleFrame];
        _hp_title.text = _model.hp_title;
        _hp_title.font = [UIFont systemFontOfSize:12];
        _hp_title.textColor = [UIColor lightGrayColor];
        [self addSubview:_hp_title];
        
        // 作者
        _hp_author = [[UILabel alloc] initWithFrame:layout.authorFrame];
        _hp_author.text = _model.hp_author;
        _hp_author.font = [UIFont systemFontOfSize:12];
        _hp_author.textColor = [UIColor lightGrayColor];
        _hp_author.textAlignment = NSTextAlignmentRight;
        [self addSubview:_hp_author];
        
        // 内容
        _hp_content = [[UILabel alloc] initWithFrame:layout.contentFrame];
        _hp_content.numberOfLines = 0;
        _hp_content.font = kContentFontSize;
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:_model.hp_content];
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineSpacing = 8;
        [string addAttributes:@{NSParagraphStyleAttributeName : paragraph} range:NSMakeRange(0, string.length)];
        _hp_content.attributedText = string;
        [self addSubview:_hp_content];
        
        // 时间(时间格式化)
        _hp_makettime = [[UILabel alloc] initWithFrame:layout.timeFrame];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [formatter dateFromString:_model.hp_makettime];
        [formatter setDateFormat:@"EEE d MMM. yyyy"];
        NSString *timeString = [formatter stringFromDate:date];
        
        _hp_makettime.text = timeString;
        _hp_makettime.font = [UIFont systemFontOfSize:12];
        _hp_makettime.textColor = [UIColor lightGrayColor];
        _hp_makettime.textAlignment = NSTextAlignmentRight;
        [self addSubview:_hp_makettime];
        
        // 时间若相差在20小时以上，则移除earthLabel
        NSDate *nextDate = [NSDate dateWithTimeInterval:3600 * 20 sinceDate:date];
        NSDate *currentDate = [NSDate date];
        // num = 0
        if ([currentDate compare:nextDate] <= -1) {
            _earthLabel.frame = CGRectMake(_hp_makettime.frame.origin.x - 70, _hp_makettime.frame.origin.y - 2, 70, 24);
            _weatherImageView.frame = CGRectMake(_earthLabel.frame.origin.x - 26, _hp_makettime.frame.origin.y - 2, 24, 24);
        } else {
            _earthLabel.hidden = YES;
            _weatherImageView.hidden = YES;
        }
        
    }
    
}

#pragma mark - 不考虑网络状况时创建的内容视图
- (void)_createDefaultView {

    _markView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _markView.backgroundColor = [UIColor clearColor];
    _markView.hidden = YES;
    // 将遮罩视图添加到当前窗口根视图控制器
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_markView];

    
    _hp_img_original_url = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, ((kScreenWidth - 30) * 0.75))];
    _hp_img_original_url.image = [UIImage imageNamed:@"home"];
    _hp_img_original_url.userInteractionEnabled = YES;
    _hp_img_original_url.exclusiveTouch = YES;
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBiggerAction:)];
    [_hp_img_original_url addGestureRecognizer:tap];
    [self addSubview:_hp_img_original_url];
    
    
    _earthLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 75, 5 + _hp_img_original_url.frame.size.height + 80, 70, 24)];
    _earthLabel.text = @"X℃ 地球";
    _earthLabel.textAlignment = NSTextAlignmentCenter;
    _earthLabel.font = [UIFont systemFontOfSize:13];
    _earthLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_earthLabel];
    
    _weatherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_earthLabel.frame.origin.x - 28, 5 + _hp_img_original_url.frame.size.height + 80, 24, 24)];
    _weatherImageView.image = [UIImage imageNamed:@"weather_unknown"];
    [self addSubview:_weatherImageView];
    
 
}

#pragma mark - 图片点击放大效果
- (void)tapBiggerAction:(UIGestureRecognizer *)tap {

    _markView.hidden = NO;
    
    UIImageView *imageView = (UIImageView *)tap.view;
    UIImageView *reImageView = [[UIImageView alloc] init];
    reImageView.image = imageView.image;
    reImageView.contentMode = UIViewContentModeScaleAspectFit;
    reImageView.userInteractionEnabled = YES;
    [_markView addSubview:reImageView];
    
    // 获取原图大小
    _imageFrame = [self convertRect:tap.view.frame toView:_markView];
    reImageView.frame = _imageFrame;
    
    [UIView animateWithDuration:0.25 animations:^{
        reImageView.frame = _markView.bounds;
        _markView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        
    } completion:^(BOOL finished) {
        
    }];
    
    UITapGestureRecognizer *reTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSmallerAction:)];
    [reImageView addGestureRecognizer:reTap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(saveImage)];
    [reImageView addGestureRecognizer:longPress];
}

- (void)tapSmallerAction:(UIGestureRecognizer *)tap {
    
    UIImageView *imageView = (UIImageView *)tap.view;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        imageView.frame = _imageFrame;
        _markView.backgroundColor = [UIColor clearColor];

    } completion:^(BOOL finished) {
        [UIApplication sharedApplication].keyWindow.rootViewController.tabBarController.tabBar.hidden = NO;
        _markView.hidden = YES;
        [imageView removeFromSuperview];
    }];
}

- (void)saveImage {
    
    NSDictionary *dic = @{@"image" : _hp_img_original_url.image};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"save" object:self userInfo:dic];
    
}

@end
