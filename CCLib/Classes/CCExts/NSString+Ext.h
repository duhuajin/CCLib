//
//  NSString+CCString.h
//  Home
//
//  Created by Du on 2018/1/11.
//  Copyright © 2018年 Du. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Ext)

-(NSDate*)cc_dateFromFormatter:(NSString*)formatter;

-(NSString*)fixTime;
-(NSString*)formatDate:(NSString*)format;

- (instancetype)MD5;

+(instancetype)timeWithString:(NSString *)time;

-(CGSize)sizeWithFont:(UIFont *)font size:(CGSize)size;

-(BOOL)isNumber;

- (NSString *)cc_urlEncode;
- (NSString *)cc_urlDecode;

- (NSString *)cc_getUrlParamValueForKey:(NSString*)key;

+(NSString*)getHHmmss:(NSTimeInterval)time;
-(NSString *)urlAddCompnentForValue:(NSString *)value key:(NSString *)key;

@end
