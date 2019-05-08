//
//  UIColor+Hex.m
//  Maintenance
//
//  Created by 杜华金 on 14-7-28.
//  Copyright (c) 2014年 ___SOBEY___. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor*) colorWithHex:(long)hexColor;
{
    return [UIColor colorWithHex:hexColor alpha:1.];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}
+(UIColor *)separatorColor{
   return  [UIColor colorWithHex:0xe6e6e6];
}

+(UIColor *)mainColor{
    return  [UIColor colorWithHex:0x189bff];
}
+(UIColor *)naviColor{
    return  [UIColor colorWithHex:0xdb292a];
}
@end
