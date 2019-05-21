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

@property (strong,nonatomic)UIImage *backImage;
@property (copy,nonatomic)void(^needRefreshBlock)(void);
@property (nonatomic)BOOL hideNavi;
@property (nonatomic)float realHeight;

+ (instancetype)appear ; //初始化一个通用的baseviewcontroller 用于设置样式,如返回按钮
-(void)pop:(NSInteger)index;
-(void)pop;
-(void)showLoadingView;
-(void)hideLoadingView;
-(void)initBase;

@end
