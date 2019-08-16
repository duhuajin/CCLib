//
//  CCBaseCollectionViewController.m
//  DangJian
//
//  Created by Du on 2018/12/24.
//  Copyright © 2018 邹政. All rights reserved.
//

#import "CCBaseCollectionViewController.h"
#import "CCBaseHeader.h"
#import "UIColor+Hex.h"
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>

@interface CCBaseCollectionViewController ()

@property (nonatomic)BOOL hasMore;
@property (nonatomic)BOOL isReload;

@end

@implementation CCBaseCollectionViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageSize=15;
        self.pageIndex=0;
    }
    return self;
}
-(UICollectionView *)collectionView{
    if(!_collectionView){
        JHCollectionViewFlowLayout *layout=[[JHCollectionViewFlowLayout alloc]init];

        layout.minimumLineSpacing=0;
        layout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumInteritemSpacing=0;
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.alwaysBounceVertical=true;
        _collectionView.backgroundColor=[UIColor whiteColor];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.showsVerticalScrollIndicator=NO;
        
    }
    return _collectionView;
}
-(UIRefreshControl *)refreshControl{
    if(!_refreshControl){
        _refreshControl=[[UIRefreshControl alloc]init];
        [_refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshControl;
}
-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CCWeak(self);
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(ws.view);
    }];
    if(self.refreshHeaderEnable){
        [self.collectionView addSubview:self.refreshControl];
    }
    [self loadData];
    // Do any additional setup after loading the view.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSAssert(YES, @"需要重写cellForItemAtIntexPath");
    return nil;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
-(UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section{
    return [UIColor whiteColor];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-  (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor colorWithHex:0xf0f0f0]];
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor whiteColor]];
}

-(void)showLoadingView{
    [super showLoadingView];
    [self.collectionView setHidden:YES];
}

-(void)hideLoadingView{
    [self performSelector:@selector(hideLoad) withObject:nil afterDelay:0.5f];
}
-(void)hideLoad{
    [super hideLoadingView];
    [self.collectionView setHidden:NO];

}
-(void)refreshData{
    [self initData];
    [self loadData];
}

-(void)initRefresh{
    CCWeak(self);
    [self.refreshControl setEnabled:self.refreshHeaderEnable];
    if(!self.refreshFooterEnable){
        self.collectionView.mj_footer=nil;
        return;
    }
    if(!self.hasMore){
        self.collectionView.mj_footer=nil;
        return;
    }
    if(self.collectionView.mj_footer){
        return;
    }
    self.collectionView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [ws loadData];
    }];
    
}
-(void)endRefresh{
    [self hideLoadingView];
    if(self.refreshHeaderEnable){
        [self.refreshControl endRefreshing];
    }
    if(self.refreshFooterEnable){
        [self.collectionView.mj_footer endRefreshing];
    }
}

-(void)addData:(NSArray *)datas{
    if(self.isReload){
        [self.datas removeAllObjects];
        self.isReload=NO;
    }
    [self.datas addObjectsFromArray:datas];
    
    if(datas.count<self.pageSize){
        self.hasMore=NO;
    }else{
        self.hasMore=YES;
    }
    self.pageIndex+=1;
    [self endRefresh];
    [self initRefresh];
    [self.collectionView reloadData];
}

-(void)initData{
    self.isReload=YES;
    self.hasMore=NO;
    self.pageIndex=0;
    self.pageSize=15;
}

-(void)loadData{
    NSAssert(YES, @"需要重写loadData");
}

@end
