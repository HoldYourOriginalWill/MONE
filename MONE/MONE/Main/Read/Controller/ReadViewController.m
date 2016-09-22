//
//  ReadViewController.m
//  One 一个
//
//  Created by Mac46 on 16/8/8.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "ReadViewController.h"
@class IntroductionViewController;
@interface ReadViewController ()<SDCycleScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    NSMutableArray *imageModelArray;
    NSMutableArray *essayArray;
    NSMutableArray *serialArray;
    NSMutableArray *questionArray;
    EssayModel *essay;
    SerialModel *serial;
    QuestionModel *question;
    NSArray *cellHeightArray;
    UIScrollView *contentScrollView;
    UITableView *contentTableView;
}
@end

@implementation ReadViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据读取
- (void)loadData{
    imageModelArray = [[NSMutableArray alloc] initWithCapacity:0];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //图片数据来源
    [manager GET:@"http://v3.wufazhuce.com:8000/api/reading/carousel"
      parameters:nil
        progress:NULL
         success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dataArray = responseObject[@"data"];
        for (NSDictionary *dic in dataArray){
            ImageModel *model = [ImageModel yy_modelWithDictionary:dic];
            [imageModelArray addObject:model];
        }
        [self createTopScrollView];
    }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    //短篇，连载，问答实例来源
    [manager GET:@"http://v3.wufazhuce.com:8000/api/reading/index"
      parameters:nil
        progress:NULL 
         success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [[NSDictionary alloc] init];
        dic = responseObject[@"data"];
        
        essayArray = dic[@"essay"];
        serialArray = dic[@"serial"];
        questionArray = dic[@"question"];
        
        
        [self createContentScrollView];
        //[self createContentTableView];
    }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
#pragma mark - 视图创建
- (void)createTopScrollView{
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (ImageModel *model in imageModelArray) {
        [imageArray addObject:model.cover];
    }
    SDCycleScrollView *top = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 200) imageURLStringsGroup:imageArray];
    top.autoScrollTimeInterval = 4;
    top.placeholderImage = [UIImage imageNamed:@"top10"];
    top.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:top];
}
- (void)createContentScrollView{
    contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200 + 10, kScreenWidth, kScreenHeight - 64 - 200 - 49 - 10 - 10)];
    contentScrollView.contentSize = CGSizeMake(10 * kScreenWidth, kScreenHeight - 64 - 200 - 49 - 10 - 10);
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.delegate = self;
    contentScrollView.tag = 100;
    [self createContentTableViewWithIndex:0];
    [self.view addSubview:contentScrollView];
}
- (void)createContentTableViewWithIndex:(NSInteger)index{
    NSDictionary *dic = [[NSDictionary alloc] init];
    essay = [EssayModel yy_modelWithDictionary:essayArray[index]];
    dic = essayArray[index];
    NSArray *authorArray = dic[@"author"];
    essay.author = [AuthorModel yy_modelWithDictionary:authorArray[0]];
    serial = [SerialModel yy_modelWithDictionary:serialArray[index]];
    question = [QuestionModel yy_modelWithDictionary:questionArray[index]];
    
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:0];
    [mArray addObject:[[self locateUIBymodel:essay] objectAtIndex:3]];
    [mArray addObject:[[self locateUIBymodel:serial] objectAtIndex:3]];
    [mArray addObject:[[self locateUIBymodel:question] objectAtIndex:3]];
    cellHeightArray = [[NSArray alloc] initWithArray:mArray];
    
    contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(10 + kScreenWidth * index, 0, kScreenWidth - 20, kScreenHeight - 64 - 200 - 49 - 10 - 10)];
    
    contentTableView.layer.borderWidth = 1;
    contentTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    contentTableView.layer.cornerRadius = 6;
    contentTableView.showsVerticalScrollIndicator = NO;
    contentTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 10);
//    contentTableView.layer.shadowColor = [UIColor grayColor].CGColor;
//    contentTableView.layer.shadowOpacity = 1;
//    contentTableView.layer.shadowOffset = CGSizeMake(0, 0);
//    contentTableView.clipsToBounds = YES;
    contentTableView.dataSource = self;
    contentTableView.delegate = self;
    
    [contentScrollView addSubview:contentTableView];
}
#pragma mark - 滑动视图左右滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag == 100) {
        [contentTableView removeFromSuperview];
        NSInteger index = scrollView.contentOffset.x / 375;
        [self createContentTableViewWithIndex:index];
        contentTableView.alpha = 0;
        [UIView animateWithDuration:0.25 animations:^{
            contentTableView.alpha = 1;
        }];
    }
}

#pragma mark - 表视图代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"cellID";
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"ContentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellID];
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    }
    
    NSArray *type = @[@"readIcon", @"serialIcon", @"questionIcon"];
    cell.type.image = [UIImage imageNamed:type[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSArray *UIArray = [[NSArray alloc] init];
    if (indexPath.row == 0) {
        UIArray = [self locateUIBymodel:essay];
        cell.identity = essay.content_id;
    }else if(indexPath.row == 1){
        UIArray = [self locateUIBymodel:serial];
        cell.identity = serial.serialID;
    }else if(indexPath.row == 2){
        UIArray = [self locateUIBymodel:question];
        cell.identity = question.question_id;
    }
    for (NSInteger i = 1; i < UIArray.count; i++) {
        [cell.contentView addSubview:UIArray[i - 1]];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *cellHeight = cellHeightArray[indexPath.row];
    return cellHeight.floatValue;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ContentTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *dic = @{@"contentID" : cell.identity,
                               @"type" : [NSString stringWithFormat:@"%li", indexPath.row + 1]};
    NSArray *array = @[essayArray, serialArray, questionArray];
    IntroductionViewController *intro = [[IntroductionViewController alloc] init];
    intro.hidesBottomBarWhenPushed = YES;
    intro.content = dic;
    intro.contentArray = array[indexPath.row];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationController pushViewController:intro animated:YES];
}
#pragma mark - 图片点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    ImageModel *model = imageModelArray[index];
    CarouselView *cView = [[CarouselView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    cView.model = model;
    [[UIApplication sharedApplication].keyWindow addSubview:cView];
    [UIView animateWithDuration:0.25 animations:^{
        cView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
}

#pragma mark - 其他方法
//根据传入的model计算高度以及UI排版，返回一个数组
- (NSArray *)locateUIBymodel:(id)model{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, kScreenWidth - 100, 1000)];
    titleLabel.numberOfLines = 0;
    titleLabel.font = kTitleFont;
    titleLabel.textColor = [UIColor blackColor];
    
    UILabel *authorLabel = [[UILabel alloc] init];
    authorLabel.font = kContentFontSize;
    authorLabel.textColor = [UIColor grayColor];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = kContentFontSize;
    contentLabel.textColor = [UIColor grayColor];
    
    CGRect rect = CGRectZero;
    CGFloat height = 25;
    if ([model isKindOfClass:[EssayModel class]]) {
        EssayModel *eModel = model;
        titleLabel.text = eModel.hp_title;
        rect = [titleLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth - 100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kTitleFont} context:nil];
        height = height + rect.size.height + 10;
        authorLabel.frame = CGRectMake(10, height, kScreenWidth - 100, 10);
        authorLabel.text = eModel.author.user_name;
        height = height + 10 + 10;
        contentLabel.frame = CGRectMake(10, height, kScreenWidth - 64, 10);
        contentLabel.text = eModel.guide_word;
    }else if ([model isKindOfClass:[SerialModel class]]){
        SerialModel *sModel = model;
        titleLabel.text = sModel.title;
        rect = [titleLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth - 100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kTitleFont} context:nil];
        height = height + rect.size.height + 10;
        authorLabel.frame = CGRectMake(10, height, kScreenWidth - 100, 10);
        authorLabel.text = sModel.author.user_name;
        height = height + 10 + 10;
        contentLabel.frame = CGRectMake(10, height, kScreenWidth - 64, 10);
        contentLabel.text = sModel.excerpt;
    }else if ([model isKindOfClass:[QuestionModel class]]){
        QuestionModel *qModel = model;
        titleLabel.text = qModel.question_title;
        rect = [titleLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth - 100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kTitleFont} context:nil];
        height = height + rect.size.height + 10;
        authorLabel.frame = CGRectMake(10, height, kScreenWidth - 100, 10);
        authorLabel.text = qModel.answer_title;
        height = height + 10 + 10;
        contentLabel.frame = CGRectMake(10, height, kScreenWidth - 64, 10);
        contentLabel.text = qModel.answer_content;
    }
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:contentLabel.text];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:6.18];
    [attri addAttributes:@{NSParagraphStyleAttributeName : style} range:NSMakeRange(0, contentLabel.text.length)];
    contentLabel.attributedText = attri;
    
    rect = [contentLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth - 60, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kContentFontSize, NSParagraphStyleAttributeName : style} context:nil];
    height = height + rect.size.height;
    height = height + 25;
    
    [titleLabel sizeToFit];
    [contentLabel sizeToFit];
    [array addObject:titleLabel];
    [array addObject:authorLabel];
    [array addObject:contentLabel];
    [array addObject:[NSNumber numberWithFloat:height]];
    return [array copy];
}
@end
