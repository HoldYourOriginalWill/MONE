//
//  MainTabBarController.m
//  MONE
//
//  Created by Mac46 on 16/8/8.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self _createNavCtrl];
    [self _createTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建NavCtrl
- (void)_createNavCtrl {
    // 从storyBoard加载导航控制器
    NSArray *storyBoardNameArray = @[@"Home", @"Read", @"Music", @"Movie"];
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSString *storyBoardName in storyBoardNameArray) {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:storyBoardName bundle:[NSBundle mainBundle]];
        UINavigationController *navCtrl = storyBoard.instantiateInitialViewController;
        
        [mutableArray addObject:navCtrl];
    }
    self.viewControllers = [mutableArray copy];
}

#pragma mark - 创建个人的tabBarItem
- (void)_createTabBar {
    
    // 设置tabBar的透明度
    self.tabBar.translucent = NO;
    
    NSArray *titleArr = @[@"首页", @"阅读", @"音乐", @"电影"];
    NSArray *unSelectedArr = @[@"tab_home_default", @"tab_reading_default", @"tab_music_default", @"tab_movie_default"];
    NSArray *selectedArr = @[@"tab_home_selected", @"tab_reading_selected", @"tab_music_selected", @"tab_movie_selected"];
    
    for (int i = 0; i < titleArr.count; i++) {
        
        UITabBarItem *item = self.tabBar.items[i];
        
        UIImage *unselectedImage = [[UIImage imageNamed:unSelectedArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:selectedArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *title = titleArr[i];
        
        item = [item initWithTitle:title image:unselectedImage selectedImage:selectedImage];
        
        NSDictionary *dicNormal = @{NSForegroundColorAttributeName:[UIColor lightGrayColor]};
        NSDictionary *dicSelected = @{NSForegroundColorAttributeName:kFontColor};
        
        [item setTitleTextAttributes:dicNormal forState:UIControlStateNormal];
        [item setTitleTextAttributes:dicSelected forState:UIControlStateSelected];
    }
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
