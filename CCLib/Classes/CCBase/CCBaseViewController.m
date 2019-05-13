//
//  BaseViewController.m
//  xingwen
//
//  Created by Du on 2017/11/27.
//  Copyright © 2017年 Du. All rights reserved.
//

#import "CCBaseViewController.h"
#import "UIColor+Hex.h"
#import "UIView+Ext.h"
@interface CCBaseViewController ()

@end

@implementation CCBaseViewController


+ (instancetype)appear {
    static CCBaseViewController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CCBaseViewController alloc]init];
    });
    return sharedInstance;
}

-(void)dealloc{
    NSLog(@"dealloc:%@",NSStringFromClass(self.class));
}

-(void)initBase{
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    self.view.backgroundColor=[UIColor whiteColor];
    if(self.navigationController){
        
        CCBaseViewController *base=[CCBaseViewController appear];
        
        UIImage *backImage=base.backImage;
        if(self.backImage){
            backImage=self.backImage;
        }
        if(self.navigationController.viewControllers[0]!=self&&backImage){
            UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:backImage] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
            self.navigationItem.leftBarButtonItem=item;
        }
    }
}

-(void)pop{
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)pop:(NSInteger)index{
    NSArray *controllers=self.navigationController.viewControllers;
    if(controllers.count-index-1>0){
        UIViewController *c=controllers[controllers.count-index-1];
        [self.navigationController popToViewController:c animated:YES];
    }
}

-(BOOL)hidesBottomBarWhenPushed{
    if([self.navigationController.viewControllers indexOfObject:self]==0){
        return NO;
    }
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBase];
    

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)shouldAutorotate{
    return NO;
}
-(void)showLoadingView{
    [self.view showLoadingView];
}

-(void)hideLoadingView{
    [self.view hideLoadingView];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
