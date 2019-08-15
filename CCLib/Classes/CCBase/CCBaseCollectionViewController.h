//
//  CCBaseCollectionViewController.h
//  DangJian
//
//  Created by Du on 2018/12/24.
//  Copyright © 2018 邹政. All rights reserved.
//

#import "CCBaseViewController.h"
#import "JHCollectionViewFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCBaseCollectionViewController : CCBaseViewController<JHCollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong,nonatomic)UIRefreshControl *refreshControl;
@property (strong,nonatomic)UICollectionView *collectionView;
@property (strong,nonatomic)NSMutableArray *datas;
@property (nonatomic)NSInteger pageIndex;
@property (nonatomic)NSInteger pageSize;
@property (nonatomic)BOOL refreshHeaderEnable;
@property (nonatomic)BOOL refreshFooterEnable;

/**
 重写用于加载数据
 */
-(void)loadData;

/**
 添加列表数据

 @param datas 数据,会根据pageSize判断是否还有更多数据
 */
-(void)addData:(NSArray *)datas;

-(void)initRefresh;
-(void)endRefresh;

@end

NS_ASSUME_NONNULL_END
