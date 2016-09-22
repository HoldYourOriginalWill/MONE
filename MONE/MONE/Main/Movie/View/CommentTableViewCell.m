//
//  CommentTableViewCell.m
//  仿One
//
//  Created by Mac47 on 16/9/18.
//  Copyright © 2016年 ckn. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell
{
    PraiseandModel *_PModel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setModel:(PraiseandModel *)model{
    
    _PModel = model;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_PModel.user.web_url]];
    _username.text = _PModel.user.user_name;
    
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = kContentFontSize;
    _contentLabel.text = _PModel.content;
    _timeLabel.text = _PModel.input_date;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
