//
//  ContentTableViewCell.h
//  One 一个
//
//  Created by XinShangjie on 16/8/25.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentTableViewCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UIImageView *type;
@property (nonatomic, assign)NSString *identity;
@end
