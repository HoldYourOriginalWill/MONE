//
//  IntroductionViewController.h
//  One 一个
//
//  Created by XinShangjie on 16/8/25.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EssayModel.h"
#import "SerialModel.h"
#import "QuestionModel.h"
#import "CompleteContentView.h"
@interface IntroductionViewController : UIViewController
@property (nonatomic, strong)NSDictionary *content;//contentID 内容编号 type 类型
@property (nonatomic, copy)NSArray *contentArray;
@property (nonatomic, copy)NSArray *modelArray;
@end
