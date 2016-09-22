//
//  SearchViewController.m
//  MONE
//
//  Created by THANAO on 30/8/16.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () {
    UITextField *_textField;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _createNavItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - createUI
- (void)_createNavItem {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor lightGrayColor];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 50, 30)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    _textField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchIcon"]];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.placeholder = @"输入搜索内容";
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_textField becomeFirstResponder];
    self.navigationItem.titleView = _textField;

}

#pragma mark - dismissAction
- (void)dismissAction {
    [_textField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:NULL];
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
