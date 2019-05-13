//
//  CCBaseTableViewController.h
//  pbp
//
//  Created by Du on 2019/1/11.
//  Copyright © 2019 LiuHeYuanJiao. All rights reserved.
//

#import "CCBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCBaseTableViewController : CCBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
