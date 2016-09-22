//
//  CommentLayer.m
//  仿One
//
//  Created by YF on 16/9/19.
//  Copyright © 2016年 ckn. All rights reserved.
//

#import "CommentLayer.h"


@implementation CommentLayer
{
    CGFloat _cellHeight;
}

+ (instancetype)layerWithPraiseandModel:(PraiseandModel *)PModel{
    
    CommentLayer *layer = [[CommentLayer alloc] init];
    if (layer) {
        layer.PModel = PModel;
    }
    return layer;
}

-(void)setPModel:(PraiseandModel *)PModel{
    
    if (_PModel == PModel) {
        return;
    }
    _PModel = PModel;
    _cellHeight = 0;
    _cellHeight += 60;
    _cellHeight += kSpaceWidth;
    
    NSDictionary *attributes = @{NSFontAttributeName : kContentFontSize};
    CGRect rect = [_PModel.content boundingRectWithSize:CGSizeMake(kScreenWidth - kSpaceWidth * 2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    _cellHeight += rect.size.height;
    _cellHeight += kSpaceWidth;
    
}

-(CGFloat)cellHeight{
    return _cellHeight;
}

@end
