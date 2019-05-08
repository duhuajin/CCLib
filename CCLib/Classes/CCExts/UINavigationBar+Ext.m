//
//  UINavigationBar+Ext.m
//  pbp
//
//  Created by Du on 2019/1/10.
//  Copyright © 2019 LiuHeYuanJiao. All rights reserved.
//

#import "UINavigationBar+Ext.h"

@implementation UINavigationBar (Ext)

-(void)setBackColor:(UIColor*)color{
    
    UIView *v=[[UIView alloc]initWithFrame:self.bounds];
    [v setBackgroundColor:color];
    [self setValue:v forKey:@"backgroundView"];
    
}

@end
