//
//  IntroductionViewController.m
//  One 一个
//
//  Created by XinShangjie on 16/8/25.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "IntroductionViewController.h"
@class EssayModel;
@class SerialModel;
@class QuestionModel;
@class CompleteContentView;
@interface IntroductionViewController ()<UIScrollViewDelegate>
{
    UIScrollView *contentScrollView;
    NSInteger index;
}
@end

@implementation IntroductionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor lightGrayColor]];
    
    [self createScrollView];
    
}
- (void)createScrollView{
    contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 20 - 44)];
    contentScrollView.contentSize = CGSizeMake(kScreenWidth * 10, kScreenHeight - 44 - 20);
    contentScrollView.delegate = self;
    contentScrollView.tag = 300;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:contentScrollView];
    
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([_content[@"type"]  isEqual: @"1"] | [_content[@"type"]  isEqual: @"2"]) {
        for (NSDictionary *dic in _contentArray) {
            if ([_content[@"type"] isEqual:@"1"]) {
                [mArray addObject:dic[@"content_id"]];
            }
            else{
                [mArray addObject:dic[@"id"]];
            }
        }
        
    }else{
        for (NSDictionary *dic in _contentArray) {
            [mArray addObject:dic[@"question_id"]];
        }
    }
    NSInteger i = 0;
    for (NSString *number in mArray) {
        if ([number isEqualToString:_content[@"contentID"]]) {
            index = i;
        }
        i++;
    }
    for (int i = 0; i < mArray.count; i++) {
        NSString *identity = mArray[i];
        CompleteContentView *cView = [[CompleteContentView alloc] initWithIdentity:identity type:_content[@"type"] frame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight - 44 - 20)];
        [contentScrollView addSubview:cView];
    }
    
    contentScrollView.contentOffset = CGPointMake(index * kScreenWidth, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag == 300) {
        //NSLog(@"%li", (NSInteger)(scrollView.contentOffset.x / kScreenWidth));
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
