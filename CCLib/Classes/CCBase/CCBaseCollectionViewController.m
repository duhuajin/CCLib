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
@interface CCBaseCollectionViewController ()

@end

@implementation CCBaseCollectionViewController

-(UICollectionView *)collectionView{
    if(!_collectionView){
        JHCollectionViewFlowLayout *layout=[[JHCollectionViewFlowLayout alloc]init];

        layout.minimumLineSpacing=0;
        layout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumInteritemSpacing=0;
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor=[UIColor whiteColor];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.showsVerticalScrollIndicator=NO;
        
    }
    return _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    CCWeak(self);
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(ws.view);
    }];
    // Do any additional setup after loading the view.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
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

@end
