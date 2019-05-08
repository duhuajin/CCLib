////
////  UIViewController+Catygory.m
////  xingwen
////
////  Created by Du on 2017/12/21.
////  Copyright © 2017年 Du. All rights reserved.
////
//
//#import "UIViewController+Catygory.h"
//
//#import "CCLoginViewController.h"
//#import "AppDelegate.h"
//@implementation UIViewController (Catygory)
//
//-(void)checkIsLogin:(void (^)(BOOL refresh))loginBlock{
//    if(LoginData&&loginBlock){
//        loginBlock(NO);
//        return;
//    }
//    if(!LoginData){
//        UIWindow *window=[UIApplication sharedApplication].keyWindow;
//        CCLoginViewController *c=[[CCLoginViewController alloc]init];
//        c.loginBlock = loginBlock;
//        window.rootViewController=c;
//        [window makeKeyAndVisible];
//    }
//}
//-(BOOL)isLogin{
//    if(LoginData){
//        return YES;
//    }
//    return NO;
//}
//
//-(void)initBase{
//    
//    self.view.backgroundColor=[UIColor whiteColor];
//    if(self.navigationController){
//        if(self.navigationController.viewControllers[0]!=self){
//            UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
//            self.navigationItem.leftBarButtonItem=item;
//        }
//    }
//    
////    self.extendedLayoutIncludesOpaqueBars = true;
////    self.automaticallyAdjustsScrollViewInsets = false;
//
//}
//-(void)pop{
//    if(self.navigationController){
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}
//
//-(void)showMainTab{
//    AppDelegate *app=CCAppDelegate;
//    [app showApp];
//}
//
//
//
//@end

