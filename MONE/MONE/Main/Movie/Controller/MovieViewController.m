//
//  MovieViewController.m
//  仿One
//
//  Created by Mac47 on 16/8/3.
//  Copyright © 2016年 ckn. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieTableViewCell.h"
#import "DetailViewController.h"


#define kMoiveAPI @"http://v3.wufazhuce.com:8000/api/movie/list/0"

@interface MovieViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_dataArr;
    NSMutableArray *_idArr;
    NSArray *_noNetImageArray;
}

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    _noNetImageArray = @[@"movieList_placeholder_0.png", @"movieList_placeholder_1.png", @"movieList_placeholder_2.png", @"movieList_placeholder_3.png", @"movieList_placeholder_4.png", @"movieList_placeholder_5.png", @"movieList_placeholder_6.png", @"movieList_placeholder_7.png", @"movieList_placeholder_8.png", @"movieList_placeholder_9.png", @"movieList_placeholder_10.png", @"movieList_placeholder_11.png"];
    
    _idArr = [[NSMutableArray alloc] init];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self loadMoiveData];
    [self createMovieTableView];
}


//创建电影界面的表视图
-(void)createMovieTableView{
    
    UITableView *movieTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 - 64) style:UITableViewStylePlain];
    movieTableView.backgroundColor = [UIColor whiteColor];
    movieTableView.dataSource = self;
    movieTableView.delegate = self;
    [movieTableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:movieTableView];
}

-(void)loadMoiveData{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    _dataArr = [[NSMutableArray alloc] init];
    
    [manager GET:kMoiveAPI
      parameters:nil
        progress:NULL 
         success:^(NSURLSessionDataTask *task, id responseObject) {
             
             NSArray *array = responseObject[@"data"];
             [_dataArr addObjectsFromArray:array];
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             
             
         }];
    
}

#pragma mark ---------data Source--------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if (_dataArr.count == 0) {
        return _noNetImageArray.count;
    }
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[MovieTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArr.count == 0) {
        
        cell.postView.image = [UIImage imageNamed:_noNetImageArray[indexPath.row]];
        
    } else {
        
        NSDictionary *dataDic = _dataArr[indexPath.row];
        
        [_idArr addObject:dataDic[@"id"]];
        
        if (![dataDic[@"score"] isKindOfClass:[NSNull class]]) {
            cell.scoreLabel.text = dataDic[@"score"];
        }
        [cell.postView sd_setImageWithURL:dataDic[@"cover"]];

    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}

#pragma mark ------delegate----------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detailView = [[DetailViewController alloc] init];
    //NSLog(@"%@", _idArr[indexPath.row]);
    
    if (_dataArr.count == 0) {
        NSLog(@"无内容");
    } else {
        
        NSDictionary *dic = @{@"idStr" : _idArr[indexPath.row]};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"IDStr" object:nil userInfo:dic];
        
        detailView.navigationItem.title = _dataArr[indexPath.row][@"title"];
        [self.navigationController pushViewController:detailView animated:YES];
    }
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
