//
//  ImageModel.h
//  One 一个
//
//  Created by XinShangjie on 16/8/22.
//  Copyright © 2016年 cz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject
@property(nonatomic, assign)NSInteger imageID;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSURL *cover;
@property(nonatomic, copy)NSString *bottom_text;
@property(nonatomic, copy)NSString *bgcolor;
@property(nonatomic, copy)NSURL *pv_url;
@end
