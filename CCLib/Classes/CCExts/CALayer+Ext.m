//
//  CALayer+Ext.m
//  Cadres
//
//  Created by Du on 2018/8/8.
//  Copyright © 2018年 Du. All rights reserved.
//

#import "CALayer+Ext.h"
#import <objc/runtime.h>

static NSString *strKey = @"borderColorWithUIColor";

@implementation CALayer (Ext)

-(void)setBorderColorWithUIColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &strKey, color, OBJC_ASSOCIATION_COPY);
    self.borderColor=color.CGColor;
}

-(NSString *)borderColorWithUIColor
{
    return objc_getAssociatedObject(self, &strKey);
}



@end
