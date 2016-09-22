//
//  ContentViewController.m
//  MONE
//
//  Created by Mac46 on 16/9/21.
//  Copyright © 2016年 cz. All rights reserved.
//
#import "ContentView.h"


#import "ContentViewController.h"

@interface ContentViewController () {
    ContentModel *_contentM;
}

@end

@implementation ContentViewController

- (instancetype)initWithContentModel:(ContentModel *)model {
    self = [super init];
    if (self) {
        _contentM = model;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissCtrl) name:@"dismissCtrl" object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createSubView];
}

- (void)createSubView {
    
    ContentView *view = [[ContentView alloc] init];
    view.frame = CGRectMake(0, 20, kScreenWidth, kScreenHeight);
    view.backgroundColor = [UIColor whiteColor];
    [view makeViewWithImageURLStr:_contentM.user.web_url username:_contentM.user.user_name content:_contentM.content];
    view.contentSize = CGSizeMake(kScreenWidth, view.height);
    [self.view addSubview:view];

}

- (void)dismissCtrl {
    [self dismissViewControllerAnimated:YES completion:NULL];
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
