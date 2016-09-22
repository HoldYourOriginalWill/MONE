//
//  MonthViewController.m
//  MONE
//
//  Created by Mac46 on 16/9/13.
//  Copyright © 2016年 cz. All rights reserved.
//

#import "MonthCell.h"
#import "MonthDataLayout.h"
#import "MonthCollectionViewLayout.h"
#import "DayViewController.h"

#import "MonthViewController.h"

@interface MonthViewController () <UICollectionViewDataSource, UICollectionViewDelegate, MonthCollectionViewLayoutDelegate> {
    
    CGFloat _height;
    CGFloat _width;
    NSMutableArray *_layoutArray;
    NSMutableArray *_dataArray;
}

@property (strong, nonatomic) UICollectionView *collectionView;

@end

static NSString * const CZMonthCellID = @"monthCell";

@implementation MonthViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self setupLayout];
    
}

- (void)loadData {
    _layoutArray = [[NSMutableArray alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    NSArray *array = [NSArray arrayWithContentsOfFile:kFilePath];
    for (NSDictionary *dic in array) {
        
        MonthDataModel *model = [MonthDataModel yy_modelWithDictionary:dic];
        [_dataArray addObject:model];
        
        MonthDataLayout *layout = [MonthDataLayout layoutWithMonthDataModel:model];
        [_layoutArray addObject:layout];
    }
    
}

- (void)setupLayout {
    
    //创建布局
    MonthCollectionViewLayout *layout = [[MonthCollectionViewLayout alloc] init];
    layout.delegate = self;
    
    //创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.9];
    [self.view addSubview:collectionView];
    
    //注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MonthCell class]) bundle:nil] forCellWithReuseIdentifier:CZMonthCellID];
    self.collectionView = collectionView;
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MonthCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CZMonthCellID forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.item];
    return cell;
}

#pragma mark - MonthCollectionViewLayoutDelegate
- (CGFloat)waterflowlayout:(MonthCollectionViewLayout *)waterlayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
    
    MonthDataLayout *layout = _layoutArray[index];
    return itemWidth * layout.height / layout.width;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DayViewController *dayViewCtrl = [[DayViewController alloc] initWithDayModel:_dataArray[indexPath.item]];
    [self.navigationController pushViewController:dayViewCtrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
