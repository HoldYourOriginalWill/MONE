//
//  BaseViewController.m
//  MONE
//
//  Created by Mac46 on 16/8/8.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "SearchViewController.h"
#import "ProfileViewController.h"
#import "BaseNavigationController.h"

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : kTitleFont, NSForegroundColorAttributeName : kTitleFontColor}];
    [self _createNavButton];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navigationItem
- (void)_createNavButton {
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [leftButton setImage:[UIImage imageNamed:@"searchIcon"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(navButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.tag = 101;
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [rightButton setImage:[UIImage imageNamed:@"nav_me_default"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(navButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.tag = 102;
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

- (void)navButtonAction:(UIButton *)sender {
    if (sender.tag == 101) {
        
        SearchViewController *searchCtrl = [[SearchViewController alloc] init];
        BaseNavigationController *searchNavCtrl = [[BaseNavigationController alloc] initWithRootViewController:searchCtrl];
        [self presentViewController:searchNavCtrl animated:YES completion:NULL];
        
        
    } else {
        
        ProfileViewController *profileCtrl = [[ProfileViewController alloc] init];
        profileCtrl.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:profileCtrl animated:YES completion:NULL];
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
