//
//  CCPreviewController.h
//  changdu
//
//  Created by Du on 2018/7/12.
//  Copyright © 2018年 Du. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseViewController.h"

@interface CCPreviewController : CCBaseViewController

@property (strong,nonatomic)NSString *url;
@property (strong,nonatomic)NSArray *urls;

@property (readonly,strong,nonatomic)UIView *contentView;

@end
