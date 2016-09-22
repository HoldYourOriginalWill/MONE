//
//  NightModeActivity.m
//  MONE
//
//  Created by Mac46 on 16/9/13.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "NightModeActivity.h"

@implementation NightModeActivity

- (NSString*)activityType
{
    //相当于 UIActivityTypeAirDrop, 可以用来判断是什么Activity类型
    return @"com.one.ActionNightMode";
}

- (NSString*)activityTitle
{
    // 显示的Title
    return @"夜间模式";
}
- (UIImage*)activityImage
{
    // 显示的图标，ios8及以后是彩色，大小可以查看此方法的文档
    return [UIImage imageNamed:@"nightModeIcon"];
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    //在此做操作，items就是要传输的数据
    NSLog(@"%@",activityItems);
}

+ (UIActivityCategory)activityCategory
{
    // 决定在UIActivityViewController中显示的位置，最上面是AirDrop，中间是Share，下面是Action
    return UIActivityCategoryAction;
}

- (void)performActivity
{
    // 没有自定义的UIViewController才会调用此方法。在这里可以做一些操作，需要在最后消除掉UIActivityviewController
    [self activityDidFinish:YES];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    // 可以根据item的不同类型决定是否可以让行为服务操作
    return YES;
}

@end
