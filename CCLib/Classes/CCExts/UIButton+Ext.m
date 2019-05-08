//
//  UIButton+CCButton.m
//  Home
//
//  Created by Du on 2018/1/11.
//  Copyright © 2018年 Du. All rights reserved.
//

#import "UIButton+Ext.h"
#import "UIColor+Hex.h"
@implementation UIButton (Ext)



+(instancetype)cc_buttonFillWithTitle:(NSString*)string{
    UIButton *b=[UIButton buttonWithType:UIButtonTypeCustom];
    [b setTitle:string forState:UIControlStateNormal];
    [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [b.layer setCornerRadius:5.0f];
    [b.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [b setBackgroundColor:[UIColor mainColor]];
    return b;
}
+(instancetype)cc_buttonBorderWithTitle:(NSString*)string{
    UIButton *b=[UIButton buttonWithType:UIButtonTypeCustom];
    [b setTitle:string forState:UIControlStateNormal];
    [b setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
    [b.layer setBorderWidth:1.0f];
    [b.layer setBorderColor:[UIColor mainColor].CGColor];
    [b.layer setCornerRadius:5.0f];
    [b.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    return b;
}

@end
