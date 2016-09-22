//
//  CarouselView.m
//  One 一个
//
//  Created by XinShangjie on 16/9/11.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CarouselView.h"

@implementation CarouselView
@class CarouselContentModel;
@class CarouselTableViewCell;
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)setModel:(ImageModel *)model{
    carouselContentArray = [[NSArray alloc] init];
    heightArray = [[NSArray alloc] init];
    allHeight = 0;
    _model = model;
    //添加背景颜色
    self.backgroundColor = [self colorWithHex:model.bgcolor alpha:1];
    //关闭图标
    close = [[UIButton alloc] initWithFrame:CGRectMake(5, 20, 50, 50)];
    [close setImage:[UIImage imageNamed:@"close_default_wight"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];

    [self createTableView];
    [contentTableView addSubview:close];
}
- (void)createTableView{
    //创建表视图
    contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight)];
    contentTableView.delegate = self;
    contentTableView.dataSource = self;
    contentTableView.backgroundColor = [UIColor clearColor];
    contentTableView.showsVerticalScrollIndicator = NO;
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/reading/carousel/%li", _model.imageID]
      parameters:nil
        progress:NULL 
         success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [NSArray array];
        array = responseObject[@"data"];
        NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < array.count; i++) {
            CarouselContentModel *model = [CarouselContentModel yy_modelWithDictionary:array[i]];
            [mArray addObject:model];
        }
        carouselContentArray = [mArray copy];
        heightArray = [self locateByModelArray:carouselContentArray];
        [self addSubview:contentTableView];
        //NSLog(@"%f", allHeight);
    }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark - 关闭按钮
- (void)closeView{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    }];
}

#pragma mark - 根据16进制数字获取颜色
- (UIColor *)colorWithHex:(NSString *)color alpha:(float)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

#pragma mark - 表视图协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return carouselContentArray.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"cellID";
    CarouselTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CarouselTableViewCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == 0) {
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 70 - 20, kScreenWidth, 18)];
        title.text = _model.title;
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:title];
    }else if(indexPath.row == carouselContentArray.count){
        UILabel *bottom = [[UILabel alloc] init];
        CGRect rect = [_model.bottom_text boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil];
        bottom.frame = CGRectMake((kScreenWidth - rect.size.width) / 2, (kScreenHeight - kScreenWidth / 2 + 10) * 0.5, rect.size.width, rect.size.height);
        bottom.text = _model.bottom_text;
        bottom.textAlignment = NSTextAlignmentCenter;
        bottom.textColor = [UIColor whiteColor];
        bottom.font = [UIFont systemFontOfSize:18];
        bottom.numberOfLines = 0;
        //bottom.center = CGPointMake(kScreenWidth / 2, kScreenHeight * 0.5);
        [bottom sizeToFit];
        [cell.contentView addSubview:bottom];
        
        bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kScreenWidth / 2 + 10 - 20, kScreenWidth, kScreenWidth / 2 - 10)];
        [bottomImageView sd_setImageWithURL:_model.cover];
        [cell.contentView addSubview:bottomImageView];
        bottomImageViewCenter = bottomImageView.center;
        
    }else{
        UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 10, 12)];
        number.text = [NSString stringWithFormat:@"%li", indexPath.row];
        number.font = [UIFont italicSystemFontOfSize:12];
        number.textColor = [UIColor whiteColor];
        [cell.contentView addSubview:number];
        cell.model = carouselContentArray[indexPath.row - 1];
        
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 70;
    }else if(indexPath.row == carouselContentArray.count){
        return kScreenHeight;
    }else{
        return [heightArray[indexPath.row - 1] floatValue];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    close.frame = CGRectMake(5, 20 + scrollView.contentOffset.y, 50, 50);
    
//    NSLog(@"%f,%f", scrollView.contentSize.height - kScreenHeight, scrollView.contentOffset.y);
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - kScreenHeight) {
        CGFloat larger = (scrollView.contentOffset.y / (scrollView.contentSize.height - kScreenHeight) - 1) * 6.18 + 1;
        bottomImageView.frame = CGRectMake(0, 0, kScreenWidth * larger, (kScreenWidth / 2 - 10) * larger);
        bottomImageView.center = CGPointMake(kScreenWidth / 2, bottomImageViewCenter.y + (scrollView.contentOffset.y) - (scrollView.contentSize.height - kScreenHeight));
        //NSLog(@"图片中心点：%f, %f", bottomImageViewCenter.x, bottomImageViewCenter.y);
    }
//    NSLog(@"%f", scrollView.contentOffset.y);
}
#pragma mark - 根据传入的模型数组返回单元格高度的数组
- (NSArray *)locateByModelArray:(NSArray *)modelArray{
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (CarouselContentModel *model in modelArray) {
        CGFloat height = 40;
        CGRect rect = [model.title boundingRectWithSize:CGSizeMake(kScreenWidth - 100, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18]} context:nil];
        height = height + rect.size.height;
        height+=5;
        height+=12;
        height+=5;
        rect = [model.introduction boundingRectWithSize:CGSizeMake(kScreenWidth - 80, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil];
        height = height + rect.size.height;
        height+=10;
        [mArray addObject:[NSNumber numberWithFloat:height]];
    }
    for (NSNumber *number in mArray) {
        allHeight = allHeight + [number floatValue];
    }
    return [mArray copy];
}
@end
