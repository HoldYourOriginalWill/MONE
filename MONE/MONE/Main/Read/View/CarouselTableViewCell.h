//
//  CarouselTableViewCell.h
//  One 一个
//
//  Created by mac48 on 16/9/12.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarouselContentModel.h"
@class CarouselContentModel;
@interface CarouselTableViewCell : UITableViewCell
@property(nonatomic, strong)CarouselContentModel *model;
@end
