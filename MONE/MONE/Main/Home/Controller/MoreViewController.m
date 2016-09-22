//
//  MoreViewController.m
//  MONE
//
//  Created by THANAO on 12/9/16.
//  Copyright © 2016年 cz. All rights reserved.
//

#define kHomeGetByMonth @"http://v3.wufazhuce.com:8000/api/hp/bymonth"

#import "MonthViewController.h"
#import "MoreViewController.h"

@interface MoreViewController () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;

    NSInteger _month;   // 当前月份
    NSInteger _year;    // 当前年份
    NSInteger _kYear;   // 单元格显示年份
    NSInteger _kMonth;  // 单元格显示月份
    NSInteger _maxYear; // 发布总共年份
}

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"往期列表";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : kTitleFont, NSForegroundColorAttributeName : kTitleFontColor}];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置返回按钮颜色
    [self.navigationController.navigationBar setTintColor:[UIColor lightGrayColor]];
    
    
    
    [self createTableView];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM";
    _month = [[dateFormatter stringFromDate:date] integerValue];
    dateFormatter.dateFormat = @"yyyy";
    _year = [[dateFormatter stringFromDate:date] integerValue];
    _maxYear = _year - 11;

}

- (void)createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return (_year - 2012) * 12 + _month - 10 + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    // 计算单元格的时间
    _kMonth = _month - indexPath.row;
    _kYear = _year;
    for (int i = 1; i < _maxYear; i++) {
        if (indexPath.row >= 12 * (i - 1) + _month && indexPath.row < 12 * i + _month) {
            _kMonth += 12 * i;
            _kYear -= i;
            break;
        }
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%li-%02li", _kYear, _kMonth];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[kHomeGetByMonth stringByAppendingPathComponent:cell.textLabel.text] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        
        // 请求成功保存当前点击内容
        [dataArray writeToFile:kFilePath atomically:YES];
        NSLog(@"%@", kFilePath);

        MonthViewController *monthViewCtrl = [[MonthViewController alloc] init];
        monthViewCtrl.navigationItem.title = cell.textLabel.text;
        monthViewCtrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:monthViewCtrl animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    
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
