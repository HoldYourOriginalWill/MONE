//
//  MusicViewController.m
//  One 一个
//
//  Created by Mac46 on 16/8/8.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "MusicViewController.h"
@class MusicModel;
@interface MusicViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    UIScrollView *contentScrollView;
    UITableView *contentTableView;
    NSArray *idListArray;
    AFHTTPSessionManager *manager;
    MusicModel *model;
    NSInteger buttonIndex;
    NSArray *buttonSelected;
    NSArray *UIArray;
}
@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    buttonSelected = @[@1, @0, @0];
    [self loadData];
    // Do any additional setup after loading the view.
}
#pragma mark - 加载数据
- (void)loadData{
    manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://v3.wufazhuce.com:8000/api/music/idlist/0"
      parameters:nil
        progress:NULL
         success:^(NSURLSessionDataTask *task, id responseObject) {
        idListArray = responseObject[@"data"];
        [self createScrollView];
        [self createTableViewWithIndex:0];
    }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark - 创建内容scrollView
-(void)createScrollView{
    contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 20 - 44 - 49)];
    contentScrollView.contentSize = CGSizeMake(kScreenWidth * 10, kScreenHeight - 20 - 44 - 49);
    contentScrollView.tag = 100;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.delegate = self;
    [self.view addSubview:contentScrollView];
}

#pragma mark - scrollview代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag == 100) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        NSInteger index = (NSInteger)scrollView.contentOffset.x / kScreenWidth;
        [contentTableView removeFromSuperview];
        [self createTableViewWithIndex:index];
        [hud hideAnimated:YES];
    }
}

#pragma mark - 创建表视图
- (void)createTableViewWithIndex:(NSInteger)index{
    [manager GET:[NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/music/detail/%@", idListArray[index]]
      parameters:nil
        progress:NULL 
         success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *dic = responseObject[@"data"];
            model = [MusicModel yy_modelWithDictionary:dic];
            contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(index * kScreenWidth, 0, kScreenWidth, kScreenHeight - 20 - 44 - 49)];
            contentTableView.delegate = self;
            contentTableView.dataSource = self;
            contentTableView.showsVerticalScrollIndicator = NO;
            contentTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 20);
            [contentScrollView addSubview:contentTableView];
    }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [[UIArray lastObject]floatValue];
    }else{
        return 40;
    }
    
}
#pragma mark - 表视图代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"musicID";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        UIArray = [[NSArray alloc] init];
        UIArray = [self locateUIWithModel];
        for (int i = 0; i < UIArray.count - 1; i++) {
            [cell.contentView addSubview:UIArray[i]];
        }
    }else if(indexPath.row == 1){
        UIButton *love = [self createButtonWithIndex:0 NormalImage:@"like_default" HighlightedImage:@"like_highlighted"];
        UIButton *comment = [self createButtonWithIndex:1 NormalImage:@"toolBarComment" HighlightedImage:@"toolBarComment"];
        UIButton *share = [self createButtonWithIndex:2 NormalImage:@"shareImage" HighlightedImage:@"shareImage"];
        
        UILabel *loveLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 40, 20)];
        loveLabel.text = [NSString stringWithFormat:@"%li", model.praisenum];
        loveLabel.textColor = [UIColor lightGrayColor];
        loveLabel.font = [UIFont systemFontOfSize:12];
        
        UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60 + kScreenWidth / 3, 10, 40, 20)];
        commentLabel.text = [NSString stringWithFormat:@"%li", model.commentnum];
        commentLabel.textColor = [UIColor lightGrayColor];
        commentLabel.font = [UIFont systemFontOfSize:12];
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(60 + kScreenWidth / 3 * 2, 10, 40, 20)];
        shareLabel.text = [NSString stringWithFormat:@"%li", model.sharenum];
        shareLabel.textColor = [UIColor lightGrayColor];
        shareLabel.font = [UIFont systemFontOfSize:12];
        
        [cell.contentView addSubview:love];
        [cell.contentView addSubview:comment];
        [cell.contentView addSubview:share];
        [cell.contentView addSubview:loveLabel];
        [cell.contentView addSubview:commentLabel];
        [cell.contentView addSubview:shareLabel];
    }
    return cell;
}
#pragma mark - 创建收藏，评论，分享按钮
- (UIButton *)createButtonWithIndex:(NSInteger)index NormalImage:(NSString *)normalName HighlightedImage:(NSString *)highlightedName{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30 + index * kScreenWidth / 3, 5, 30, 30)];
    [button setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedName] forState:UIControlStateHighlighted];
    return button;
}

#pragma mark - 布局
- (NSArray *)locateUIWithModel{
    float height = 0;
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:0];
    //海报
    UIImageView *poster = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight / 2)];
    [poster sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    [mArray addObject:poster];
    height = height + kScreenHeight / 2;
    //歌手视图
    UIView *authorView = [self authorView];
    [mArray addObject:authorView];
    height = height + 80;
    height = height + 10;
    //按钮
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height + 8, 100, 12)];
    typeLabel.text = @"音乐故事";
    typeLabel.font = [UIFont systemFontOfSize:12];
    typeLabel.textColor = [UIColor lightGrayColor];
    [mArray addObject:typeLabel];
    
    UIButton *essayButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 128 - 46 - 36, height, 36, 36)];
    [essayButton setImage:[UIImage imageNamed:@"music_story_default"] forState:UIControlStateNormal];
    [essayButton setImage:[UIImage imageNamed:@"music_story_selected"] forState:UIControlStateSelected];
    [essayButton addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    essayButton.tag = 200;
    essayButton.selected = [buttonSelected[0] boolValue];
    [mArray addObject:essayButton];
    UIButton *lyricButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 10 - 36 - 36 - 46, height, 36, 36)];
    [lyricButton setImage:[UIImage imageNamed:@"music_lyric_default"] forState:UIControlStateNormal];
    [lyricButton setImage:[UIImage imageNamed:@"music_lyric_selected"] forState:UIControlStateSelected];
    [lyricButton addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    lyricButton.tag = 201;
    lyricButton.selected = [buttonSelected[1] boolValue];
    [mArray addObject:lyricButton];
    UIButton *infoButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 10 - 36, height, 36, 36)];
    [infoButton setImage:[UIImage imageNamed:@"music_about_default"] forState:UIControlStateNormal];
    [infoButton setImage:[UIImage imageNamed:@"music_about_selected"] forState:UIControlStateSelected];
    [infoButton addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    infoButton.tag = 202;
    infoButton.selected = [buttonSelected[2] boolValue];
    [mArray addObject:infoButton];
    
    height = height + 40;
    height = height + 10;
    if (essayButton.selected == YES) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, kScreenWidth - 40, 200)];
        titleLabel.text = model.story_title;
        titleLabel.font = kTitleFont;
        titleLabel.numberOfLines = 0;
        [titleLabel sizeToFit];
        [mArray addObject:titleLabel];
        CGRect rect = [model.story_title boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kTitleFont} context:nil];
        height = height + rect.size.height;
        height+=5;
        UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, kScreenWidth - 40, 15)];
        authorLabel.text = model.story_author.user_name;
        authorLabel.textColor = kFontColor;
        authorLabel.font = kContentFontSize;
        [mArray addObject:authorLabel];
        height = height + 15 + 20;
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, kScreenWidth - 40, 20000)];
        contentLabel.text = [model.story stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
        contentLabel.font = kContentFontSize;
        contentLabel.numberOfLines = 0;
        [contentLabel sizeToFit];
        [mArray addObject:contentLabel];
        rect = [model.story boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kContentFontSize} context:nil];
        height = height + rect.size.height;
        height = height + 20;
        
        UILabel *edtLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, kScreenWidth - 40, 12)];
        edtLabel.text = model.charge_edt;
        edtLabel.textColor = [UIColor lightGrayColor];
        edtLabel.font = [UIFont systemFontOfSize:12];
        [mArray addObject:edtLabel];
    }else if (lyricButton.selected == YES){
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, kScreenWidth - 40, 20000)];
        
        contentLabel.text = model.lyric;
        contentLabel.font = kContentFontSize;
        contentLabel.numberOfLines = 0;
        [contentLabel sizeToFit];
        [mArray addObject:contentLabel];
        CGRect rect = [model.lyric boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kContentFontSize} context:nil];
        height = height + rect.size.height;
        height = height + 20;
        
        UILabel *edtLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, kScreenWidth - 40, 12)];
        edtLabel.text = model.charge_edt;
        edtLabel.textColor = [UIColor lightGrayColor];
        edtLabel.font = [UIFont systemFontOfSize:12];
        [mArray addObject:edtLabel];
    }else if (infoButton.selected == YES){
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, kScreenWidth - 40, 20000)];
        contentLabel.text = model.info;
        contentLabel.font = kContentFontSize;
        contentLabel.numberOfLines = 0;
        [contentLabel sizeToFit];
        [mArray addObject:contentLabel];
        CGRect rect = [model.info boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kContentFontSize} context:nil];
        height = height + rect.size.height;
        height = height + 20;
        
        UILabel *edtLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, height, kScreenWidth - 40, 12)];
        edtLabel.text = model.charge_edt;
        edtLabel.textColor = [UIColor lightGrayColor];
        edtLabel.font = [UIFont systemFontOfSize:12];
        [mArray addObject:edtLabel];
        
    }
    height = height + 12;
    height = height + 20;
    [mArray addObject:[NSNumber numberWithFloat:height]];
    return [mArray copy];
}
- (UIView *)authorView{
    UIView *authorView = [[UIView alloc] initWithFrame:CGRectMake(20, kScreenHeight / 2 - 40, kScreenWidth - 40, 120)];
    authorView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    authorView.layer.borderWidth = 1;
    authorView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    [icon sd_setImageWithURL:[NSURL URLWithString:model.author.web_url]];
    icon.layer.cornerRadius = 20;
    [authorView addSubview:icon];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, 100, 12)];
    nameLabel.text = model.author.user_name;
    nameLabel.font = [UIFont systemFontOfSize:12];
    nameLabel.textColor = kFontColor;
    [authorView addSubview:nameLabel];
    
    UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 200, 12)];
    introLabel.text = model.author.desc;
    introLabel.textColor = [UIColor lightGrayColor];
    introLabel.font = [UIFont systemFontOfSize:12];
    [authorView addSubview:introLabel];
    
    UILabel *songLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 20)];
    songLabel.text = model.title;
    songLabel.font = [UIFont systemFontOfSize:18];
    [authorView addSubview:songLabel];
    
    UIImageView *xiaMi = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 40 - 90, 25, 80, 20)];
    xiaMi.image = [UIImage imageNamed:@"xiamiLogo"];
    [authorView addSubview:xiaMi];
    
    UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 40 - 20 - 45, 50, 45, 45)];
    [playButton setImage:[UIImage imageNamed:@"play_default"] forState:UIControlStateNormal];
    [playButton setImage:[UIImage imageNamed:@"play_highlighted"] forState:UIControlStateHighlighted];
    [playButton setImage:[UIImage imageNamed:@"pause_default"] forState:UIControlStateSelected];
    [playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [authorView addSubview:playButton];
    
    return authorView;
}

#pragma mark - 按钮方法
- (void)play:(UIButton *)button{
    button.selected = !button.selected;//http://v3.wufazhuce.com:8000/api/audio/played  itemid=1015&type=music
    if (button.selected) {
        NSLog(@"开始播放");
    }else{
        NSLog(@"停止播放");
    }
    
}
- (void)selected:(UIButton *)button{
    buttonSelected = [[NSArray alloc] init];
    switch (button.tag - 200) {
        case 0:
            buttonSelected = @[@1, @0, @0];
            break;
        case 1:
            buttonSelected = @[@0, @1, @0];
            break;
        case 2:
            buttonSelected = @[@0, @0, @1];
            break;
        default:
            buttonSelected = @[@1, @0, @0];
            break;
    }
    //UIArray = [self locateUIWithModel];
    [contentTableView reloadData];
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
