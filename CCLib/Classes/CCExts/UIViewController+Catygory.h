//
//  UIViewController+Catygory.h
//  xingwen
//
//  Created by Du on 2017/12/21.
//  Copyright © 2017年 Du. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Catygory)

-(void)checkIsLogin:(void (^)(BOOL refresh))loginBlock;
-(void)initBase;
-(void)pop;
-(void)showMainTab;
-(BOOL)isLogin;

@end

