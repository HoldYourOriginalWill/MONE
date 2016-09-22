//
//  ProfileViewController.m
//  MONE
//
//  Created by THANAO on 30/8/16.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "ProfileViewController.h"

static const NSInteger imageHeight = 200;

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate> {
    UIImageView *_headerView;
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _createTableView];
    [self _createBackButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - backButton
- (void)_createBackButton {
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 28, 18, 36)];
    [backButton setImage:[UIImage imageNamed:@"back_default"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)_createTableView {
    _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, imageHeight)];
    _headerView.image = [UIImage imageNamed:@"personalBackgroundImage"];
    _headerView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_headerView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, imageHeight)];
    view.backgroundColor = [UIColor clearColor];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.tableHeaderView = view;
    [self.view addSubview:tableView];
    
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [loginButton setImage:[UIImage imageNamed:@"personal"] forState:UIControlStateNormal];
    loginButton.layer.cornerRadius = 30;
    loginButton.layer.masksToBounds = YES;
    loginButton.center = view.center;
    [view addSubview:loginButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"请登录";
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    label.center = CGPointMake(view.center.x, view.center.y + 50);
    [view addSubview:label];
    
}

- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = @"其他设置";
    cell.imageView.image = [UIImage imageNamed:@"center_setting"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, kScreenWidth - 20, 20)];
    label.text = @"设置";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:label];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算显示的头视图
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY >= 0) {
        
        _headerView.frame = CGRectMake(0, -offsetY, kScreenWidth, imageHeight);
    } else {
        
        CGFloat height = imageHeight - offsetY;
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, height);
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
