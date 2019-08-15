//
//  CCBaseTableViewController.m
//  pbp
//
//  Created by Du on 2019/1/11.
//  Copyright © 2019 LiuHeYuanJiao. All rights reserved.
//

#import "CCBaseTableViewController.h"
#import "CCBaseHeader.h"
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>

@interface CCBaseTableViewController ()

@property (nonatomic)BOOL hasMore;
@property (nonatomic)BOOL isReload;

@end

@implementation CCBaseTableViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.tableView addSubview:self.refreshControl];
        self.pageSize=15;
        self.pageIndex=0;
    }
    return self;
}
-(UITableView *)tableView{
    if(!_tableView){
        _tableView=[[UITableView alloc]init];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CCWeak(self);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(ws.view);
    }];
    [self loadData];
    // Do any additional setup after loading the view.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}


-(void)showLoadingView{
    [super showLoadingView];
    [self.tableView setHidden:YES];
}

-(void)hideLoadingView{
    [self performSelector:@selector(hideLoad) withObject:nil afterDelay:0.5f];
}
-(void)hideLoad{
    [super hideLoadingView];
    [self.tableView setHidden:NO];
    
}

-(void)refreshData{
    [self initData];
    [self loadData];
}

-(void)initRefresh{
    CCWeak(self);
    [self.refreshControl setEnabled:self.refreshHeaderEnable];
    if(!self.refreshFooterEnable){
        self.tableView.mj_footer=nil;
        return;
    }
    if(!self.hasMore){
        self.tableView.mj_footer=nil;
        return;
    }
    if(self.tableView.mj_footer){
        return;
    }
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [ws loadData];
    }];
    
}
-(void)endRefresh{
    [self hideLoadingView];
    if(self.refreshHeaderEnable){
        [self.refreshControl endRefreshing];
    }
    if(self.refreshFooterEnable){
        [self.tableView.mj_footer endRefreshing];
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
    [self.tableView reloadData];
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
