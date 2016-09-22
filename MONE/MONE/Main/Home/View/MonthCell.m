//
//  MonthCell.m
//  MONE
//
//  Created by Mac46 on 16/9/14.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "MonthCell.h"

@interface MonthCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation MonthCell

- (void)setModel:(MonthDataModel *)model {
    _model = model;
    
    [_imageView sd_setImageWithURL:_model.hp_img_original_url placeholderImage:[UIImage imageNamed:@"home"]];
    _titleLabel.text = _model.hp_title;
    _contentLabel.text = _model.hp_content;
}


- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
}



@end
