//
//  CompleteContentView.m
//  One 一个
//
//  Created by mac48 on 16/9/14.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "CompleteContentView.h"
@class MBProgressHUD;
@implementation CompleteContentView
-(instancetype)initWithIdentity:(NSString *)identity type:(NSString *)type frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _identity = identity;
        _type = type;
        _UIArray = [[NSArray alloc] init];
        [self createContentView];
    }
    return self;
}
- (void)createContentView{
    NSString *urlString;
    switch ([_type integerValue]) {
        case 1:
            urlString = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/essay/%@", _identity];
            break;
        case 2:
            urlString = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/serialcontent/%@", _identity];
            break;
        case 3:
            urlString = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/question/%@", _identity];
            break;
        default:
            break;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    [manager GET:urlString
      parameters:nil
        progress:NULL
         success:^(NSURLSessionDataTask *task, id responseObject) {
             NSDictionary *dic = [[NSDictionary alloc] init];
             dic = responseObject[@"data"];
             _model = [CompleteModel yy_modelWithDictionary:dic];
             if ([_type integerValue] == 1) {
                 NSArray *array = dic[@"author"];
                 dic = array[0];
                 _model.author = [AuthorModel yy_modelWithDictionary:dic];
             }
             _author = _model.author;
             desc = _author.desc;
             wb_name = _author.wb_name;
             _UIArray = [self locateUIWithModel:_model];
             [self createTableView];
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             
         }];
    
}
#pragma mark - 创建tableView
- (void)createTableView{
    UITableView *contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44 - 20)];
    contentTableView.delegate = self;
    contentTableView.dataSource = self;
    contentTableView.showsVerticalScrollIndicator = NO;
    [self addSubview:contentTableView];
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"contentCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([_type isEqualToString:@"1"] | [_type isEqualToString:@"2"]) {
        if (indexPath.row == 0) {
            for (int i = 0; i < _UIArray.count - 2; i++) {
                UILabel *label = _UIArray[i];
                [cell.contentView addSubview:label];
            }
            UIView *view = [self createAuthorViewInWordWithIndex:0];
            [cell.contentView addSubview:view];
        }else{
            UIView *view = [self createAuthorViewInWordWithIndex:1];
            [cell.contentView addSubview:view];
        }

    }else{
        if (indexPath.row == 0) {
            for (int i = 0; i < 2; i++) {
                UILabel *label = _UIArray[i];
                [cell.contentView addSubview:label];
            }
        }else{
            for (int i = 2; i < 5; i++) {
                UILabel *label = _UIArray[i];
                [cell.contentView addSubview:label];
            }
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return [[_UIArray lastObject] floatValue];
    }else{
        return [_UIArray[_UIArray.count - 2] floatValue];
    }
}
#pragma mark - UI定位
- (NSArray *)locateUIWithModel:(CompleteModel *)model{
    CGFloat height = 0;
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:0];
    if (model.question_id == nil) {
        height = 10 + 80;
        height+=10;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, kScreenWidth - 40, 200)];
        NSString *title;
        NSString *content;
        NSString *intro;
        if (model.serialID == nil) {
            title = _model.hp_title;
            content = _model.hp_content;
            intro = _model.hp_author_introduce;
        }else{
            title = _model.title;
            content = _model.content;
            intro = _model.charge_edt;
        }
        content = [content stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"<strong>" withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"</strong>" withString:@""];
        titleLabel.text = title;
        titleLabel.font = kTitleFont;
        titleLabel.numberOfLines = 0;
        [titleLabel sizeToFit];
        //NSLog(@"%f", height);
        [mArray addObject:titleLabel];
        CGRect rect = [title boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kTitleFont} context:nil];
        height = height + rect.size.height;
        height+=10;
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, kScreenWidth - 40, 20000)];
        contentLabel.text = content;
        contentLabel.font = kContentFontSize;
        contentLabel.numberOfLines = 0;
        [contentLabel sizeToFit];
        //NSLog(@"%f", height);
        [mArray addObject:contentLabel];
        rect = [content boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kContentFontSize} context:nil];
        height = height + rect.size.height;
        height = height + 20;
        UILabel *extraLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, kScreenWidth - 40, 200)];
        extraLabel.text = intro;
        extraLabel.font = [UIFont systemFontOfSize:12];
        extraLabel.textColor = [UIColor lightGrayColor];
        extraLabel.numberOfLines = 0;
        [extraLabel sizeToFit];
        //NSLog(@"%f", height);
        [mArray addObject:extraLabel];
        rect = [content boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil];
        height = height +40;
        NSNumber *rowHeight = [NSNumber numberWithFloat:height];
        [mArray addObject:rowHeight];
        [mArray addObject:[NSNumber numberWithFloat:100]];
    }else{
        height+=20;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, height, kScreenWidth - 40, 200)];
        label.text = _model.question_title;
        label.font = kTitleFont;
        label.numberOfLines = 0;
        [label sizeToFit];
        [mArray addObject:label];
        CGRect rect = [_model.question_title boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kTitleFont} context:nil];
        height = height + rect.size.height;
        height+=40;
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, height, kScreenWidth - 40, 30000)];
        label.text = [_model.question_content stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
        label.font = kContentFontSize;
        label.numberOfLines = 0;
        [label sizeToFit];
        [mArray addObject:label];
        rect = [_model.question_content boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 30000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kContentFontSize} context:nil];
        height = height + rect.size.height;
        height+=20;
        NSNumber *firstRowHwight = [NSNumber numberWithFloat:height];
        
        height = 20;
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, height, kScreenWidth - 40, 200)];
        label.text = _model.answer_title;
        label.font = kTitleFont;
        label.numberOfLines = 0;
        [label sizeToFit];
        [mArray addObject:label];
        rect = [_model.answer_title boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kTitleFont} context:nil];
        height = height + rect.size.height;
        height+=40;
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, height, kScreenWidth - 40, 30000)];
        label.text = [_model.answer_content stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
        label.font = kContentFontSize;
        label.numberOfLines = 0;
        [label sizeToFit];
        [mArray addObject:label];
        rect = [_model.answer_content boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 30000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kContentFontSize} context:nil];
        height = height + rect.size.height;
        height+=20;
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, height, kScreenWidth - 40, 10)];
        label.text = _model.charge_edt;
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor lightGrayColor];
        [mArray addObject:label];
        height = height + 40;
        NSNumber *secondRowHwight = [NSNumber numberWithFloat:height];
        
        [mArray addObject:firstRowHwight];
        [mArray addObject:secondRowHwight];
    }
    return [mArray copy];
}
#pragma mark - 创建文章开头的作者以及结尾的作者视图 index为判定是文章开头还是文章结尾 1为开头
- (UIView *)createAuthorViewInWordWithIndex:(NSInteger)index{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 80)];
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    [icon sd_setImageWithURL:[NSURL URLWithString:_author.web_url]];
    icon.layer.cornerRadius = 20;
    [view addSubview:icon];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20 + 40 + 20, 20, kScreenWidth - 80, 20)];
    name.text = _author.user_name;
    name.textColor = kFontColor;
    name.font = [UIFont systemFontOfSize:18];
    [view addSubview:name];
    
    if (index == 0) {
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, kScreenWidth - 80, 10)];
        timeLabel.text = _model.maketime;
        timeLabel.font = [UIFont systemFontOfSize:10];
        timeLabel.textColor = [UIColor lightGrayColor];
        [view addSubview:timeLabel];
    }else if(index == 1){
        UILabel *description = [[UILabel alloc]initWithFrame:CGRectMake(80, 45, kScreenWidth - 80, 10)];
        description.text = desc;
        description.font = [UIFont systemFontOfSize:10];
        description.textColor = [UIColor lightGrayColor];
        [view addSubview:description];
        
        UILabel *wbNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 60, kScreenWidth - 80, 10)];
        wbNameLabel.text = wb_name;
        wbNameLabel.font = [UIFont systemFontOfSize:10];
        wbNameLabel.textColor = [UIColor lightGrayColor];
        [view addSubview:wbNameLabel];
    }else{
        view = nil;
    }
    return view;
}
@end
