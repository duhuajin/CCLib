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

@property (strong,nonatomic)UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
