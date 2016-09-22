//
//  CarouselContentModel.h
//  One 一个
//
//  Created by mac48 on 16/9/12.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarouselContentModel : NSObject
@property(nonatomic, copy)NSString *item_id;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *introduction;
@property(nonatomic, copy)NSString *author;
@property(nonatomic, copy)NSString *web_url;
@property(nonatomic, assign)NSInteger number;
@property(nonatomic, copy)NSString *type;
@end
