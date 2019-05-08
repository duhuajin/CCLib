//
//  UILabel+Attr.h
//  zhtc
//
//  Created by Du on 2018/1/8.
//  Copyright © 2018年 Du. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Ext)


-(void)setString:(NSString *)string toColor:(UIColor *)color font:(UIFont*)font;
-(void)setString:(NSString *)string toColor:(UIColor *)color;
-(void)setImage:(UIImage *)image at:(NSInteger)location;

@end
