//
//  UILabel+Attr.m
//  zhtc
//
//  Created by Du on 2018/1/8.
//  Copyright © 2018年 Du. All rights reserved.
//

#import "UILabel+Ext.h"
#import "UIColor+Hex.h"
@implementation UILabel (Ext)

-(void)setString:(NSString *)string toColor:(UIColor *)color font:(UIFont*)font{
    NSRange range=[self.text rangeOfString:string];
    if(range.location!=NSNotFound){
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.text];
        [attr addAttribute:NSForegroundColorAttributeName value:color range:range];
        [attr addAttribute:NSFontAttributeName value:font range:range];
        self.attributedText=attr;
    }
}

-(void)setString:(NSString *)string toColor:(UIColor *)color{
    [self setString:string toColor:color font:self.font];
}

-(void)setImage:(UIImage *)image at:(NSInteger)location{
    

    
    CGFloat imgH = self.font.pointSize;
    CGFloat imgW = (image.size.width / image.size.height) * imgH;
    //计算文字padding-top ，使图片垂直居中
    CGFloat textPaddingTop = (self.font.lineHeight - self.font.pointSize) / 2;
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image =image;
    attachment.bounds = CGRectMake(0, -textPaddingTop , imgW, imgH);
    
    NSMutableAttributedString *attributedString ;
    if(self.attributedText){
        attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }else{
        attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];

    }
    [attributedString insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:location];

    self.attributedText=attributedString;

    
}

@end
