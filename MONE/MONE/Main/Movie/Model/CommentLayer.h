//
//  CommentLayer.h
//  仿One
//
//  Created by YF on 16/9/19.
//  Copyright © 2016年 ckn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PraiseandModel.h"

@interface CommentLayer : NSObject

@property (nonatomic, strong) PraiseandModel *PModel;

+ (instancetype)layerWithPraiseandModel:(PraiseandModel *)PModel;

@property (nonatomic, assign, readonly) CGRect textHeight;

- (CGFloat)cellHeight;

@end
