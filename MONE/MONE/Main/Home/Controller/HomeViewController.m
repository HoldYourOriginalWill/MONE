//
//  HomeViewController.m
//  MONE
//
//  Created by Mac46 on 16/8/8.
//  Copyright © 2016年 cz. All rights reserved.
//

#define kHomeGetUrlString @"http://v3.wufazhuce.com:8000/api/hp/more/0"

#import "ToolView.h"
#import "HomePage.h"
#import "HomePageLayout.h"
#import "CustomScrollView.h"
#import "MoreViewController.h"
#import "ActivityHead.h"
#import "AFNetworkReachabilityManager.h"

#import "HomeViewController.h"

static const CGFloat maxOffset = 9.2;   // 滑到多少弹出MonthViewController
static const CGFloat spaceWidth = 10;   // 视图边缘间隙
static const NSUInteger maxSelectedNum = 1000;  // 最多能收藏的数量

@interface HomeViewController () {
    HomePage *_defaultHomePage; // 默认的首页视图
    NSMutableArray *_dataArray; // 获取到的数据数组
    NSMutableArray *_homePageArray;
    ToolView *_toolView;        // 创建点赞、分享、笔记等按钮的组合view
    NSInteger _currentIndex;    // 当前滑动的位置
    BOOL _isPraise;
    NSMutableDictionary *_isSelectdDic; // 点赞数据持久化字典
    
    NSArray *_activities;               // 分享
    NSArray *_excludedActivityTypes;
    
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_title"]];
    [self createSubviews];
    [self loadData];

    // ToolView发送的通知
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(share) name:@"share" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(praise) name:@"praise" object:nil];
    // HomePage发送的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save:) name:@"save" object:nil];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:kSelectedPlist]) {
        _isSelectdDic = [NSMutableDictionary dictionaryWithContentsOfFile:kSelectedPlist];
    } else {
        _isSelectdDic = [NSMutableDictionary dictionaryWithCapacity:maxSelectedNum];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - createSubviews
- (void)createSubviews {
    
    // 无网络情况首页默认视图
    _defaultHomePage = [[HomePage alloc] initWithFrame:CGRectMake(kSpaceWidth * 2, kSpaceWidth * 2, kScreenWidth - kSpaceWidth * 4, 400)];
    [self.view addSubview:_defaultHomePage];
    _toolView = [[ToolView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 170, kScreenWidth, 44)];
    [self.view addSubview:_toolView];
    
    _activities = @[[[WechatActivity alloc] init],
                    [[WechatMomentActivity alloc] init],
                    [[WeiboActivity alloc] init],
                    [[QQActivity alloc] init],
                    [[CollectActivity alloc] init],
                    [[CopyActivity alloc] init],
                    [[SaveImageActivity alloc] init],
                    [[NightModeActivity alloc] init]];

    _excludedActivityTypes = @[UIActivityTypePostToFacebook,
                               UIActivityTypePostToTwitter,
                               UIActivityTypePostToWeibo,
                               UIActivityTypeMessage,UIActivityTypeMail,
                               UIActivityTypePrint,
                               UIActivityTypeCopyToPasteboard,
                               UIActivityTypeAssignToContact,
                               UIActivityTypeSaveToCameraRoll,
                               UIActivityTypeAddToReadingList,
                               UIActivityTypePostToFlickr,
                               UIActivityTypePostToVimeo,
                               UIActivityTypePostToTencentWeibo,
                               UIActivityTypeAirDrop,
                               UIActivityTypeOpenInIBooks];
    
}

#pragma mark - 数据加载
- (void)loadData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:kHomeGetUrlString
      parameters:nil
        progress:NULL
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSArray *dataArray = responseObject[@"data"];
              // 数据请求成功，则默认视图hidden设为yes
             _defaultHomePage.hidden = YES;
             
             _dataArray = [[NSMutableArray alloc] init];
             _homePageArray = [[NSMutableArray alloc] init];
              // 创建滑动视图
             CustomScrollView *scrollView = [[CustomScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
             scrollView.contentSize = CGSizeMake(kScreenWidth * dataArray.count, kScreenHeight * 1.2);
             scrollView.delegate = self;
             [self.view addSubview:scrollView];
            
             for (int i = 0; i < dataArray.count; i++) {
                 NSDictionary *dic = dataArray[i];
                
                 HomePageModel *model = [HomePageModel yy_modelWithDictionary:dic];
                 [_dataArray addObject:model];
                 HomePageLayout *layout = [HomePageLayout layoutWithHomePageModel:model];
                 HomePage *homePage = [[HomePage alloc] initWithFrame:CGRectMake(spaceWidth + i * kScreenWidth, spaceWidth, kScreenWidth - spaceWidth * 2, layout.pageHeight)];
                 [homePage setModel:model];
                 [_homePageArray addObject:homePage];
                 [scrollView addSubview:homePage];
             }
             
             HomePageModel *modelZero = _dataArray[0];
             _toolView.label.text = modelZero.praisenum;
             _isPraise = [_isSelectdDic[modelZero.hpcontent_id] boolValue];
             if (_isPraise == NO) {
                [_toolView.loveButton setImage:[UIImage imageNamed:@"like_default"] forState:UIControlStateNormal];
             } else {
                [_toolView.loveButton setImage:[UIImage imageNamed:@"like_selected"] forState:UIControlStateNormal];
             }
            
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
    }];
    
}

#pragma mark - scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isSelectdDic = [NSMutableDictionary dictionaryWithContentsOfFile:kSelectedPlist];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat fIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    _currentIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 判断滑动是否超过半页，修改toolView相关内容
    if ((fIndex - _currentIndex) >= 0.5) {
        _currentIndex += 1;
    }
    
    _toolView.label.text = ((HomePageModel *)(_dataArray[_currentIndex])).praisenum;
    _isPraise = [_isSelectdDic[((HomePageModel *)(_dataArray[_currentIndex])).hpcontent_id] boolValue];
    if (_isPraise == NO) {
        [_toolView.loveButton setImage:[UIImage imageNamed:@"like_default"] forState:UIControlStateNormal];
    } else {
        [_toolView.loveButton setImage:[UIImage imageNamed:@"like_selected"] forState:UIControlStateNormal];
    }

    
    if (fIndex > maxOffset) {
        MoreViewController *moreCtrl = [[MoreViewController alloc] init];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
        moreCtrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:moreCtrl animated:YES];
    }
}

#pragma mark - notification
- (void)share {
    HomePageModel *model = _dataArray[_currentIndex];
    HomePage *page = _homePageArray[_currentIndex];
    
    if (model && page) {
        NSString *textToShare = model.hp_content;
        UIImage *image = page.hp_img_original_url.image;
        NSURL *url = model.web_url;
        
        NSArray *activityItems = @[image, textToShare, url];

        
        UIActivityViewController *activityCtrl = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:_activities];
        activityCtrl.excludedActivityTypes = _excludedActivityTypes;
        [self presentViewController:activityCtrl animated:YES completion:NULL];
    }
}

- (void)praise {
    
    
    if (_isPraise == NO) {
        
        if (((HomePageModel *)(_dataArray[_currentIndex])).hpcontent_id) {
            
            [_toolView.loveButton setImage:[UIImage imageNamed:@"like_selected"] forState:UIControlStateNormal];
            [_isSelectdDic setObject:@YES forKey:((HomePageModel *)(_dataArray[_currentIndex])).hpcontent_id];
            [_isSelectdDic writeToFile:kSelectedPlist atomically:YES];
            
            _isPraise = [_isSelectdDic[((HomePageModel *)(_dataArray[_currentIndex])).hpcontent_id] boolValue];
        }
        
    } else {
        
        [_toolView.loveButton setImage:[UIImage imageNamed:@"like_default"] forState:UIControlStateNormal];
        [_isSelectdDic removeObjectForKey:((HomePageModel *)(_dataArray[_currentIndex])).hpcontent_id];
        [_isSelectdDic writeToFile:kSelectedPlist atomically:YES];
        _isPraise = [_isSelectdDic[((HomePageModel *)(_dataArray[_currentIndex])).hpcontent_id] boolValue];
    }
}


- (void)save:(NSNotification *)info {
    UIImage *image = info.userInfo[@"image"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [ UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL];
    
    [alert addAction:action];
    [alert addAction:cancelAction];
    [self.navigationController presentViewController:alert animated:YES completion:NULL];
    
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    if (!error) {
        alertCtrl.title = @"保存成功";
    } else {
        alertCtrl.title = @"保存失败";
    }
    [self.navigationController presentViewController:alertCtrl animated:YES completion:NULL];
    
    [alertCtrl dismissViewControllerAnimated:YES completion:NULL];
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
