//
//  CarouselTableViewCell.m
//  One 一个
//
//  Created by mac48 on 16/9/12.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CarouselTableViewCell.h"

@implementation CarouselTableViewCell
-(void)setModel:(CarouselContentModel *)model{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(54, 38, kScreenWidth - 100, 200)];
    title.text = model.title;
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont boldSystemFontOfSize:18];
    title.numberOfLines = 0;
    [title sizeToFit];
    [self.contentView addSubview:title];
    
    CGRect rect = [model.title boundingRectWithSize:CGSizeMake(kScreenWidth - 100, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18]} context:nil];
    UILabel *author = [[UILabel alloc] initWithFrame:CGRectMake(54, rect.size.height + 38 + 5, 200, 12)];
    author.text = model.author;
    author.textColor = [UIColor whiteColor];
    author.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:author];
    
    UILabel *introduction = [[UILabel alloc] initWithFrame:CGRectMake(54, rect.size.height + 38 + 5 + 12 + 5, kScreenWidth - 80, 200)];
    introduction.text = model.introduction;
    introduction.textColor = [UIColor whiteColor];
    introduction.numberOfLines = 0;
    introduction.font = [UIFont systemFontOfSize:12];
    [introduction sizeToFit];
    [self.contentView addSubview:introduction];
}
@end
