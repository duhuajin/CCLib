//
//  BaseViewController.h
//  xingwen
//
//  Created by Du on 2017/11/27.
//  Copyright © 2017年 Du. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Ext.h"

@interface CCBaseViewController : UIViewController

+ (instancetype)appear ; //初始化一个通用的baseviewcontroller 用于设置样式,如返回按钮
@property (strong,nonatomic)UIImage *backImage;

-(void)pop:(NSInteger)index;
-(void)pop;

@property (nonatomic)BOOL hideNavi;

@property (copy,nonatomic)void(^needRefreshBlock)(void);


-(void)showLoadingView;
-(void)hideLoadingView;

-(void)initBase;

@end
