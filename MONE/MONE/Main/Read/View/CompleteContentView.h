//
//  CompleteContentView.h
//  One 一个
//
//  Created by mac48 on 16/9/14.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompleteModel.h"
@interface CompleteContentView : UIView<UITableViewDelegate, UITableViewDataSource>
{
    NSString *desc;
    NSString *wb_name;
}
@property(nonatomic, assign)NSString *identity;
@property(nonatomic, assign)NSString *type;
@property (nonatomic, strong)CompleteModel *model;
@property (nonatomic, strong)AuthorModel *author;
@property (nonatomic, copy)NSArray *UIArray;
- (instancetype)initWithIdentity:(NSString *)identity
                            type:(NSString *)type
                           frame:(CGRect)frame;
@end
