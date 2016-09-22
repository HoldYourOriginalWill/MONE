//
//  CommentTableViewCell.h
//  仿One
//
//  Created by Mac47 on 16/9/18.
//  Copyright © 2016年 ckn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PraiseandModel.h"

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)setModel:(PraiseandModel *)model;

@end
