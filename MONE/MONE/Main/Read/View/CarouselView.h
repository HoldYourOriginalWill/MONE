//
//  CarouselView.h
//  One 一个
//
//  Created by XinShangjie on 16/9/11.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"
#import "IntroductionViewController.h"
#import "CarouselContentModel.h"
#import "CarouselTableViewCell.h"
@interface CarouselView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *carouselContentArray;
    NSArray *heightArray;
    UITableView *contentTableView;
    CGFloat allHeight;
    UIButton *close;
    UIImageView *bottomImageView;
    CGPoint bottomImageViewCenter;
}
@property(nonatomic, strong)ImageModel *model;


@end
