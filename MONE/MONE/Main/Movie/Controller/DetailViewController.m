//
//  DetailViewController.m
//  仿One
//
//  Created by Mac47 on 16/9/12.
//  Copyright © 2016年 ckn. All rights reserved.
//

#import "DetailViewController.h"
#import <AVKit/AVKit.h>
#import "PraiseandModel.h"
#import "CommentTableViewCell.h"

#import "CommentLayer.h"
#import "DetailHeaderView.h"

@interface DetailViewController ()<UITableViewDataSource, UITableViewDelegate>

{
    NSString *_numStr;
    NSMutableDictionary *_dataDic;
    UITableView *_commentTableView;
    NSMutableArray *_dataArr;
    PraiseandModel *_praM;
   
    DetailHeaderView *_header;
    
}

//@property (nonatomic, strong) AVPlayer *player;

@end

@implementation DetailViewController

- (instancetype)init{
    
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createdDetailView:) name:@"IDStr" object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    [self.navigationController.navigationBar setTintColor:[UIColor lightGrayColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : kTitleFont, NSForegroundColorAttributeName : kTitleFontColor}];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)createdDetailView:(NSNotification *)userInfo{
    _numStr = [NSString stringWithFormat:@"%@", userInfo.userInfo[@"idStr"]];
    _header = [[DetailHeaderView alloc] init];
    NSDictionary *dic = @{@"numID" : _numStr};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"key" object:nil userInfo:dic];

}

- (void)loadData{
    
    NSString *postUrl = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/movie/%@/0", _numStr];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    _dataDic = [[NSMutableDictionary alloc] init];
    _dataArr = [[NSMutableArray alloc] init];
    [manager GET:postUrl
      parameters:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
         
     }
         success:^(NSURLSessionDataTask *task, id responseObject) {
             
             _dataDic = responseObject[@"data"];
             NSArray *arr = _dataDic[@"data"];
             for (NSDictionary *dic in arr) {
                 _praM = [PraiseandModel yy_modelWithDictionary:dic];
                 [_dataArr addObject:_praM];
             }
            [self createdCommentTableView];
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             
         }];
}



- (void)createdCommentTableView{

    _commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
    _commentTableView.backgroundColor = [UIColor clearColor];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    
    _header.frame = CGRectMake(0, 0, kScreenWidth, 460);
    _header.userInteractionEnabled = YES;
    _commentTableView.tableHeaderView = _header;
    
    [self.view insertSubview:_commentTableView atIndex:0];
    
    [_commentTableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"commentCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"commentCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PraiseandModel *pM = _dataArr[indexPath.row];
    [cell setModel:pM];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PraiseandModel *pM = _dataArr[indexPath.row];
    CommentLayer *layer = [CommentLayer layerWithPraiseandModel:pM];
    return [layer cellHeight];
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
