//
//  UIColor+Hex.h
//  Maintenance
//
//  Created by 杜华金 on 14-7-28.
//  Copyright (c) 2014年 ___SOBEY___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

+ (UIColor*)separatorColor;
+ (UIColor*)mainColor;
+ (UIColor*)naviColor;

@end
