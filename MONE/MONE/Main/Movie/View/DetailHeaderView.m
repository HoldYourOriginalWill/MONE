//
//  DetailHeaderView.m
//  仿One
//
//  Created by YF on 16/9/19.
//  Copyright © 2016年 ckn. All rights reserved.
//


#define kBtnLength 40

#import "DetailHeaderView.h"
#import "PostModel.h"
#import "ContentModel.h"
#import "ContentView.h"
#import "ContentViewController.h"

@implementation DetailHeaderView
{

    UIScrollView *imgS;
    NSMutableDictionary *_Dic;
    PostModel *_poster;
    ContentModel *_contentM;
    UIImageView *image;
    UILabel *infoL;
}

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData:) name:@"key" object:nil];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadData:(NSNotification *)userInfo{
    
    NSString *postUrl = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/movie/detail/%@", userInfo.userInfo[@"numID"]];
    NSString *contentUrl = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/movie/%@/story/1/0", userInfo.userInfo[@"numID"]];
    _Dic = [[NSMutableDictionary alloc] init];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:postUrl
      parameters:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
         
     }
         success:^(NSURLSessionDataTask *task, id responseObject) {
             
             _poster = [PostModel yy_modelWithDictionary:responseObject[@"data"]];
             
             [manager GET:contentUrl
               parameters:nil
                 progress:^(NSProgress * _Nonnull downloadProgress) {
                  
              }
                  success:^(NSURLSessionDataTask *task, id responseObject) {
                      
                      _Dic = responseObject[@"data"];
                      NSArray *arr = _Dic[@"data"];
                      NSDictionary *dataDic = [arr lastObject];
                      _contentM = [ContentModel yy_modelWithDictionary:dataDic];
                      [self createdPoster];
                  }
                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                      
                  }];
             
           
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {

         }];
}

- (void)createdPoster{
    
    _posterView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    [_posterView sd_setImageWithURL:[NSURL URLWithString:_poster.detailcover]];
    [self addSubview:_posterView];
    
    _scoreL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 50, 150, 60, 40)];
    _scoreL.text = _poster.score;
    _scoreL.textColor = [UIColor redColor];
    _scoreL.font = [UIFont systemFontOfSize:25];
    [self addSubview:_scoreL];
    
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 20 - kBtnLength, 200, kBtnLength, kBtnLength)];
    [shareBtn setImage:[UIImage imageNamed:@"shareImage"] forState:UIControlStateNormal];
    [self addSubview:shareBtn];
    UIButton *scoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 4 * kSpaceWidth - 70- kBtnLength, 200, 70, kBtnLength)];
    [scoreBtn setImage:[UIImage imageNamed:@"not_score"] forState:UIControlStateNormal];
    scoreBtn.titleLabel.text = @"评分";
    [self addSubview:scoreBtn];
    UILabel *storyL = [[UILabel alloc] initWithFrame:CGRectMake(kSpaceWidth * 2, 200 + 10, 120, kBtnLength/2)];
    storyL.font = [UIFont systemFontOfSize:15];
    storyL.text = @"电影故事";
    [self addSubview:storyL];


    //----------------
    _bgListV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 240, kScreenWidth, 160)];
    _bgListV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgListV];
    _bgListV.userInteractionEnabled = YES;
    [self createdBgList];
    
    imgS = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 120)];
    imgS.backgroundColor = [UIColor clearColor];
    [_bgListV addSubview:imgS];
    imgS.pagingEnabled = NO;
    imgS.showsHorizontalScrollIndicator = NO;
    imgS.showsVerticalScrollIndicator = NO;
    NSArray *arr = [_poster.photo copy];
    for (int i = 0; i < arr.count; i++) {
        
        image = [[UIImageView alloc] initWithFrame:CGRectMake(i * ((kScreenWidth - 20) / 3 + 5), 0, (kScreenWidth - 20) / 3, 115)];
        image.userInteractionEnabled = YES;
        [image sd_setImageWithURL:[NSURL URLWithString:arr[i]]];
        [imgS addSubview:image];
    }
    //CGFloat num = _poster.photo.count / 3.0 + 0.2;
    imgS.contentSize = CGSizeMake(((kScreenWidth - 20) / 3 + 5) * _poster.photo.count - 5, 120);
    
    UILabel *tL = [[UILabel alloc] initWithFrame:CGRectMake(kSpaceWidth * 2, 420, 100, kBtnLength/2)];
    tL.font = [UIFont systemFontOfSize:15];
    tL.text = @"评论列表";
    [self addSubview:tL];

}

- (void)createdBgList{
    
    UILabel *listL = [[UILabel alloc] initWithFrame:CGRectMake(kSpaceWidth * 2, 10, 120, 20)];
    listL.font = kContentFontSize;
    listL.text = @"一个.电影表";
    [_bgListV addSubview:listL];
    _infoBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - kSpaceWidth * 2 - kBtnLength, 0, kBtnLength, kBtnLength)];
    [_infoBtn setImage:[UIImage imageNamed:@"actor_default"] forState:UIControlStateNormal];
    _infoBtn.tag = 101;
    [_infoBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgListV addSubview:_infoBtn];
    _photoBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth  - 2 * (kBtnLength + kSpaceWidth), 0, kBtnLength, kBtnLength)];
    [_photoBtn setImage:[UIImage imageNamed:@"still_default"] forState:UIControlStateNormal];
    _photoBtn.tag = 102;
    [_photoBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgListV addSubview:_photoBtn];
    _keywordsBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - kSpaceWidth * 2 - 3 * kBtnLength, 0, kBtnLength, kBtnLength)];
    [_keywordsBtn setImage:[UIImage imageNamed:@"plot_default"] forState:UIControlStateNormal];
    _keywordsBtn.tag = 103;
    [_keywordsBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgListV addSubview:_keywordsBtn];
    
}

- (void)btnAction:(UIButton *)sender{
    
    if (sender.tag == 103) {
        
        ContentViewController *contentCtrl = [[ContentViewController alloc] initWithContentModel:_contentM];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:contentCtrl animated:YES completion:NULL];
        
    }else if(sender.tag == 101){
        
        NSLog(@"%@", _poster.info);
        imgS.hidden = YES;
        infoL = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, kScreenWidth - 30, 120)];
        infoL.numberOfLines = 0;
        infoL.font = [UIFont systemFontOfSize:15];
        infoL.text = _poster.info;
        [_bgListV addSubview:infoL];
    }else{
        
        imgS.hidden = NO;
        infoL.hidden = YES;
    }
    

}


@end
