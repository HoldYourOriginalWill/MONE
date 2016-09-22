//
//  DayViewController.m
//  MONE
//
//  Created by Mac46 on 16/9/18.
//  Copyright © 2016年 cz. All rights reserved.
//
#import "HomePage.h"
#import "HomePageModel.h"
#import "HomePageLayout.h"
#import "ToolView.h"
#import "ActivityHead.h"
#import "CustomScrollView.h"

#import "DayViewController.h"

static const NSUInteger maxSelectedNum = 1000; // 最多能收藏的数量

@interface DayViewController () {
    HomePageModel *_dayModel;
    ToolView *_toolView;
    BOOL _isPraise;
    NSMutableDictionary *_isSelectdDic;  // 收藏字典

}

@end

@implementation DayViewController

- (instancetype)initWithDayModel:(HomePageModel *)dayModel {
    
    self = [super init];
    if (self) {
        _dayModel = dayModel;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(praise) name:@"praise" object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_title"]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:kSelectedPlist]) {
        _isSelectdDic = [NSMutableDictionary dictionaryWithContentsOfFile:kSelectedPlist];
    } else {
        _isSelectdDic = [NSMutableDictionary dictionaryWithCapacity:maxSelectedNum];
    }
    
    [self createUI];
}



- (void)createUI {
    
    _toolView = [[ToolView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 170, kScreenWidth, 44)];
    _toolView.label.text = _dayModel.praisenum;
    [self.view addSubview:_toolView];
    
    CustomScrollView *scrollView = [[CustomScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight * 1.1);
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    HomePageLayout *layout = [HomePageLayout layoutWithHomePageModel:_dayModel];
    HomePage *homePage = [[HomePage alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, layout.pageHeight)];
    [homePage setModel:_dayModel];
    [scrollView addSubview:homePage];
    
    _isPraise = [_isSelectdDic[_dayModel.hpcontent_id] boolValue];
    if (_isPraise == NO) {
        [_toolView.loveButton setImage:[UIImage imageNamed:@"like_default"] forState:UIControlStateNormal];
    } else {
        [_toolView.loveButton setImage:[UIImage imageNamed:@"like_selected"] forState:UIControlStateNormal];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - praise
- (void)praise {
    if (_isPraise == NO) {
        [_toolView.loveButton setImage:[UIImage imageNamed:@"like_selected"] forState:UIControlStateNormal];
        [_isSelectdDic setObject:@YES forKey:_dayModel.hpcontent_id];
        [_isSelectdDic writeToFile:kSelectedPlist atomically:YES];
        _isPraise = [_isSelectdDic[_dayModel.hpcontent_id] boolValue];
        
    } else {
        [_toolView.loveButton setImage:[UIImage imageNamed:@"like_default"] forState:UIControlStateNormal];
        [_isSelectdDic removeObjectForKey:_dayModel.hpcontent_id];
        [_isSelectdDic writeToFile:kSelectedPlist atomically:YES];
        _isPraise = [_isSelectdDic[_dayModel.hpcontent_id] boolValue];
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
